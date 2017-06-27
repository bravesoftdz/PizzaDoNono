unit uDtoProduto;

interface

uses
  System.SysUtils;

type
  TDtoProduto = class
  private
    FNome: string;
    FValor: Currency;
    FIdProduto: integer;

    procedure SetIdProduto(const Value: integer);
    procedure SetNome(const Value: string);
    procedure SetValor(const Value: Currency);

  public
    property IdProduto: integer read FIdProduto write SetIdProduto;
    property Nome: string read FNome write SetNome;
    property Valor: Currency read FValor write SetValor;

  end;

implementation

{ TDtoProduto}


procedure TDtoProduto.SetIdProduto(const Value: integer);
begin
      FIdProduto := Value;
end;

procedure TDtoProduto.SetNome(const Value: string);
begin
      FNome := Value;
end;

procedure TDtoProduto.SetValor(const Value: Currency);
begin
      FValor := Value;
end;

end.