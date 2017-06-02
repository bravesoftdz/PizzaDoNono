unit uFrmBasePadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  uClassDBConnectionSingleton;

type
  TfrmBasePadrao = class(TForm)
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBasePadrao: TfrmBasePadrao;

implementation

{$R *.dfm}

procedure TfrmBasePadrao.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    perform(wm_nextdlgctl, 0, 0);
  end;
end;

end.
