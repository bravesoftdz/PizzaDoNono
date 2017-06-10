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


    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TEstadoModel }

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

function TModelIngrediente.Editar(
  const oDtoIngrediente: TDtoIngrediente): Boolean;
begin
 Result := False;
  oQuery.ExecSQL('UPDATE ingrediente SET Descricao = ' + QuotedStr(oDtoIngrediente.Descricao)+' WHERE idingrediente = ' +
  IntToStr(oDtoIngrediente.IdIngrediente));
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelIngrediente.Excluir(const ADtoIngrediente: TDtoIngrediente): Boolean;
begin
 Result := False;
  oQuery.ExecSQL('DELETE FROM ingrediente WHERE idingrediente = ' + IntToStr(ADtoIngrediente.idIngrediente));
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelIngrediente.Inserir(const oDtoIngrediente
  : TDtoIngrediente): Boolean;
begin
  Result := False;
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
  oQuery.ExecSQL('INSERT INTO ingrediente(idIngrediente, descricao) VALUES(' +
    IntToStr(oDtoIngrediente.IdIngrediente) + ', ' +
    QuotedStr(oDtoIngrediente.Descricao) + ');');
  Result := True;
end;

function TModelIngrediente.Listar: Boolean;
begin
  Result := False;

  oQuery.Open
    ('SELECT idIngrediente ID, Descricao as Descrição FROM ingrediente ORDER BY idIngrediente ASC');
  if not(oQuery.IsEmpty) then
    Result := True;
end;

function TModelIngrediente.VerificarIngredienteCadastrado(var ADtoIngrediente: TDtoIngrediente): Boolean;
begin
  Result := False;


 // testa se nao recebe id
  if ADtoIngrediente.idIngrediente = 0 then
  begin
    // se idIngrediente = 0 verifica somente nome do ingrediente
    // seleciona no banco o nome
    oQuery.Open('SELECT Descricao FROM Ingrediente WHERE Descricao = ' + QuotedStr(ADtoIngrediente.Descricao));
    // testa se o retorno do banco de dados é vazio
    if not(oQuery.IsEmpty) then
      // se nao for vazio, já existe Ingrediente cadastrado com este nome
      Result := True;
  end
  else if ADtoIngrediente.idIngrediente <> 0 then
  begin
    oQuery.Open('SELECT Descricao FROM Ingrediente ' + QuotedStr(ADtoIngrediente.Descricao)
    + ' AND idingrediente <> ' + IntToStr(ADtoIngrediente.idIngrediente));
    // testa se o retorno do banco de dados é vazio
    if not(oQuery.IsEmpty) then
      // se nao for vazio, já existe Bairro cadastrado com este nome
      Result := True;
  end;

end;

end.
