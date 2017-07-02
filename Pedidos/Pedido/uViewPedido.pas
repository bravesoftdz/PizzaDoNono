unit uViewPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, uCadastroBase;

type
  TfrmViewPedido = class(TfrmCadastroBase)
    panelCorpoPedido: TPanel;
    labelNumeroPedido: TLabel;
    labelPedido: TLabel;
    btnIncluirProduto: TSpeedButton;
    btnEditarProduto: TSpeedButton;
    btnExcluirProduto: TSpeedButton;
    panelRodape: TPanel;
    labelValorTotalPedido: TLabel;
    edtValorTotalPedido: TEdit;
    dbGridListagem: TDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmViewPedido: TfrmViewPedido;

implementation

{$R *.dfm}

end.
