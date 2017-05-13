unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmBasePadrao, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, uViewUsuario;

type
  TfrmPrincipal = class(TfrmBasePadrao)
    Panel1: TPanel;
    btnPedidos: TSpeedButton;
    btnProdutos: TSpeedButton;
    btnSabores: TSpeedButton;
    btnIngredientes: TSpeedButton;
    btnClientes: TSpeedButton;
    bntBairros: TSpeedButton;
    btnMunicipios: TSpeedButton;
    btnEstados: TSpeedButton;
    btnUsuarios: TSpeedButton;
    btnRelatórios: TSpeedButton;
    btnSair: TSpeedButton;
    procedure btnUsuariosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.btnUsuariosClick(Sender: TObject);
begin
  inherited;
  if not(assigned(frmUsuario)) then
    frmUsuario := TfrmUsuario.Create(Self);
  frmUsuario.Show;
end;

end.
