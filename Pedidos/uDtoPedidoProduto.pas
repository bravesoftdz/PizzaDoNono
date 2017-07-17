unit uDtoPedidoProduto;

interface

uses
  System.SysUtils, uListaSaboresItem;

type
  TDtoPedidoProduto = class
  private
    FSabor: TListaSaboresItem;
    FSubtotal: String;
    FIdProduto: Integer;
    FQuantidade: Integer;
    FNome: String;
    FObservacoes: String;
    FTamanho: Integer;
    FtemSabor: boolean;
    FValorUnitario: string;
    procedure SetIdProduto(const Value: Integer);
    procedure SetNome(const Value: String);
    procedure SetObservacoes(const Value: String);
    procedure SetQuantidade(const Value: Integer);
    procedure SetSabor(const Value: TListaSaboresItem);
    procedure SetSubtotal(const Value: String);
    procedure SetTamanho(const Value: Integer);
    procedure SettemSabor(const Value: boolean);
    procedure SetValorUnitario(const Value: string);

  public

    property IdProduto: Integer read FIdProduto write SetIdProduto;
    property Nome: String read FNome write SetNome;
    property Quantidade: Integer read FQuantidade write SetQuantidade;
    property Tamanho: Integer read FTamanho write SetTamanho;
    property Sabor: TListaSaboresItem read FSabor write SetSabor;
    property Observacoes: String read FObservacoes write SetObservacoes;
    property Subtotal: String read FSubtotal write SetSubtotal;
    property temSabor: boolean read FtemSabor write SettemSabor;
    property ValorUnitario: string read FValorUnitario write SetValorUnitario;

  end;

implementation

{ TDtoPedidoProduto }


procedure TDtoPedidoProduto.SetIdProduto(const Value: Integer);
begin
  FIdProduto := Value;
end;

procedure TDtoPedidoProduto.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TDtoPedidoProduto.SetObservacoes(const Value: String);
begin
  FObservacoes := Value;
end;

procedure TDtoPedidoProduto.SetQuantidade(const Value: Integer);
begin
  FQuantidade := Value;
end;

procedure TDtoPedidoProduto.SetSabor(const Value: TListaSaboresItem);
begin
  FSabor := Value;
end;

procedure TDtoPedidoProduto.SetSubtotal(const Value: String);
begin
  FSubtotal := Value;
end;

procedure TDtoPedidoProduto.SetTamanho(const Value: Integer);
begin
  FTamanho := Value;
end;

procedure TDtoPedidoProduto.SettemSabor(const Value: boolean);
begin
  FtemSabor := Value;
end;

procedure TDtoPedidoProduto.SetValorUnitario(const Value: string);
begin
  FValorUnitario := Value;
end;

end.
