unit uViewFinal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmBasePadrao, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Mask;

type
  TfrmFinal = class(TfrmBasePadrao)
    boxBotoes: TPanel;
    btnCancelar: TSpeedButton;
    btnFechar: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnExcluir: TSpeedButton;
    GroupBoxDetalhes: TGroupBox;
    labelValorTotalPedido: TLabel;
    edtValorTotalPedido: TEdit;
    GroupBox1: TGroupBox;
    labelEstado: TLabel;
    labelBairro: TLabel;
    labelMunicipio: TLabel;
    labelTelefone: TLabel;
    labelCelular: TLabel;
    edtTelefone: TMaskEdit;
    edtCelular: TMaskEdit;
    edtNome: TLabeledEdit;
    edtRua: TLabeledEdit;
    edtNumero: TLabeledEdit;
    edtComplemento: TLabeledEdit;
    cmbEstado: TComboBox;
    cmbMunicipio: TComboBox;
    cmbBairro: TComboBox;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFinal: TfrmFinal;

implementation

{$R *.dfm}

end.
