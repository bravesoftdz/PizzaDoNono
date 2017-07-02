unit uRegraPedido;

interface

uses
  System.SysUtils, Vcl.Dialogs,
  uDtoPedido, uModelPedido;

type
  TRegraPedido = class
  private
    //
  public
    function ValidarDados(var ADtoPedido: TDtoPedido): Boolean;
    function Excluir(const AModelPedido: TModelPedido; const ADtoPedido: TDtoPedido): Boolean;

  end;

implementation

{ TRegraPedido }

function TRegraPedido.Excluir(const AModelPedido: TModelPedido;
  const ADtoPedido: TDtoPedido): Boolean;
begin

end;

function TRegraPedido.ValidarDados(var ADtoPedido: TDtoPedido): Boolean;
begin
  // testa se o campo nome foi informado
  if ADtoPedido.QuantidadeItens = 0 then
  begin
    // se for vazio
    Result := True;
    exit;
  end;
  // caso não der erro nenhum retorna OK
  Result := False;
end;

end.
