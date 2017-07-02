unit uModelPedido;

interface

uses
  System.SysUtils, Vcl.Dialogs, FireDAC.Comp.Client, Data.DB, FireDAC.DApt,
  uClassDBConnectionSingleton, FireDAC.VCLUI.Wait, FireDAC.Stan.Async,
  uDtoPedido, uInterfaceModelPedido;

type
  TModelPedido = class(TInterfacedObject, IModelPedido)
  public
    oQuery: TFDQuery;
    function Inserir(const oDtoPedido: TDtoPedido): Boolean;
    function Listar: Boolean;
    function Editar(const oDtoPedido: TDtoPedido): Boolean;
    function VerificarPedidoCadastrado(var ADtoPedido: TDtoPedido): Boolean;
    function Excluir(const ADtoPedido: TDtoPedido): Boolean;
    function CountRegistros: integer;
     // listar os Pedidos do chek lista dos sabores

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TModelPedido }

function TModelPedido.CountRegistros: integer;
var
  newQuery: TFDQuery;
begin
  newQuery := TFDQuery.Create(nil);
  try
    newQuery.Connection := oQuery.Connection;
    newQuery.Open('SELECT COUNT(idPedido) quantidade FROM Pedido');
    Result := newQuery.FieldByName('quantidade').AsInteger;
  finally
    FreeAndNil(newQuery);
  end;
end;


constructor TModelPedido.Create;
begin
  oQuery := TFDQuery.Create(nil);
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
end;

destructor TModelPedido.Destroy;
begin
  if assigned(oQuery) then
    FreeAndNil(oQuery);
  inherited;
end;

function TModelPedido.Editar(const oDtoPedido: TDtoPedido): Boolean;
begin
  Result := False;
//  oQuery.ExecSQL('UPDATE Pedido SET nome = ' + QuotedStr(oDtoPedido.Nome) +
//    ' WHERE idPedido = ' + IntToStr(oDtoPedido.IdPedido));
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelPedido.Excluir(const ADtoPedido: TDtoPedido): Boolean;
begin
  Result := False;
//  oQuery.ExecSQL('DELETE FROM Pedido WHERE idPedido = ' +
//    IntToStr(ADtoPedido.IdPedido));
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelPedido.Inserir(const oDtoPedido: TDtoPedido): Boolean;
begin
  Result := False;
//  oQuery.ExecSQL('INSERT INTO Pedido (nome) VALUES(' + QuotedStr(oDtoPedido.Nome) + ');');
  if oQuery.RowsAffected > 0 then
  Result := True;
end;

function TModelPedido.Listar: Boolean;
begin
  Result := False;

//  oQuery.Open('SELECT idPedido, nome FROM Pedido ORDER BY nome ASC');
  if not(oQuery.IsEmpty) then
    Result := True;
end;


function TModelPedido.VerificarPedidoCadastrado(var ADtoPedido
  : TDtoPedido): Boolean;
begin
  Result := False;

  // testa se nao recebe id
  if ADtoPedido.IdPedido = 0 then
  begin
    // se idPedido = 0 verifica somente nome do Pedido
    // seleciona no banco o nome
//    oQuery.Open('SELECT nome FROM Pedido WHERE nome = ' + QuotedStr(ADtoPedido.Nome));
    // testa se o retorno do banco de dados é vazio
    if not(oQuery.IsEmpty) then
      // se nao for vazio, já existe Pedido cadastrado com este nome
      Result := True;
  end
  else if ADtoPedido.IdPedido <> 0 then
  begin
//    oQuery.Open('SELECT nome FROM Pedido ' + QuotedStr(ADtoPedido.Nome) +
//      ' AND idPedido <> ' + IntToStr(ADtoPedido.IdPedido));
    // testa se o retorno do banco de dados é vazio
    if not(oQuery.IsEmpty) then
      // se nao for vazio, já existe Pedido cadastrado com este nome
      Result := True;
  end;

end;

end.
