unit uModelIngrediente;

interface

uses
  System.SysUtils, Vcl.Dialogs, FireDAC.Comp.Client, Data.DB, FireDAC.DApt,
  uClassDBConnectionSingleton, FireDAC.VCLUI.Wait, FireDAC.Stan.Async,
  uDtoIngrediente, uInterfaceModelIngrediente;

type
  TModelIngrediente = class(TInterfacedObject, IModelIngrediente)
  public
    oQuery: TFDQuery;
    function Inserir(const oDtoIngrediente: TDtoIngrediente): Boolean;
    function Listar: Boolean;
    function Editar(const oDtoIngrediente: TDtoIngrediente): Boolean;
    function VerificarIngredienteCadastrado(var ADtoIngrediente: TDtoIngrediente): Boolean;
    function Excluir(const ADtoIngrediente: TDtoIngrediente): Boolean;
    function CountRegistros: integer;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TEstadoModel }

function TModelIngrediente.CountRegistros: integer;
var
  newQuery: TFDQuery;
begin
  newQuery := TFDQuery.Create(nil);
  try
    newQuery.Connection := oQuery.Connection;
    newQuery.Open('SELECT COUNT(idingrediente) quantidade FROM ingrediente');
    Result := newQuery.FieldByName('quantidade').AsInteger;
  finally
    FreeAndNil(newQuery);
  end;
end;


constructor TModelIngrediente.Create;
begin
  oQuery := TFDQuery.Create(nil);
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
end;

destructor TModelIngrediente.Destroy;
begin
  if assigned(oQuery) then
    FreeAndNil(oQuery);
  inherited;
end;

function TModelIngrediente.Editar(const oDtoIngrediente: TDtoIngrediente): Boolean;
begin
  Result := False;
  oQuery.ExecSQL('UPDATE ingrediente SET nome = ' + QuotedStr(oDtoIngrediente.Nome) +
    ' WHERE idingrediente = ' + IntToStr(oDtoIngrediente.IdIngrediente));
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelIngrediente.Excluir(const ADtoIngrediente: TDtoIngrediente): Boolean;
begin
  Result := False;
  oQuery.ExecSQL('DELETE FROM ingrediente WHERE idingrediente = ' +
    IntToStr(ADtoIngrediente.IdIngrediente));
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelIngrediente.Inserir(const oDtoIngrediente: TDtoIngrediente): Boolean;
begin
  Result := False;
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
  oQuery.ExecSQL('INSERT INTO ingrediente(nome) VALUES(' + QuotedStr(oDtoIngrediente.Nome) + ');');
  Result := True;
end;

function TModelIngrediente.Listar: Boolean;
begin
  Result := False;

  oQuery.Open('SELECT idIngrediente ID, Nome FROM ingrediente ORDER BY idIngrediente ASC');
  if not(oQuery.IsEmpty) then
    Result := True;
end;

function TModelIngrediente.VerificarIngredienteCadastrado(var ADtoIngrediente
  : TDtoIngrediente): Boolean;
begin
  Result := False;

  // testa se nao recebe id
  if ADtoIngrediente.IdIngrediente = 0 then
  begin
    // se idIngrediente = 0 verifica somente nome do ingrediente
    // seleciona no banco o nome
    oQuery.Open('SELECT nome FROM Ingrediente WHERE nome = ' + QuotedStr(ADtoIngrediente.Nome));
    // testa se o retorno do banco de dados é vazio
    if not(oQuery.IsEmpty) then
      // se nao for vazio, já existe Ingrediente cadastrado com este nome
      Result := True;
  end
  else if ADtoIngrediente.IdIngrediente <> 0 then
  begin
    oQuery.Open('SELECT nome FROM Ingrediente ' + QuotedStr(ADtoIngrediente.Nome) +
      ' AND idingrediente <> ' + IntToStr(ADtoIngrediente.IdIngrediente));
    // testa se o retorno do banco de dados é vazio
    if not(oQuery.IsEmpty) then
      // se nao for vazio, já existe Ingrediente cadastrado com este nome
      Result := True;
  end;

end;

end.
