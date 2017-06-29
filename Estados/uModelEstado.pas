unit uModelEstado;

interface

uses
  System.SysUtils, Vcl.Dialogs, FireDAC.Comp.Client, Data.DB, FireDAC.DApt,
  uClassDBConnectionSingleton, FireDAC.VCLUI.Wait, FireDAC.Stan.Async, FireDAC.Phys.MySQLWrapper,
  uDtoEstado, uInterfaceModelEstado, uListaEstado, uEnumeradorCamposEstado;

type
  TModelEstado = class(TInterfacedObject, IModelEstado)
  public
    oQuery: TFDQuery;
    function Inserir(const ADtoEstado: TDtoEstado): Boolean;
    function Editar(const ADtoEstado: TDtoEstado): Boolean;
    function Excluir(const ADtoEstado: TDtoEstado): Boolean;
    function VerificarEstadoCadastrado(const ADtoEstado: TDtoEstado): TCamposEstado;
    // listar os estados na Grid
    function Listar: Boolean;
    // listar os estados no combo box do cadastro de municipios
    function ListarEstados(var ALista: TListaEstado): Boolean;
    function CountRegistros: integer;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TModelEstado }

function TModelEstado.CountRegistros: integer;
var
  newQuery: TFDQuery;
begin
  newQuery := TFDQuery.Create(nil);
  try
    newQuery.Connection := oQuery.Connection;
    newQuery.Open('SELECT COUNT(idestado) quantidade FROM estado');
    Result := newQuery.FieldByName('quantidade').AsInteger;
  finally
    FreeAndNil(newQuery);
  end;
end;

constructor TModelEstado.Create;
begin
  oQuery := TFDQuery.Create(nil);
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
end;

destructor TModelEstado.Destroy;
begin
  if assigned(oQuery) then
    FreeAndNil(oQuery);
  inherited;
end;

function TModelEstado.Editar(const ADtoEstado: TDtoEstado): Boolean;
begin
  Result := False;
  oQuery.ExecSQL('UPDATE estado SET uf = ' + QuotedStr(ADtoEstado.UF) + ', nome = ' +
    QuotedStr(ADtoEstado.nome) + ' WHERE idestado = ' + IntToStr(ADtoEstado.IdEstado));
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelEstado.Excluir(const ADtoEstado: TDtoEstado): Boolean;
begin
  Result := False;
  try
    oQuery.ExecSQL('DELETE FROM estado WHERE idestado = ' + IntToStr(ADtoEstado.IdEstado));
    if oQuery.RowsAffected > 0 then
      Result := True;
  except
    on E: EMySQLNativeException do
    begin
      if Pos('Cannot delete or update a parent row: a foreign key constraint fails', E.Message) > 0
      then
        ShowMessage('Existem municípios associados a este Estado');
    end;
  end;
end;

function TModelEstado.Inserir(const ADtoEstado: TDtoEstado): Boolean;
begin
  Result := False;
  oQuery.ExecSQL('INSERT INTO estado(nome, uf) VALUES(' + QuotedStr(ADtoEstado.nome) + ', ' +
    QuotedStr(ADtoEstado.UF) + ');');
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelEstado.Listar: Boolean;
begin
  Result := False;
  oQuery.Open('SELECT idestado, uf, nome FROM estado ORDER BY idestado ASC');
  if not(oQuery.IsEmpty) then
    Result := True;
end;

function TModelEstado.ListarEstados(var ALista: TListaEstado): Boolean;
var
  oDtoEstado: TDtoEstado;
begin
  Result := False;
  oQuery.Open('select IdEstado, Nome from Estado');
  if (not(oQuery.IsEmpty)) then
  begin
    oQuery.First;
    while (not(oQuery.Eof)) do
    begin
      oDtoEstado := TDtoEstado.Create;
      oDtoEstado.IdEstado := oQuery.FieldByName('IdEstado').AsInteger;
      oDtoEstado.nome := oQuery.FieldByName('Nome').AsString;

      ALista.Add(oDtoEstado.nome, oDtoEstado);

      oQuery.Next;
    end;
    Result := True;
  end;
end;

function TModelEstado.VerificarEstadoCadastrado(const ADtoEstado: TDtoEstado): TCamposEstado;
begin
  Result := ResultOK;
  // testa se nao recebe id
  if ADtoEstado.IdEstado = 0 then
  begin
    // se IdEstado = 0 verifica somente nome ou  UF do estado
    // seleciona no banco o nome
    oQuery.Open('SELECT Nome FROM Estado WHERE nome = ' + QuotedStr(ADtoEstado.nome));
    // testa se o retorno do banco de dados é vazio
    if not(oQuery.IsEmpty) then
      // se nao for vazio, já existe Estado cadastrado com este nome
      Result := resultNome;

    // seleciona UF no banco
    oQuery.Open('SELECT UF FROM Estado WHERE UF = ' + QuotedStr(ADtoEstado.UF));
    // testa se o retorno do banco de dados é vazio
    if not(oQuery.IsEmpty) then
      // se nao for vazio, já existe Estado cadastrado com este UF
      Result := resultUF;
  end
  else if ADtoEstado.IdEstado <> 0 then
  begin
    // nome estado
    oQuery.Open('SELECT nome FROM estado WHERE nome = ' + QuotedStr(ADtoEstado.nome) +
      ' AND idestado <> ' + IntToStr(ADtoEstado.IdEstado));
    // testa se o retorno do banco de dados é vazio
    if not(oQuery.IsEmpty) then
      // se nao for vazio, já existe Estado cadastrado com este nome
      Result := resultNome;

    // UF estado
    oQuery.Open('SELECT UF FROM estado WHERE uf = ' + QuotedStr(ADtoEstado.UF) + ' AND idestado <> '
      + IntToStr(ADtoEstado.IdEstado));
    // testa se o retorno do banco de dados é vazio
    if not(oQuery.IsEmpty) then
      // se nao for vazio, já existe Estado cadastrado com este UF
      Result := resultUF;
  end

end;

end.
