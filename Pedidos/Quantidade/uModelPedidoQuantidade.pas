unit uModelPedidoQuantidade;

interface

uses
  System.SysUtils, Vcl.Dialogs, FireDAC.Comp.Client, Data.DB, FireDAC.DApt,
  uClassDBConnectionSingleton, FireDAC.VCLUI.Wait, FireDAC.Stan.Async,
  uDtoPedidoProduto, uInterfaceModelPedidoProduto;

type
  TModelPedidoQuantidade = class(TInterfacedObject, IModelPedidoProduto)
  public
    oQuery: TFDQuery;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TModelPedidoProduto }

constructor TModelPedidoQuantidade.Create;
begin
  oQuery := TFDQuery.Create(nil);
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
end;

destructor TModelPedidoQuantidade.Destroy;
begin
  if assigned(oQuery) then
    FreeAndNil(oQuery);
  inherited;
end;

end.
