unit uDtoPedidoProduto;

interface

uses
  System.SysUtils, uListaSabor;

type
  TDtoPedidoProduto = class
  private
    FSabor: TListaSabor;
    FSubtotal: String;
    FIdProduto: Integer;
    FQuantidade: Integer;
    FNome: String;
    FObservacoes: String;
    FTamanho: Integer;
    procedure SetIdProduto(const Value: Integer);
    procedure SetNome(const Value: String);
    procedure SetObservacoes(const Value: String);
    procedure SetQuantidade(const Value: Integer);
    procedure SetSabor(const Value: TListaSabor);
    procedure SetSubtotal(const Value: String);
    procedure SetTamanho(const Value: Integer);

  public

  property IdProduto: Integer read FIdProduto write SetIdProduto;
  property Nome: String read FNome write SetNome;
  property Quantidade: Integer read FQuantidade write SetQuantidade;
  property Tamanho: Integer read FTamanho write SetTamanho;
  property Sabor: TListaSabor read FSabor write SetSabor;
  property Observacoes: String read FObservacoes write SetObservacoes;
  property Subtotal: String read FSubtotal write SetSubtotal;

  end;

implementation

{ TDtoPedidoProduto }

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

procedure TDtoPedidoProduto.SetSabor(const Value: TListaSabor);
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

end.
