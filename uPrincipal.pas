unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmBasePadrao, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, uFrameBotao,
  Vcl.Imaging.pngimage, uListagemBase;

type
  TfrmPrincipal = class(TfrmBasePadrao)
    boxClientes: TPanel;
    imageClientes: TImage;
    btnCliente: TSpeedButton;
    labelClientes: TLabel;
    boxSabores: TPanel;
    btnSabores: TSpeedButton;
    labelSabores: TLabel;
    imageSabores: TImage;


    boxProdutos: TPanel;
    labelProdutos: TLabel;
    imageProdutos: TImage;
    btnProdutos: TSpeedButton;
    boxPedidos: TPanel;
    imagePedidos: TImage;
    labelPedidos: TLabel;
    btnPedidos: TSpeedButton;
    boxEstados: TPanel;
    labelEstados: TLabel;
    imageEstados: TImage;

    btnEstados: TSpeedButton;
    boxMunicípio: TPanel;






    imageMunicpio: TImage;
    labelMunicipio: TLabel;
    btnMunicipio: TSpeedButton;
    boxBairros: TPanel;
    imageBairros: TImage;
    labelBairros: TLabel;
    btnBairros: TSpeedButton;
    boxUsuários: TPanel;
    imageUsuarios: TImage;
    labelUsuarios: TLabel;
    btnUsuarios: TSpeedButton;
    boxRelatorios: TPanel;
    imageRelatorios: TImage;
    labelRelatorios: TLabel;
    bntRelatorios: TSpeedButton;
    boxSair: TPanel;
    imageSair: TImage;
    labelSair: TLabel;
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
