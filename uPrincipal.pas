unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage,
  uClassDBConnectionSingleton, uFrmBasePadrao, uControllerUsuario,
  uViewCadastroUsuario, uControllerIngrediente,
  uControllerEstado, uControllerMunicipio, uControllerBairro, uControllerCliente,
  uControllerTamanho, uControllerSabor, uControllerProduto, uSingletonLogin, uDtoLogin,
  uControllerPedido;

type
  TfrmPrincipal = class(TfrmBasePadrao)
    panelBoxBotoes: TPanel;
    bntBairros: TSpeedButton;
    btnClientes: TSpeedButton;
    btnEstados: TSpeedButton;
    btnIngredientes: TSpeedButton;
    btnMunicipios: TSpeedButton;
    btnPedidos: TSpeedButton;
    btnProdutos: TSpeedButton;
    btnRelatórios: TSpeedButton;
    btnSabores: TSpeedButton;
    btnSair: TSpeedButton;
    btnUsuarios: TSpeedButton;
    btnTamanho: TSpeedButton;
    panelRodape: TPanel;
    labelNomeUsuario: TLabel;
    labelUsuario: TLabel;
    labelCodigoUsuario: TLabel;
    Label1: TLabel;
    Image1: TImage;
    procedure btnTamanhoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnIngredientesClick(Sender: TObject);
    procedure btnEstadosClick(Sender: TObject);
    procedure btnMunicipiosClick(Sender: TObject);
    procedure bntBairrosClick(Sender: TObject);
    procedure btnClientesClick(Sender: TObject);
    procedure btnUsuariosClick(Sender: TObject);
    procedure btnSaboresClick(Sender: TObject);
    procedure btnProdutosClick(Sender: TObject);
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

procedure TfrmPrincipal.bntBairrosClick(Sender: TObject);
begin
  inherited;
  if not(assigned(oControllerBairro)) then
    oControllerBairro := TControllerBairro.Create;
  oControllerBairro.CriarFormCadastro(Self);
end;

procedure TfrmPrincipal.btnClientesClick(Sender: TObject);
begin
  inherited;
  if not(assigned(oControllerCliente)) then
    oControllerCliente := TControllerCliente.Create;
  oControllerCliente.CriarFormCadastro(Self);
end;

procedure TfrmPrincipal.btnEstadosClick(Sender: TObject);
begin
  inherited;
  if not(assigned(oControllerEstado)) then
    oControllerEstado := TControllerEstado.Create;
  oControllerEstado.CriarFormCadastro(Self);
end;

procedure TfrmPrincipal.btnIngredientesClick(Sender: TObject);
begin
  inherited;
  if not(assigned(oControllerIngrediente)) then
    oControllerIngrediente := TControllerIngrediente.Create;
  oControllerIngrediente.CriarFormCadastro(Self);
end;

procedure TfrmPrincipal.btnMunicipiosClick(Sender: TObject);
begin
  inherited;
  if not(assigned(oControllerMunicipio)) then
    oControllerMunicipio := TControllerMunicipio.Create;
  oControllerMunicipio.CriarFormCadastro(Self);
end;

procedure TfrmPrincipal.btnPedidosClick(Sender: TObject);
begin
  inherited;
  if not(assigned(oControllerPedido)) then
    oControllerPedido := TControllerPedido.Create;
  oControllerPedido.CriarFormCadastro(Self);
end;

procedure TfrmPrincipal.btnProdutosClick(Sender: TObject);
begin
  inherited;
  if not(assigned(oControllerProduto)) then
    oControllerProduto := TControllerProduto.Create;
  oControllerProduto.CriarFormCadastro(Self);
end;

procedure TfrmPrincipal.btnSaboresClick(Sender: TObject);
begin
  inherited;
  if not(assigned(oControllerSabor)) then
    oControllerSabor := TControllerSabor.Create;
  oControllerSabor.CriarFormCadastro(Self);
end;

procedure TfrmPrincipal.btnSairClick(Sender: TObject);
begin
  inherited;
//  if assigned(oControllerPedido) then
//    FreeAndNil(oControllerPedido);
  Close;
end;

procedure TfrmPrincipal.btnTamanhoClick(Sender: TObject);
begin
  inherited;
  if not(assigned(oControllerTamanho)) then
    oControllerTamanho := TControllerTamanho.Create;
  oControllerTamanho.CriarFormCadastro(Self);
end;

procedure TfrmPrincipal.btnUsuariosClick(Sender: TObject);
begin
  inherited;
  if not(assigned(oControllerUsuario)) then
    oControllerUsuario := TControllerUsuario.Create;
  oControllerUsuario.CriarFormCadastro(Self);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
var
  oDtoLogin: TDtoLogin;
begin
  inherited;
  ReportMemoryLeaksOnShutdown := True;
  oDtoLogin := TSingletonLogin.getInstancia;
  labelCodigoUsuario.Caption := IntToStr(oDtoLogin.idUsuario);
  labelNomeUsuario.Caption := oDtoLogin.Nome;
end;

end.
