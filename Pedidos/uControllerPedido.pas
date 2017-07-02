unit uControllerPedido;

interface

uses
  System.Classes, System.SysUtils, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Dialogs, Winapi.Windows,
  Vcl.Forms, Vcl.Buttons, Vcl.DBGrids, Data.DB, System.Generics.Collections, System.UITypes,
  Vcl.Graphics,
  uDtoPedido, uModelPedido, uRegraPedido, uEnumeradorCamposPedido, uViewPedido,
  uControllerCRUD;

type
  TControllerPedido = class(TControllerCRUD)
  private
    oRegraPedido: TRegraPedido;
    oModelPedido: TModelPedido;
    oDtoPedido: TDtoPedido;
    numeroTentativas: integer;
    procedure PreencherDTO;
    procedure LimparDto;
    procedure AjustarModoInsercao(AStatusBtnSalvar: Boolean);
    procedure LimparFormulario;
    procedure OnActivateForm(Sender: TObject);
  public
    oFormPedido: TfrmViewPedido;
    constructor Create;
    destructor Destroy;
    procedure Novo;
    procedure Concluir;
    procedure Cancelar;
    procedure IncluirProduto;
    procedure EditarProduto;
    procedure ExcluirProduto;
    procedure FecharFormPedido;
    procedure CriarFormPedido(aOwner: TComponent);

  end;

var
  oControllerPedido: TControllerPedido;

implementation

{ TControllerPedido }

procedure TControllerPedido.AjustarModoInsercao(AStatusBtnSalvar: Boolean);
var
  iIndiceComponente: integer;
begin
  for iIndiceComponente := 0 to pred(oFormPedido.panelFormulario.ComponentCount) do
  begin
    if AStatusBtnSalvar then
      oFormPedido.btnSalvar.Tag := 1
    else
      oFormPedido.btnSalvar.Tag := 0;
  end;
  oFormPedido.edtValorTotalPedido.Enabled := AStatusBtnSalvar;
  oFormPedido.labelNumeroPedido.Enabled := AStatusBtnSalvar;
  oFormPedido.labelPedido.Enabled := AStatusBtnSalvar;
  oFormPedido.labelValorTotalPedido.Enabled := AStatusBtnSalvar;
  oFormPedido.btnIncluirProduto.Enabled := AStatusBtnSalvar;
  oFormPedido.btnEditarProduto.Enabled := AStatusBtnSalvar;
  oFormPedido.btnExcluirProduto.Enabled := AStatusBtnSalvar;
  oFormPedido.dbGridListagem.Enabled := AStatusBtnSalvar;
  oFormPedido.btnSalvar.Enabled := AStatusBtnSalvar;
  oFormPedido.btnCancelar.Enabled := AStatusBtnSalvar;
  oFormPedido.btnNovo.Enabled := not(AStatusBtnSalvar);
end;

procedure TControllerPedido.Cancelar;
begin
  AjustarModoInsercao(False);
end;

procedure TControllerPedido.Concluir;
begin

end;

constructor TControllerPedido.Create;
begin
  if not(Assigned(oDtoPedido)) then
    oDtoPedido := TDtoPedido.Create;

  if not(Assigned(oRegraPedido)) then
    oRegraPedido := TRegraPedido.Create;

  if not(Assigned(oModelPedido)) then
    oModelPedido := TModelPedido.Create;
end;

procedure TControllerPedido.CriarFormPedido(aOwner: TComponent);
begin
  if not(Assigned(oFormPedido)) then
    oFormPedido := TfrmViewPedido.Create(aOwner);

  oFormPedido.iInterfaceCRUD := oControllerPedido;
  oFormPedido.Show;
  AjustarModoInsercao(False);
end;

destructor TControllerPedido.Destroy;
begin
  if Assigned(oDtoPedido) then
    FreeAndNil(oDtoPedido);

  if Assigned(oRegraPedido) then
    FreeAndNil(oRegraPedido);

  if Assigned(oModelPedido) then
    FreeAndNil(oModelPedido);
end;

procedure TControllerPedido.EditarProduto;
begin

end;

procedure TControllerPedido.ExcluirProduto;
begin

end;

procedure TControllerPedido.FecharFormPedido;
begin
  oControllerPedido := nil;
  if Assigned(oFormPedido) then
    FreeAndNil(oFormPedido);
end;

procedure TControllerPedido.IncluirProduto;
begin

end;

procedure TControllerPedido.LimparDto;
begin
  oDtoPedido.Senha := EmptyStr;
  oDtoPedido.Nome := EmptyStr;
end;

procedure TControllerPedido.LimparFormulario;
begin

end;

procedure TControllerPedido.Novo;
begin
  AjustarModoInsercao(True);
end;

procedure TControllerPedido.OnActivateForm(Sender: TObject);
begin

end;

procedure TControllerPedido.PreencherDTO;
begin
  // oDtoPedido.Nome := Trim(oFormPedido.edtNome.Text);
  // oDtoPedido.Senha := Trim(oFormPedido.edtSenha.Text);
end;

end.
