unit uViewCadastroTamanho;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Vcl.Buttons,
  Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TfrmCadastroTamanho = class(TfrmCadastroBase)
    edtIdCodigo: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtMaxSabores: TLabeledEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroTamanho: TfrmCadastroTamanho;

implementation

{$R *.dfm}

end.
