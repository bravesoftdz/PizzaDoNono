unit uControllerPedidoQuantidade;

interface

uses
  System.Classes, System.SysUtils, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Dialogs, Winapi.Windows,
  Vcl.Forms, Vcl.Buttons, Vcl.DBGrids, Data.DB, System.Generics.Collections, System.UITypes,
  uControllerCRUD, uRegraPedidoQuantidade, uDtoPedidoProduto, uViewQuantidade,
  uModelPedidoQuantidade, uModelSabor, uDtoSabor, uListaSabor, uEnumeradorTemSabor,
  uListaSaboresDisponiveis, uListaTamanho, uModelTamanho, uDtoTamanho;

type
  TControllerPedidoQuantidade = class(TControllerCRUD)
  private
    oRegraPedidoQuantidade: TRegraPedidoQuantidade;
    oModelPedidoQuantidade: TModelPedidoQuantidade;

    procedure PreencherDTO;
    procedure AjustarModoInsercao(AStatusBtnSalvar: Boolean); override;
    procedure ListarSabores;
    procedure ListarTamanhos;
    procedure ConfirmarProduto(Sender: TObject);
    procedure Cancelar(ASender: TObject); override;
  public

    oDtoPedidoProduto: TDtoPedidoProduto;

    constructor Create; override;
    destructor Destroy; override;

    procedure CriarFormCadastro(aOwner: TComponent); override;
    procedure FecharFormCadastro(ASender: TObject); override;

  end;

var
  oControllerPedidoQuantidade: TControllerPedidoQuantidade;

implementation

{ TControllerPedidoQuantidade }

procedure TControllerPedidoQuantidade.AjustarModoInsercao(AStatusBtnSalvar: Boolean);
begin
  //

end;

procedure TControllerPedidoQuantidade.Cancelar(ASender: TObject);
begin
  If MessageBox(0, 'Deseja realmente cancelar?', 'ATENÇÃO!', MB_YESNO + MB_TASKMODAL +
    MB_ICONEXCLAMATION + MB_DEFBUTTON1) = ID_YES Then
    FecharFormCadastro(nil);
end;

procedure TControllerPedidoQuantidade.ConfirmarProduto(Sender: TObject);
begin
  //
end;

constructor TControllerPedidoQuantidade.Create;
begin
  inherited;

  if not(Assigned(oRegraPedidoQuantidade)) then
    oRegraPedidoQuantidade := TRegraPedidoQuantidade.Create;

  if not(Assigned(oModelPedidoQuantidade)) then
    oModelPedidoQuantidade := TModelPedidoQuantidade.Create;

end;

procedure TControllerPedidoQuantidade.CriarFormCadastro(aOwner: TComponent);
begin
  if not(Assigned(oFormularioCadastro)) then
    oFormularioCadastro := TfrmViewQuantidade.Create(aOwner);

  oFormularioCadastro.iInterfaceCrud := oControllerPedidoQuantidade;
  TfrmViewQuantidade(oFormularioCadastro).BtnConfirmar.OnClick := ConfirmarProduto;

  ListarSabores;
  ListarTamanhos;
  inherited;
end;

destructor TControllerPedidoQuantidade.Destroy;
begin

  if Assigned(oRegraPedidoQuantidade) then
    FreeAndNil(oRegraPedidoQuantidade);

  if Assigned(oModelPedidoQuantidade) then
    FreeAndNil(oModelPedidoQuantidade);

  inherited;
end;

procedure TControllerPedidoQuantidade.FecharFormCadastro(ASender: TObject);
begin
  inherited;
  oControllerPedidoQuantidade := nil;
end;

procedure TControllerPedidoQuantidade.ListarSabores;
var
  oListaSabor: TListaSabor;
  oModelSabor: TModelSabor;
  oDtoSabor: TDtoSabor;
begin

  oModelSabor := TModelSabor.Create;
  try
    oListaSabor := TListaSabor.Create([doOwnsValues]);
    if oModelSabor.BuscarSabores(oListaSabor) then
    begin
      for oDtoSabor in oListaSabor.Values do
        TfrmViewQuantidade(oFormularioCadastro).CheckListBoxSabores.Items.AddObject(oDtoSabor.Nome,
          TObject(oDtoSabor.idSabor));
    end;
  finally
    if Assigned(oModelSabor) then
      FreeAndNil(oModelSabor);

    if Assigned(oListaSabor) then
      FreeAndNil(oListaSabor);
  end;

end;

procedure TControllerPedidoQuantidade.ListarTamanhos;
var
  oListaTamanho: TListaTamanho;
  oModelTamanho: TModelTamanho;
  oDtoTamanho: TDtoTamanho;
begin
  TfrmViewQuantidade(oFormularioCadastro).cmbTamanho.Items.Clear;
  oModelTamanho := TModelTamanho.Create;
  try

    oListaTamanho := TListaTamanho.Create([doOwnsValues]);

    if oModelTamanho.ListarTamanhos(oListaTamanho) then
    begin
      for oDtoTamanho in oListaTamanho.Values do
        TfrmViewQuantidade(oFormularioCadastro).cmbTamanho.Items.AddObject(oDtoTamanho.Nome,
          TObject(oDtoTamanho.IdTamanho));
    end;
  finally
    if Assigned(oModelTamanho) then
      FreeAndNil(oModelTamanho);

    if Assigned(oListaTamanho) then
      FreeAndNil(oListaTamanho);
  end;

end;

procedure TControllerPedidoQuantidade.PreencherDTO;
begin
  // oDtoPedidoProduto.IdProduto := TfrmViewProduto(oFormularioCadastro)
  // .dbGridListagem.SelectedField.DataSet.FieldByName('idproduto').AsInteger;
  // DtoPedidoProduto.Nome := TfrmViewProduto(oFormularioCadastro)
  // .dbGridListagem.SelectedField.DataSet.FieldByName('nome').AsString;

end;

end.
