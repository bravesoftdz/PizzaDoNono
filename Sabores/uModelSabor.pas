unit uModelSabor;

interface

uses
  System.SysUtils, Vcl.Dialogs, FireDAC.Comp.Client, Data.DB, FireDAC.DApt,
  uClassDBConnectionSingleton, FireDAC.VCLUI.Wait, FireDAC.Stan.Async,
  uDtoSabor, uInterfaceModelSabor;

type
  TModelSabor = class(TInterfacedObject, IModelSabor)
  public
    oQuery: TFDQuery;
    function Inserir(const oDtoSabor: TDtoSabor): Boolean;
    function Listar: Boolean;
    function Editar(const oDtoSabor: TDtoSabor): Boolean;
    function VerificarSaborCadastrado(var ADtoSabor: TDtoSabor): Boolean;
    function Excluir(const ADtoSabor: TDtoSabor): Boolean;
    function CountRegistros: integer;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TEstadoModel }

function TModelSabor.CountRegistros: integer;
var
  newQuery: TFDQuery;
begin
  newQuery := TFDQuery.Create(nil);
  try
    newQuery.Connection := oQuery.Connection;
    newQuery.Open('SELECT COUNT(idsabor) quantidade FROM sabor');
    Result := newQuery.FieldByName('quantidade').AsInteger;
  finally
    FreeAndNil(newQuery);
  end;
end;


constructor TModelSabor.Create;
begin
  oQuery := TFDQuery.Create(nil);
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
end;

destructor TModelSabor.Destroy;
begin
  if assigned(oQuery) then
    FreeAndNil(oQuery);
  inherited;
end;

function TModelSabor.Editar(const oDtoSabor: TDtoSabor): Boolean;
begin
  Result := False;
  oQuery.ExecSQL('UPDATE sabor SET nome, valor = ' + QuotedStr(oDtoSabor.Nome) +
    ',' + QuotedStr(oDtoSabor.Valor) +
    '  WHERE idsabor = ' + IntToStr(oDtoSabor.IdSabor));
 if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelSabor.Excluir(const ADtoSabor: TDtoSabor): Boolean;
begin
  Result := False;
  oQuery.ExecSQL('DELETE FROM sabor WHERE idsabor = ' +
    IntToStr(ADtoSabor.IdSabor));
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelSabor.Inserir(const oDtoSabor: TDtoSabor): Boolean;
begin
  Result := False;

  oQuery.ExecSQL('INSERT INTO sabor(nome,valor) VALUES(' + QuotedStr(oDtoSabor.Nome)+ ','
  + QuotedStr(oDtoSabor.Valor)+ ');');
  Result := True;
end;

function TModelSabor.Listar: Boolean;
begin
  Result := False;

  oQuery.Open('SELECT idSabor ID, Nome, Valor FROM sabor ORDER BY idSabor ASC');
  if not(oQuery.IsEmpty) then
    Result := True;
end;

function TModelSabor.VerificarSaborCadastrado(var ADtoSabor
  : TDtoSabor): Boolean;
begin
  Result := False;

  // testa se nao recebe id
  if ADtoSabor.IdSabor = 0 then
  begin
    // se idSabor = 0 verifica somente nome do Sabor
    // seleciona no banco o nome
    oQuery.Open('SELECT nome FROM Sabor WHERE nome = ' + QuotedStr(ADtoSabor.Nome));
    // testa se o retorno do banco de dados é vazio
    if not(oQuery.IsEmpty) then
      // se nao for vazio, já existe Sabor cadastrado com este nome
      Result := True;
  end
  else if ADtoSabor.IdSabor <> 0 then
  begin
    oQuery.Open('SELECT nome FROM Sabor ' + QuotedStr(ADtoSabor.Nome) +
      ' AND idsabor <> ' + IntToStr(ADtoSabor.IdSabor));
    // testa se o retorno do banco de dados é vazio
    if not(oQuery.IsEmpty) then
      // se nao for vazio, já existe Sabor cadastrado com este nome
      Result := True;
  end;

end;

end.
