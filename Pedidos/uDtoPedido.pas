unit uDtoPedido;

interface

uses
  System.SysUtils;

type
  TDtoPedido = class
  private
    FQuantidadeItens: integer;
    FIdPedido: integer;
    procedure SetQuantidadeItens(const Value: integer);
    procedure SetIdPedido(const Value: integer);

  public
    property IdPedido: integer read FIdPedido write SetIdPedido;
    property QuantidadeItens: integer read FQuantidadeItens write SetQuantidadeItens;
  end;

implementation

{ TDtoPedido }

procedure TDtoPedido.SetQuantidadeItens(const Value: integer);
begin
  FQuantidadeItens := Value;
end;

procedure TDtoPedido.SetIdPedido(const Value: integer);
begin
  FIdPedido := Value;
end;

end.
