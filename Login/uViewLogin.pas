unit uViewLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmBasePadrao, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, System.ImageList, Vcl.ImgList, uPrincipal;

type
  TfrmViewLogin = class(TfrmBasePadrao)
    Panel1: TPanel;
    Label1: TLabel;
    btnSair: TBitBtn;
    Label2: TLabel;
    edtNome: TLabeledEdit;
    edtSenha: TEdit;
    btnEntrar: TBitBtn;
    Image1: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmViewLogin: TfrmViewLogin;

implementation

{$R *.dfm}

end.
