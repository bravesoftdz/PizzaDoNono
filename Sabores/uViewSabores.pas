unit uViewSabores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Buttons, Vcl.Imaging.pngimage;

type
  TfrmCadastroBase1 = class(TfrmCadastroBase)
    edtDescricao: TLabeledEdit;
    edtID: TLabeledEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroBase1: TfrmCadastroBase1;

implementation

{$R *.dfm}

end.
