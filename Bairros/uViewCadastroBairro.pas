unit uViewCadastroBairro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Vcl.Buttons,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmCadastroBairro = class(TfrmCadastroBase)
    cmbMunicipio: TComboBox;
    edtNome: TLabeledEdit;
    edtIdCodigo: TLabeledEdit;
    labelMunicipio: TLabel;
    cmbEstado: TComboBox;
    labelEstado: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroBairro: TfrmCadastroBairro;

implementation

{$R *.dfm}

end.
