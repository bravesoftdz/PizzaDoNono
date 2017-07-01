unit uViewPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmBasePadrao, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Grids, Data.DB, Vcl.DBGrids;

type
  TfrmBasePadrao1 = class(TfrmBasePadrao)
    boxBotoes: TPanel;
    btnCancelar: TSpeedButton;
    btnFechar: TSpeedButton;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    panelFormulario: TPanel;
    panelCorpoPedido: TPanel;
    labelNumeroPedido: TLabel;
    labelPedido: TLabel;
    panelRodape: TPanel;
    labelValorTotalPedido: TLabel;
    edtValorTotalPedido: TEdit;
    btnIncluirProduto: TSpeedButton;
    btnEditarProduto: TSpeedButton;
    btnExcluirProduto: TSpeedButton;
    dbGridListagem: TDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBasePadrao1: TfrmBasePadrao1;

implementation

{$R *.dfm}

end.
