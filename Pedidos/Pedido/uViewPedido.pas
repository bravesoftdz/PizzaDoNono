unit uViewPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, uCadastroBase, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmViewPedido = class(TfrmCadastroBase)
    panelCorpoPedido: TPanel;
    btnIncluirProduto: TSpeedButton;
    btnEditarProduto: TSpeedButton;
    btnExcluirProduto: TSpeedButton;
    panelRodape: TPanel;
    labelValorTotalPedido: TLabel;
    edtValorTotalPedido: TEdit;
    dbGridListagem: TDBGrid;
    DataSource1: TDataSource;
    FDMemTable1: TFDMemTable;
    FDMemTable1sequenciaitem: TIntegerField;
    FDMemTable1idproduto: TIntegerField;
    FDMemTable1nome: TStringField;
    FDMemTable1quantidade: TCurrencyField;
    FDMemTable1valorunitario: TCurrencyField;
    FDMemTable1subtotal: TCurrencyField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmViewPedido: TfrmViewPedido;

implementation

{$R *.dfm}

{ TfrmViewPedido }



end.
