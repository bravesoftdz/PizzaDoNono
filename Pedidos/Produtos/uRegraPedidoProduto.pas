unit uRegraPedidoProduto;

interface

uses
  System.SysUtils, Vcl.Dialogs,
  uDtoPedidoProduto, uModelPedidoProduto;

type
  TRegraPedidoProduto = class
  private
    //
  public
    function ValidarDados(var ADtoPedidoProduto: TDtoPedidoProduto): Boolean;
    function Excluir(const AModelPedidoProduto: TModelPedidoProduto; const ADtoPedidoProduto: TDtoPedidoProduto): Boolean;

  end;

implementation

{ TRegraPedidoProduto }

function TRegraPedidoProduto.Excluir(const AModelPedidoProduto: TModelPedidoProduto;
  const ADtoPedidoProduto: TDtoPedidoProduto): Boolean;
begin

end;

function TRegraPedidoProduto.ValidarDados(var ADtoPedidoProduto: TDtoPedidoProduto): Boolean;
begin
  // testa se o campo nome foi informado
  if ADtoPedidoProduto.Quantidade = 0 then
  begin
    // se for vazio
    Result := True;
    exit;
  end;
  // caso não der erro nenhum retorna OK
  Result := False;
end;

end.
