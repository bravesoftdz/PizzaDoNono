unit uControllerPedidoQuantidade;

interface

uses
  System.Classes, System.SysUtils, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Dialogs,
  Winapi.Windows,
  Vcl.Forms, Vcl.Buttons, Vcl.DBGrids, Data.DB, System.Generics.Collections,
  System.UITypes,
  uControllerCRUD, uRegraPedidoQuantidade, uDtoPedidoProduto,
  uViewQuantidade, uModelPedidoQuantidade, uModelSabor, uDtoSabor, uListaSabor,
  uEnumeradorTemSabor, uListaSaboresDisponiveis, uListaTamanho, uModelTamanho,
  uDtoTamanho;

type
  TControllerPedidoQuantidade = class(TControllerCRUD)
  private
    oRegraPedidoQuantidade: TRegraPedidoQuantidade;
    oModelPedidoQuantidade: TModelPedidoQuantidade;

    procedure PreencherDTO;
    procedure AjustarModoInsercao(AStatusBtnSalvar: Boolean); override;
    procedure ListarSabores;
    procedure ListarTamanhos(var AcmbTamanho: TComboBox);

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

{ TControllerPedidoProduto }

uses uModelSabor, uListaSabor, uDtoSabor, uControllerPedidoProduto,
  uControllerSabor, uRegraSabor;

procedure TControllerPedidoQuantidade.AjustarModoInsercao(AStatusBtnSalvar
  : Boolean);
begin
  //

end;

constructor TControllerPedidoQuantidade.Create;
begin
  inherited;

  if not(Assigned(oDtoPedidoProduto)) then
    oDtoPedidoProduto := TDtoPedidoProduto.Create;

  if not(Assigned(oRegraPedidoQuantidade)) then
    oRegraPedidoQuantidade := TRegraPedidoQuantidade.Create;

  if not(Assigned(oModelPedidoQuantidade)) then
    oModelPedidoQuantidade := TModelPedidoQuantidade.Create;

end;

procedure TControllerPedidoQuantidade.CriarFormCadastro(aOwner: TComponent);
begin
  if not(Assigned(oFormularioCadastro)) then
    TfrmQuantidade(oFormularioCadastro) := TfrmQuantidade.Create(aOwner);

  oFormularioCadastro.iInterfaceCrud := oControllerPedidoQuantidade;

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
        TfrmQuantidade(oFormularioCadastro).CheckListBoxSabores.Items.AddObject
          (oDtoSabor.Nome, TObject(oDtoSabor.idSabor));
    end;
  finally
    if Assigned(oModelSabor) then
      FreeAndNil(oModelSabor);

    if Assigned(oListaSabor) then
      FreeAndNil(oListaSabor);
  end;

end;

procedure TControllerPedidoQuantidade.ListarTamanhos(var AcmbTamanho
  : TComboBox);
var
  oListaTamanho: TListaTamanho;
  oModelTamanho: TModelTamanho;
  oDtoTamanho: TDtoTamanho;
begin
  AcmbTamanho.Items.Clear;
  oModelTamanho := TModelTamanho.Create;
  try

    oListaTamanho := TListaTamanho.Create([doOwnsValues]);

    if oModelTamanho.ListarTamanhos(oListaTamanho) then
    begin
      for oDtoTamanho in oListaTamanho.Values do
        AcmbTamanho.Items.AddObject(oDtoTamanho.Nome,
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
//  oDtoPedidoProduto.IdProduto := TfrmViewProduto(oFormularioCadastro)
//    .dbGridListagem.SelectedField.DataSet.FieldByName('idproduto').AsInteger;
//  DtoPedidoProduto.Nome := TfrmViewProduto(oFormularioCadastro)
//    .dbGridListagem.SelectedField.DataSet.FieldByName('nome').AsString;

end;

end.
