unit uViewCadastroUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.Generics.Collections,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Buttons, Vcl.Imaging.pngimage;

type
  TfrmUsuario = class(TfrmCadastroBase)
    edtIdCodigo: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtSenha: TLabeledEdit;
    edtConfirmaSenha: TLabeledEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUsuario: TfrmUsuario;

implementation

{$R *.dfm}

end.
