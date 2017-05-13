unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmBasePadrao, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, uListagemBase;

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
    procedure btnPedidosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.btnPedidosClick(Sender: TObject);
begin
  inherited;
  frmListagemBase := TfrmListagemBase.Create(Self);
  frmListagemBase.Show;
end;

end.
