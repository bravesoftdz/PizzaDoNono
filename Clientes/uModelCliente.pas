unit uModelCliente;

interface

uses
  System.SysUtils, Vcl.Dialogs, FireDAC.Comp.Client, Data.DB, FireDAC.DApt,
  uClassDBConnectionSingleton, FireDAC.VCLUI.Wait, FireDAC.Stan.Async,
  uDtoCliente, uInterfaceModelCliente;

type
  TModelCliente = class(TInterfacedObject, IModelCliente)
  public
    oQuery: TFDQuery;
    function Inserir(const oDtoCliente: TDtoCliente): Boolean;
    function Editar(const oDtoCliente: TDtoCliente): Boolean;
    function Listar: Boolean;
    function VerificarClienteCadastrado(var ADtoCliente: TDtoCliente): Boolean;
    function BuscarEstado(var ADtoCliente: TDtoCliente): Boolean;
    function Excluir(const ADtoCliente: TDtoCliente): Boolean;
    function CountRegistros: integer;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TModelCliente }

function TModelCliente.BuscarEstado(var ADtoCliente: TDtoCliente): Boolean;
begin
  Result := False;
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
  oQuery.Open('SELECT e.idestado FROM Cliente b ' +
    'LEFT JOIN municipio m ON b.municipio_idmunicipio = m.idmunicipio ' +
    'LEFT JOIN estado e ON m.estado_idestado = e.idestado WHERE b.idCliente = ' +
    IntToStr(ADtoCliente.idCliente));
  if not(oQuery.IsEmpty) then
  begin
    ADtoCliente.Estado := oQuery.FieldByName('idestado').AsInteger;
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
  oQuery.ExecSQL('UPDATE Cliente SET nome = ' + QuotedStr(oDtoCliente.Nome) +
    ', municipio_idmunicipio = ' + IntToStr(oDtoCliente.Municipio) + ' WHERE idCliente = ' +
    IntToStr(oDtoCliente.idCliente));
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelCliente.Excluir(const ADtoCliente: TDtoCliente): Boolean;
begin
  Result := False;
  oQuery.ExecSQL('DELETE FROM Cliente WHERE idCliente = ' + IntToStr(ADtoCliente.idCliente));
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelCliente.Inserir(const oDtoCliente: TDtoCliente): Boolean;
begin
  Result := False;
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
  oQuery.ExecSQL('INSERT INTO Cliente(nome, municipio_idmunicipio) VALUES(' +
    QuotedStr(oDtoCliente.Nome) + ', ' + IntToStr(oDtoCliente.Municipio) + ');');
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelCliente.Listar: Boolean;
begin
  Result := False;
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
  oQuery.Open('SELECT b.idCliente ID, b.Nome Nome, m.Nome Município FROM Cliente b ' +
    'LEFT JOIN municipio m ON b.municipio_idmunicipio = m.idmunicipio ORDER BY b.municipio_idmunicipio, b.nome ASC');
  if not(oQuery.IsEmpty) then
    Result := True;
end;

function TModelCliente.VerificarClienteCadastrado(var ADtoCliente: TDtoCliente): Boolean;
begin
  Result := False;
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;

  // testa se nao recebe id
  if ADtoCliente.idCliente = 0 then
  begin
    // se idCliente = 0 verifica somente nome do Cliente
    // seleciona no banco o nome
    oQuery.Open('SELECT Nome FROM Cliente WHERE municipio_idmunicipio = ' +
      IntToStr(ADtoCliente.Municipio) + ' AND Nome = ' + QuotedStr(ADtoCliente.Nome));
    // testa se o retorno do banco de dados é vazio
    if not(oQuery.IsEmpty) then
      // se nao for vazio, já existe Cliente cadastrado com este nome
      Result := True;
  end
  else if ADtoCliente.idCliente <> 0 then
  begin
    oQuery.Open('SELECT Nome FROM Cliente WHERE municipio_idmunicipio = ' +
      IntToStr(ADtoCliente.Municipio) + ' AND Nome = ' + QuotedStr(ADtoCliente.Nome) +
      ' AND idCliente <> ' + IntToStr(ADtoCliente.idCliente));
    // testa se o retorno do banco de dados é vazio
    if not(oQuery.IsEmpty) then
      // se nao for vazio, já existe Cliente cadastrado com este nome
      Result := True;
  end;

end;

end.
