unit uDtoPedido;

interface

uses
  System.SysUtils, uListaItensPedido;

type
  TDtoPedido = class
  private
    FQuantidadeItens: integer;
    FIdPedido: integer;
    FItensPedido: TListaItensPedido;
    procedure SetQuantidadeItens(const Value: integer);
    procedure SetIdPedido(const Value: integer);
    procedure SetItensPedido(const Value: TListaItensPedido);

  public
    property IdPedido: integer read FIdPedido write SetIdPedido;
    property QuantidadeItens: integer read FQuantidadeItens write SetQuantidadeItens;
    property ItensPedido: TListaItensPedido read FItensPedido write SetItensPedido;
  end;

implementation

{ TDtoPedido }

procedure TDtoPedido.SetItensPedido(const Value: TListaItensPedido);
begin
  FItensPedido := Value;
end;

procedure TDtoPedido.SetQuantidadeItens(const Value: integer);
begin
  FQuantidadeItens := Value;
end;

procedure TDtoPedido.SetIdPedido(const Value: integer);
begin
  FIdPedido := Value;
end;

end.
