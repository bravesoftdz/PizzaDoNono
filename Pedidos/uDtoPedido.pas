unit uDtoPedido;

interface

uses
  System.SysUtils;

type
  TDtoPedido = class
  private

    FIdPedido: integer;

    procedure SetIdPedido(const Value: integer);

  public
    property IdPedido: integer read FIdPedido write SetIdPedido;

  end;

implementation

{ TDtoPedido }

procedure TDtoPedido.SetIdPedido(const Value: integer);
begin
  FIdPedido := Value;
end;

end.
