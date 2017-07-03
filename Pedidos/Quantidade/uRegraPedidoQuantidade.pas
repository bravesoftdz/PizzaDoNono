unit uRegraPedidoQuantidade;

interface

uses
  System.SysUtils, Vcl.Dialogs,
  uDtoPedidoProduto, uModelPedidoQuantidade;

type
  TRegraPedidoQuantidade = class
  private
    //
  public
    function ValidarDados(var ADtoPedidoProduto: TDtoPedidoProduto): Boolean;

  end;

implementation

{ TRegraPedidoQuantidade }



function TRegraPedidoQuantidade.ValidarDados(var ADtoPedidoProduto: TDtoPedidoProduto): Boolean;
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
