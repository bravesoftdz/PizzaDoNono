unit uModelCliente;

interface

uses
  System.SysUtils, Vcl.Dialogs, FireDAC.Comp.Client, Data.DB, FireDAC.DApt,
  uClassDBConnectionSingleton, FireDAC.VCLUI.Wait, FireDAC.Stan.Async,
  uDtoCliente, uInterfaceModelCliente, uEnumeradorTipoPessoa;

type
  TModelCliente = class(TInterfacedObject, IModelCliente)
  public
    oQuery: TFDQuery;
    function Inserir(const oDtoCliente: TDtoCliente): Boolean;
    function Editar(const oDtoCliente: TDtoCliente): Boolean;
    function Listar: Boolean;
    function VerificarCelularClienteCadastrado(var ADtoCliente: TDtoCliente): Boolean;
    function VerificarTelefoneClienteCadastrado(var ADtoCliente: TDtoCliente): Boolean;
    function BuscarBairro(var ADtoCliente: TDtoCliente): Boolean;
    function Excluir(const ADtoCliente: TDtoCliente): Boolean;
    function CountRegistros: integer;
    function VerificarTipoPessoa(var ADtoCliente: TDtoCliente): Boolean;
    function BuscarEnderecoCliente(var ADtoCliente: TDtoCliente): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TModelCliente }

function TModelCliente.BuscarEnderecoCliente(var ADtoCliente: TDtoCliente): Boolean;
begin
  Result := False;
  oQuery.Open('SELECT idendereco, rua, numero, complemento, bairro_idbairro ' +
    ' FROM endereco WHERE cliente_idcliente = ' + IntToStr(ADtoCliente.idCliente) +
    ' AND enderecoprincipal = 1');
  if not(oQuery.IsEmpty) then
  begin
    ADtoCliente.IdEndereço := oQuery.FieldByName('idendereco').AsInteger;
    ADtoCliente.rua := oQuery.FieldByName('rua').AsString;
    ADtoCliente.numero := oQuery.FieldByName('numero').AsString;
    ADtoCliente.complemento := oQuery.FieldByName('complemento').AsString;
    ADtoCliente.Bairro := oQuery.FieldByName('bairro_idbairro').AsInteger;
    Result := True;
  end;
end;

function TModelCliente.BuscarBairro(var ADtoCliente: TDtoCliente): Boolean;
begin
  Result := False;
  oQuery.Open('SELECT m.idmunicipio municipio, uf.idestado estado FROM endereco e ' +
    'LEFT JOIN bairro b ON e.bairro_idbairro = b.idbairro ' +
    'LEFT JOIN municipio m ON b.municipio_idmunicipio = m.idmunicipio ' +
    'LEFT JOIN estado uf on m.estado_idestado = uf.idestado WHERE e.cliente_idCliente = ' +
    IntToStr(ADtoCliente.idCliente));
  if not(oQuery.IsEmpty) then
  begin
    ADtoCliente.Estado := oQuery.FieldByName('estado').AsInteger;
    ADtoCliente.Municipio := oQuery.FieldByName('municipio').AsInteger;
    Result := True
  end;
end;

function TModelCliente.CountRegistros: integer;
var
  newQuery: TFDQuery;
begin
  newQuery := TFDQuery.Create(nil);
  try
    newQuery.Connection := oQuery.Connection;
    newQuery.Open('SELECT COUNT(idCliente) quantidade FROM cliente');
    Result := newQuery.FieldByName('quantidade').AsInteger;
  finally
    FreeAndNil(newQuery);
  end;
end;

constructor TModelCliente.Create;
begin
  oQuery := TFDQuery.Create(nil);
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
end;

destructor TModelCliente.Destroy;
begin
  if assigned(oQuery) then
    FreeAndNil(oQuery);
  inherited;
end;

function TModelCliente.Editar(const oDtoCliente: TDtoCliente): Boolean;
begin
  Result := False;
  oQuery.ExecSQL('UPDATE Cliente SET nome = ' + QuotedStr(oDtoCliente.Nome) + ', ' + 'telefone = ' +
    QuotedStr(oDtoCliente.Telefone) + ', ' + 'celular = ' + QuotedStr(oDtoCliente.celular) + ', ' +
    'dataNascimento = ' + QuotedStr(oDtoCliente.DataNascimento) + ', ' + 'cpfcnpj = ' +
    QuotedStr(oDtoCliente.CpfCnpj) + ' WHERE idCliente = ' + IntToStr(oDtoCliente.idCliente));
  oQuery.ExecSQL('UPDATE endereco SET rua = ' + QuotedStr(oDtoCliente.rua) + ', ' + 'numero = ' +
    QuotedStr(oDtoCliente.numero) + ', ' + 'complemento = ' + QuotedStr(oDtoCliente.complemento) +
    ', ' + 'bairro_idbairro = ' + IntToStr(oDtoCliente.Bairro) + ' WHERE cliente_idCliente = ' +
    IntToStr(oDtoCliente.idCliente) + ' AND enderecoPrincipal = 1');
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelCliente.Excluir(const ADtoCliente: TDtoCliente): Boolean;
begin
  Result := False;
  oQuery.ExecSQL('DELETE FROM endereco WHERE cliente_idCliente = ' + IntToStr(ADtoCliente.idCliente));
  oQuery.ExecSQL('DELETE FROM Cliente WHERE idCliente = ' + IntToStr(ADtoCliente.idCliente));
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelCliente.Inserir(const oDtoCliente: TDtoCliente): Boolean;
var
  tipoPessoa: string;
begin
  Result := False;
  if oDtoCliente.tipoPessoa = resultPessoaJuridica then
    tipoPessoa := '0'
  else if oDtoCliente.tipoPessoa = resultPessoaFisica then
    tipoPessoa := '1'
  else if oDtoCliente.tipoPessoa = resultVazio then
    tipoPessoa := EmptyStr;
  oQuery.ExecSQL
    ('INSERT INTO Cliente(nome, telefone, celular, cpfcnpj, tipoPessoa, dataNascimento) VALUES(' +
    QuotedStr(oDtoCliente.Nome) + ', ' + QuotedStr(oDtoCliente.Telefone) + ', ' +
    QuotedStr(oDtoCliente.celular) + ', ' + QuotedStr(oDtoCliente.CpfCnpj) + ', ' +
    QuotedStr(tipoPessoa) + ', ' + QuotedStr(oDtoCliente.DataNascimento) + ');');
  oQuery.ExecSQL
    ('INSERT INTO Endereco (rua, numero, complemento, bairro_idbairro, cliente_idcliente, enderecoPrincipal) VALUES('
    + QuotedStr(oDtoCliente.rua) + ', ' + QuotedStr(oDtoCliente.numero) + ', ' +
    QuotedStr(oDtoCliente.complemento) + ', ' + IntToStr(oDtoCliente.Bairro) + ', ' +
    ' (select LAST_INSERT_ID()), 1);');
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelCliente.Listar: Boolean;
begin
  Result := False;

  oQuery.Open
    ('SELECT idCliente ID, Nome, Telefone, Celular, CpfCnpj "CPF/CNPJ", dataNascimento "Data de Nascimento" '
    + ' FROM Cliente ORDER BY Nome ASC');
  if not(oQuery.IsEmpty) then
    Result := True;
end;

function TModelCliente.VerificarCelularClienteCadastrado(var ADtoCliente: TDtoCliente): Boolean;
begin
  Result := False;

  // testa se nao recebe id
  if ADtoCliente.idCliente = 0 then
  begin
    // se idCliente = 0 verifica telefone e/ou celular do Cliente SEM clausula de "WHERE idCliente = ..."
    if ADtoCliente.celular <> EmptyStr then
    begin
      // seleciona no banco o Celular
      oQuery.Open('SELECT Celular FROM Cliente WHERE Celular = ' + QuotedStr(ADtoCliente.celular));
      // testa se o retorno do banco de dados é vazio
      if not(oQuery.IsEmpty) then
        // se nao for vazio, já existe Cliente cadastrado com este Celular
        Result := True;
    end;
  end
  else if ADtoCliente.idCliente <> 0 then
  begin
    // se idCliente <> 0 verifica telefone e/ou celular do Cliente COM clausula de "WHERE idCliente = ..."
    if ADtoCliente.celular <> EmptyStr then
    begin
      oQuery.Open('SELECT Celular FROM Cliente WHERE Celular = ' + QuotedStr(ADtoCliente.celular) +
        ' AND idCliente <> ' + IntToStr(ADtoCliente.idCliente));
      // testa se o retorno do banco de dados é vazio
      if not(oQuery.IsEmpty) then
        // se nao for vazio, já existe Cliente cadastrado com este celular
        Result := True;
    end;
  end;

end;

function TModelCliente.VerificarTelefoneClienteCadastrado(var ADtoCliente: TDtoCliente): Boolean;
begin
  Result := False;
  // testa se nao recebe id
  if ADtoCliente.idCliente = 0 then
  begin
    // se idCliente = 0 verifica telefone e/ou celular do Cliente SEM clausula de "WHERE idCliente = ..."
    if ADtoCliente.Telefone <> EmptyStr then
    begin
      // seleciona no banco o Telefone
      oQuery.Open('SELECT Telefone FROM Cliente WHERE Telefone = ' +
        QuotedStr(ADtoCliente.Telefone));
      // testa se o retorno do banco de dados é vazio
      if not(oQuery.IsEmpty) then
        // se nao for vazio, já existe Cliente cadastrado com este Telefone
        Result := True;
    end;
  end
  else if ADtoCliente.idCliente <> 0 then
  begin
    // se idCliente <> 0 verifica telefone e/ou celular do Cliente COM clausula de "WHERE idCliente = ..."
    if ADtoCliente.Telefone <> EmptyStr then
    begin
      oQuery.Open('SELECT Telefone FROM Cliente WHERE Telefone = ' + QuotedStr(ADtoCliente.Telefone)
        + ' AND idCliente <> ' + IntToStr(ADtoCliente.idCliente));
      // testa se o retorno do banco de dados é vazio
      if not(oQuery.IsEmpty) then
        // se nao for vazio, já existe Cliente cadastrado com este Telefone
        Result := True;
    end;
  end;
end;

function TModelCliente.VerificarTipoPessoa(var ADtoCliente: TDtoCliente): Boolean;
begin
  Result := False;
  oQuery.Open('SELECT tipoPessoa FROM cliente WHERE idcliente = ' +
    IntToStr(ADtoCliente.idCliente) + ';');

  if not(oQuery.IsEmpty) then
  begin
    if oQuery.FieldByName('tipoPessoa').AsBoolean = True then
      ADtoCliente.tipoPessoa := resultPessoaFisica
    else if oQuery.FieldByName('tipoPessoa').AsBoolean = False then
      ADtoCliente.tipoPessoa := resultPessoaJuridica
    else
      ADtoCliente.tipoPessoa := resultVazio;
    Result := True;
  end;
end;

end.
