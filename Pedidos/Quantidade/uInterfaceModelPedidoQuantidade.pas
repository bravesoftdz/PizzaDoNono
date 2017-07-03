unit uInterfaceModelPedidoQuantidade;

interface

uses
  FireDAC.Comp.Client,
  uDtoPedidoProduto;

type
  IModelPedidoQuantidade = interface
    function Inserir(const oDtoPedidoProduto: TDtoPedidoProduto): Boolean;

  end;

implementation

end.
