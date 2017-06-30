unit uDtoProduto;

interface

uses
  System.SysUtils, uListaSabor, uEnumeradorTemSabor;

type
  TDtoProduto = class
  private
    FNome: string;
    FValor: string;
    FIdProduto: integer;
    FSabor: TListaSabor;
    FTemSabor: TEnumeradorTemSabor;

    procedure SetIdProduto(const Value: integer);
    procedure SetNome(const Value: string);
    procedure SetValor(const Value: string);
    procedure SetSabor(const Value: TListaSabor);
    procedure SetTemSabor(const Value: TEnumeradorTemSabor);

  public
    property IdProduto: integer read FIdProduto write SetIdProduto;
    property Nome: string read FNome write SetNome;
    property Valor: string read FValor write SetValor;
    property Sabor: TListaSabor read FSabor write SetSabor;
    property TemSabor: TEnumeradorTemSabor read FTemSabor write SetTemSabor;
  end;

implementation

{ TDtoProduto }

procedure TDtoProduto.SetIdProduto(const Value: integer);
begin
  FIdProduto := Value;
end;

procedure TDtoProduto.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TDtoProduto.SetSabor(const Value: TListaSabor);
begin
  FSabor := Value;
end;

procedure TDtoProduto.SetTemSabor(const Value: TEnumeradorTemSabor);
begin
  FTemSabor := Value;
end;

procedure TDtoProduto.SetValor(const Value: string);
begin
  FValor := Value;
end;

end.
