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
    oGridItens: TDBGrid;

    procedure PreencherDTO;
    procedure AjustarModoInsercao(AStatusBtnSalvar: Boolean); override;
    procedure ListarSabores(Sender: TObject);
    procedure ListarTamanhos;
    procedure ConfirmarProduto(Sender: TObject);
    procedure Cancelar(ASender: TObject); override;
  public

    oDtoPedidoProduto: TDtoPedidoProduto;

    constructor NewCreate(AGrid: TDBGrid);
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
  oGridItens.DataSource.DataSet.Insert;
  oGridItens.DataSource.DataSet.FieldByName('sequenciaitem').AsInteger := 1;
  oGridItens.DataSource.DataSet.FieldByName('idproduto').AsInteger := 1;
  oGridItens.DataSource.DataSet.FieldByName('nome').AsString := 'pizza';
  oGridItens.DataSource.DataSet.FieldByName('quantidade').AsInteger := 3;
  oGridItens.DataSource.DataSet.FieldByName('valorunitario').AsCurrency := 22.50;
  oGridItens.DataSource.DataSet.FieldByName('subtotal').AsCurrency := 70.00;

  oGridItens.DataSource.DataSet.Post;
end;


procedure TControllerPedidoQuantidade.CriarFormCadastro(aOwner: TComponent);
begin
  if not(Assigned(oFormularioCadastro)) then
    oFormularioCadastro := TfrmViewQuantidade.Create(aOwner);

  oFormularioCadastro.iInterfaceCrud := oControllerPedidoQuantidade;
  TfrmViewQuantidade(oFormularioCadastro).cmbTamanho.OnClick := ListarSabores;
  TfrmViewQuantidade(oFormularioCadastro).BtnConfirmar.OnClick := ConfirmarProduto;

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

procedure TControllerPedidoQuantidade.ListarSabores(Sender: TObject);
var
  oListaSabor: TListaSabor;
  oModelSabor: TModelSabor;
  oDtoSabor: TDtoSabor;
  iIdTamanho: Integer;
begin
  TfrmViewQuantidade(oFormularioCadastro).CheckListBoxSabores.Clear;
  if TfrmViewQuantidade(oFormularioCadastro).cmbTamanho.ItemIndex > -1 then
  begin
    iIdTamanho := Integer(TfrmViewQuantidade(oFormularioCadastro)
      .cmbTamanho.Items.Objects[TfrmViewQuantidade(oFormularioCadastro).cmbTamanho.ItemIndex]);

    oModelSabor := TModelSabor.Create;
    try
      oListaSabor := TListaSabor.Create([doOwnsValues]);
      if oModelSabor.BuscarSaboresPorTamanho(oListaSabor, iIdTamanho) then
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

constructor TControllerPedidoQuantidade.NewCreate(AGrid: TDBGrid);
begin
  inherited Create;

  oGridItens := AGrid;

  if not(Assigned(oRegraPedidoQuantidade)) then
    oRegraPedidoQuantidade := TRegraPedidoQuantidade.Create;

  if not(Assigned(oModelPedidoQuantidade)) then
    oModelPedidoQuantidade := TModelPedidoQuantidade.Create;
end;

procedure TControllerPedidoQuantidade.PreencherDTO;
begin
  //

end;

end.
