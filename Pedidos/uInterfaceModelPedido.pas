unit uInterfaceModelPedido;

interface

uses
  FireDAC.Comp.Client,
  uDtoPedido;

type
  IModelPedido = interface
    function Inserir(const oDtoPedido: TDtoPedido): Boolean;
    function Listar: Boolean;
    function Editar(const oDtoPedido: TDtoPedido): Boolean;
    function VerificarPedidoCadastrado(var ADtoPedido: TDtoPedido): Boolean;
    function Excluir(const ADtoPedido: TDtoPedido): Boolean;
  end;

implementation

end.
