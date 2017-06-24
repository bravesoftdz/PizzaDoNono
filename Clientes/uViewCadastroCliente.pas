unit uViewCadastroCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Mask, Data.Bind.EngExt, Vcl.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Vcl.Bind.Editors, Data.Bind.Components;

type
  TfrmCadastroCliente = class(TfrmCadastroBase)
    edtIdCodigo: TLabeledEdit;
    GroupBoxDadosPessoais: TGroupBox;
    labelTelefone: TLabel;
    labelCelular: TLabel;
    GroupBoxEndereco: TGroupBox;
    labelMunicipio: TLabel;
    labelEstado: TLabel;
    labelBairro: TLabel;
    edtRua: TLabeledEdit;
    edtNumero: TLabeledEdit;
    edtComplemento: TLabeledEdit;
    cmbEstado: TComboBox;
    cmbMunicipio: TComboBox;
    cmbBairro: TComboBox;
    labelDataNascimento: TLabel;
    labelCpfCnpj: TLabel;
    edtNome: TLabeledEdit;
    edtTelefone: TMaskEdit;
    edtCelular: TMaskEdit;
    edtCpfCnpj: TMaskEdit;
    edtDataNascimento: TMaskEdit;
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
