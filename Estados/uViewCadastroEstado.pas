unit uViewCadastroEstado;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Vcl.Buttons,
  Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TfrmCadastroEstado = class(TfrmCadastroBase)
    edtIdCodigo: TLabeledEdit;
    edtUF: TLabeledEdit;
    edtNome: TLabeledEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroEstado: TfrmCadastroEstado;

implementation

{$R *.dfm}

end.
