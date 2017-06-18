unit uViewCadastroMunicipio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Vcl.Buttons,
  Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TfrmCadastroMunicipio = class(TfrmCadastroBase)
    edtIdCodigo: TLabeledEdit;
    labelEstado: TLabel;
    edtNome: TLabeledEdit;
    cmbEstado: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroMunicipio: TfrmCadastroMunicipio;

implementation

{$R *.dfm}

end.
