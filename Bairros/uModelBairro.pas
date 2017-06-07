unit uModelBairro;

interface

uses
  System.SysUtils, Vcl.Dialogs, FireDAC.Comp.Client, Data.DB, FireDAC.DApt,
  uClassDBConnectionSingleton, FireDAC.VCLUI.Wait, FireDAC.Stan.Async,
  uDtoBairro, uInterfaceModelBairro;

type
  TModelBairro = class(TInterfacedObject, IModelBairro)
  public
    oQuery: TFDQuery;
    function Inserir(const oDtoBairro: TDtoBairro): Boolean;
    function Editar(const oDtoBairro: TDtoBairro): Boolean;
    function Listar: Boolean;
    function VerificarBairroCadastrado(var ADtoBairro: TDtoBairro): Boolean;
    function BuscarEstado(var ADtoBairro: TDtoBairro): Boolean;
    function Excluir(const ADtoBairro: TDtoBairro): Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TEstadoModel }

function TModelBairro.BuscarEstado(var ADtoBairro: TDtoBairro): Boolean;
begin
  Result := False;
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
  oQuery.Open('SELECT e.idestado FROM bairro b ' + 'LEFT JOIN municipio m ON b.municipio_idmunicipio = m.idmunicipio ' +
    'LEFT JOIN estado e ON m.estado_idestado = e.idestado WHERE b.idbairro = ' + IntToStr(ADtoBairro.idBairro));
  if not(oQuery.IsEmpty) then
  begin
    ADtoBairro.Estado := oQuery.FieldByName('idestado').AsInteger;
    Result := True
  end;
end;

constructor TModelBairro.Create;
begin
  oQuery := TFDQuery.Create(nil);
end;

destructor TModelBairro.Destroy;
begin
  if assigned(oQuery) then
    FreeAndNil(oQuery);
  inherited;
end;

function TModelBairro.Editar(const oDtoBairro: TDtoBairro): Boolean;
begin
  Result := False;
  oQuery.ExecSQL('UPDATE bairro SET nome = ' + QuotedStr(oDtoBairro.Nome) + ', municipio_idmunicipio = ' +
    IntToStr(oDtoBairro.Municipio) + ' WHERE idbairro = ' + IntToStr(oDtoBairro.idBairro));
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelBairro.Excluir(const ADtoBairro: TDtoBairro): Boolean;
begin
  Result := False;
  oQuery.ExecSQL('DELETE FROM bairro WHERE idbairro = ' + IntToStr(ADtoBairro.idBairro));
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelBairro.Inserir(const oDtoBairro: TDtoBairro): Boolean;
begin
  Result := False;
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
  oQuery.ExecSQL('INSERT INTO Bairro(nome, municipio_idmunicipio) VALUES(' + QuotedStr(oDtoBairro.Nome) + ', ' +
    IntToStr(oDtoBairro.Municipio) + ');');
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelBairro.Listar: Boolean;
begin
  Result := False;
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
  oQuery.Open('SELECT b.idBairro ID, b.Nome Nome, m.Nome Município FROM Bairro b ' +
    'LEFT JOIN municipio m ON b.municipio_idmunicipio = m.idmunicipio ORDER BY idBairro ASC');
  if not(oQuery.IsEmpty) then
    Result := True;
end;

function TModelBairro.VerificarBairroCadastrado(var ADtoBairro: TDtoBairro): Boolean;
begin
  Result := False;
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;

  // testa se nao recebe id
  if ADtoBairro.idBairro = 0 then
  begin
    // se idBairro = 0 verifica somente nome do bairro
    // seleciona no banco o nome
    oQuery.Open('SELECT Nome FROM Bairro WHERE municipio_idmunicipio = ' + IntToStr(ADtoBairro.Municipio) +
      ' AND Nome = ' + QuotedStr(ADtoBairro.Nome));
    // testa se o retorno do banco de dados é vazio
    if not(oQuery.IsEmpty) then
      // se nao for vazio, já existe Bairro cadastrado com este nome
      Result := True;
  end
  else if ADtoBairro.idBairro <> 0 then
  begin
    oQuery.Open('SELECT Nome FROM Bairro WHERE municipio_idmunicipio = ' + IntToStr(ADtoBairro.Municipio) +
      ' AND Nome = ' + QuotedStr(ADtoBairro.Nome) + ' AND idbairro <> ' + IntToStr(ADtoBairro.idBairro));
    // testa se o retorno do banco de dados é vazio
    if not(oQuery.IsEmpty) then
      // se nao for vazio, já existe Bairro cadastrado com este nome
      Result := True;
  end;

end;

end.
