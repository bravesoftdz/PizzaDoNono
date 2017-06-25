unit uInterfaceModelProduto;

interface

uses
  FireDAC.Comp.Client,
  uDtoProduto;

type
  IModelProduto = interface
    function Inserir(const oDtoProduto: TDtoProduto): Boolean;
    function Listar: Boolean;
    function Editar(const oDtoProduto: TDtoProduto): Boolean;
    function VerificarProdutoCadastrado(var ADtoProduto: TDtoProduto): Boolean;
    function Excluir(const ADtoProduto: TDtoProduto): Boolean;
  end;

implementation

end.
