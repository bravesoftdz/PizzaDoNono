unit uViewCadastroCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Mask;

type
  TfrmCadastroCliente = class(TfrmCadastroBase)
    edtIdCodigo: TLabeledEdit;
    GroupBoxDadosPessoais: TGroupBox;
    labelTelefone: TLabel;
    labelCelular: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    edtNome: TLabeledEdit;
    edtTelefone: TMaskEdit;
    edtCelular: TMaskEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    edtCPF: TMaskEdit;
    edtCNPJ: TMaskEdit;
    GroupBox1: TGroupBox;
    labelMunicipio: TLabel;
    labelEstado: TLabel;
    Label3: TLabel;
    edtRua: TLabeledEdit;
    edtNumero: TLabeledEdit;
    edtComplemento: TLabeledEdit;
    cmbEstado: TComboBox;
    cmbMunicipio: TComboBox;
    ComboBox1: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroCliente: TfrmCadastroCliente;

implementation

{$R *.dfm}

end.
