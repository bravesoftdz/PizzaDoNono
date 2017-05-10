unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage,
  uCadastroBase, uFrmBasePadrao, uClassDBConnectionSingleton;

type
  TfrmPrincipal = class(TfrmBasePadrao)
    btnPedido: TPanel;
    Image1: TImage;
    Label1: TLabel;
    SpeedButton2: TSpeedButton;
    btnSabores: TPanel;
    Sabores: TLabel;
    Image2: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  inherited;
  ReportMemoryLeaksOnShutdown := true;

  if TDBConnectionSingleton.getInstancia = nil then
  begin
    Raise Exception.Create('erro ao conectar com o banco de dados');
    Application.Terminate;
  end
end;

end.
