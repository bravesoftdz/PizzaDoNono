unit uViewCadastroIngrediente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Vcl.Buttons,
  Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TfrmCadastroIngrediente = class(TfrmCadastroBase)
    edtNome: TLabeledEdit;
    edtIdCodigo: TLabeledEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroIngrediente: TfrmCadastroIngrediente;

implementation

{$R *.dfm}

end.
