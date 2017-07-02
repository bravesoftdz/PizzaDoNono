unit uModelPedidoProduto;

interface

uses
  System.SysUtils, Vcl.Dialogs, FireDAC.Comp.Client, Data.DB, FireDAC.DApt,
  uClassDBConnectionSingleton, FireDAC.VCLUI.Wait, FireDAC.Stan.Async,
  uDtoPedidoProduto, uInterfaceModelPedidoProduto;

type
  TModelPedidoProduto = class(TInterfacedObject, IModelPedidoProduto)
  public
    oQuery: TFDQuery;
    function Inserir(const oDtoPedidoProduto: TDtoPedidoProduto): Boolean;
    function Listar: Boolean;
    function Editar(const oDtoPedidoProduto: TDtoPedidoProduto): Boolean;
    function VerificarPedidoProdutoCadastrado(var ADtoPedidoProduto: TDtoPedidoProduto): Boolean;
    function Excluir(const ADtoPedidoProduto: TDtoPedidoProduto): Boolean;
    function CountRegistros: integer;
     // listar os PedidoProdutos do chek lista dos sabores

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TModelPedidoProduto }

function TModelPedidoProduto.CountRegistros: integer;
var
  newQuery: TFDQuery;
begin
  newQuery := TFDQuery.Create(nil);
  try
    newQuery.Connection := oQuery.Connection;
    newQuery.Open('SELECT COUNT(idPedidoProduto) quantidade FROM PedidoProduto');
    Result := newQuery.FieldByName('quantidade').AsInteger;
  finally
    FreeAndNil(newQuery);
  end;
end;


constructor TModelPedidoProduto.Create;
begin
  oQuery := TFDQuery.Create(nil);
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
end;

destructor TModelPedidoProduto.Destroy;
begin
  if assigned(oQuery) then
    FreeAndNil(oQuery);
  inherited;
end;

function TModelPedidoProduto.Editar(const oDtoPedidoProduto: TDtoPedidoProduto): Boolean;
begin
  Result := False;
//  oQuery.ExecSQL('UPDATE PedidoProduto SET nome = ' + QuotedStr(oDtoPedidoProduto.Nome) +
//    ' WHERE idPedidoProduto = ' + IntToStr(oDtoPedidoProduto.IdPedidoProduto));
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelPedidoProduto.Excluir(const ADtoPedidoProduto: TDtoPedidoProduto): Boolean;
begin
  Result := False;
//  oQuery.ExecSQL('DELETE FROM PedidoProduto WHERE idPedidoProduto = ' +
//    IntToStr(ADtoPedidoProduto.IdPedidoProduto));
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelPedidoProduto.Inserir(const oDtoPedidoProduto: TDtoPedidoProduto): Boolean;
begin
  Result := False;
//  oQuery.ExecSQL('INSERT INTO PedidoProduto (nome) VALUES(' + QuotedStr(oDtoPedidoProduto.Nome) + ');');
  if oQuery.RowsAffected > 0 then
  Result := True;
end;

function TModelPedidoProduto.Listar: Boolean;
begin
  Result := False;

//  oQuery.Open('SELECT idPedidoProduto, nome FROM PedidoProduto ORDER BY nome ASC');
  if not(oQuery.IsEmpty) then
    Result := True;
end;


function TModelPedidoProduto.VerificarPedidoProdutoCadastrado(var ADtoPedidoProduto
  : TDtoPedidoProduto): Boolean;
begin
  Result := False;

  // testa se nao recebe id
  if ADtoPedidoProduto.IdProduto = 0 then
  begin
    // se idPedidoProduto = 0 verifica somente nome do PedidoProduto
    // seleciona no banco o nome
//    oQuery.Open('SELECT nome FROM PedidoProduto WHERE nome = ' + QuotedStr(ADtoPedidoProduto.Nome));
    // testa se o retorno do banco de dados é vazio
    if not(oQuery.IsEmpty) then
      // se nao for vazio, já existe PedidoProduto cadastrado com este nome
      Result := True;
  end
  else if ADtoPedidoProduto.IdProduto <> 0 then
  begin
//    oQuery.Open('SELECT nome FROM PedidoProduto ' + QuotedStr(ADtoPedidoProduto.Nome) +
//      ' AND idPedidoProduto <> ' + IntToStr(ADtoPedidoProduto.IdPedidoProduto));
    // testa se o retorno do banco de dados é vazio
    if not(oQuery.IsEmpty) then
      // se nao for vazio, já existe PedidoProduto cadastrado com este nome
      Result := True;
  end;

end;

end.
