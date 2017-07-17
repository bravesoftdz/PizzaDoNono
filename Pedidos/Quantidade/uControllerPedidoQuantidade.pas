unit uControllerPedidoQuantidade;

interface

uses
  System.Classes, System.SysUtils, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Dialogs,
  Winapi.Windows,
  Vcl.Forms, Vcl.Buttons, Vcl.DBGrids, Data.DB, System.Generics.Collections,
  System.UITypes,
  uControllerCRUD, uRegraPedidoQuantidade, uDtoPedidoProduto, uViewQuantidade,
  uModelPedidoQuantidade, uModelSabor, uDtoSabor, uListaSabor,
  uEnumeradorTemSabor,
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
    procedure OnSelectSabor(Sender: TObject);
    Procedure OnCheckSabor(Sender: TObject);
    procedure CalcularSubTotal(Sender: TObject);
  public

    oDtoPedidoProduto: TDtoPedidoProduto;

    constructor NewCreate(AGrid: TDBGrid;
      var ADtoPedidoProduto: TDtoPedidoProduto);
    destructor Destroy; override;

    procedure CriarFormCadastro(aOwner: TComponent); override;
    procedure FecharFormCadastro(ASender: TObject); override;

  end;

var
  oControllerPedidoQuantidade: TControllerPedidoQuantidade;

implementation

{ TControllerPedidoQuantidade }

uses uListaSaboresItem;

procedure TControllerPedidoQuantidade.AjustarModoInsercao(AStatusBtnSalvar
  : Boolean);
begin
  //

end;

procedure TControllerPedidoQuantidade.CalcularSubTotal(Sender: TObject);
var
  Quantidade: Currency;
  SubTotal: Currency;

begin

  SubTotal := Quantidade * StrToCurr(oDtoPedidoProduto.ValorUnitario);
  TfrmViewQuantidade(oFormularioCadastro).edtValorTotalPedido.Text :=
    CurrToStr(SubTotal);
end;

procedure TControllerPedidoQuantidade.Cancelar(ASender: TObject);
begin
  If MessageBox(0, 'Deseja realmente cancelar?', 'ATENÇÃO!',
    MB_YESNO + MB_TASKMODAL + MB_ICONEXCLAMATION + MB_DEFBUTTON1) = ID_YES Then
    FecharFormCadastro(nil);
end;

procedure TControllerPedidoQuantidade.ConfirmarProduto(Sender: TObject);
begin
  PreencherDTO;

  oGridItens.DataSource.DataSet.Insert;
  oGridItens.DataSource.DataSet.FieldByName('sequenciaitem').AsInteger := 1;
  oGridItens.DataSource.DataSet.FieldByName('idproduto').AsInteger :=
    oDtoPedidoProduto.IdProduto;
  oGridItens.DataSource.DataSet.FieldByName('nome').AsString :=
    oDtoPedidoProduto.Nome;
  oGridItens.DataSource.DataSet.FieldByName('quantidade').AsInteger := 3;
  oGridItens.DataSource.DataSet.FieldByName('valor').AsCurrency := 22.50;
  oGridItens.DataSource.DataSet.FieldByName('subtotal').AsCurrency := 70.00;

  oGridItens.DataSource.DataSet.Post;
end;

procedure TControllerPedidoQuantidade.CriarFormCadastro(aOwner: TComponent);
begin
  if not(Assigned(oFormularioCadastro)) then
    oFormularioCadastro := TfrmViewQuantidade.Create(aOwner);

  oFormularioCadastro.iInterfaceCrud := oControllerPedidoQuantidade;
  TfrmViewQuantidade(oFormularioCadastro).cmbTamanho.OnClick := ListarSabores;
  TfrmViewQuantidade(oFormularioCadastro).BtnConfirmar.OnClick :=
    ConfirmarProduto;
  TfrmViewQuantidade(oFormularioCadastro).CheckListBoxSabores.OnClick :=
    OnSelectSabor;

  TfrmViewQuantidade(oFormularioCadastro).labelTitulo.Caption :=
    oDtoPedidoProduto.Nome;
  if oDtoPedidoProduto.temSabor = false then
  begin
    TfrmViewQuantidade(oFormularioCadastro).CheckListBoxSabores.Enabled
      := false;
    TfrmViewQuantidade(oFormularioCadastro).edtValor.Enabled := false;
    TfrmViewQuantidade(oFormularioCadastro).ListBox1.Enabled := false;
    TfrmViewQuantidade(oFormularioCadastro).cmbTamanho.Enabled := false;

  end;

  TfrmViewQuantidade(oFormularioCadastro).edtQuantidade.OnChange :=
    CalcularSubTotal;
  TfrmViewQuantidade(oFormularioCadastro).CheckListBoxSabores.OnClickCheck :=
    OnCheckSabor;

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
      .cmbTamanho.Items.Objects[TfrmViewQuantidade(oFormularioCadastro)
      .cmbTamanho.ItemIndex]);

    oModelSabor := TModelSabor.Create;
    try
      oListaSabor := TListaSabor.Create([doOwnsValues]);
      if oModelSabor.BuscarSaboresPorTamanho(oListaSabor, iIdTamanho) then
      begin
        for oDtoSabor in oListaSabor.Values do
          TfrmViewQuantidade(oFormularioCadastro)
            .CheckListBoxSabores.Items.AddObject(oDtoSabor.Nome,
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
        TfrmViewQuantidade(oFormularioCadastro).cmbTamanho.Items.AddObject
          (oDtoTamanho.Nome, TObject(oDtoTamanho.IdTamanho));
    end;
  finally
    if Assigned(oModelTamanho) then
      FreeAndNil(oModelTamanho);

    if Assigned(oListaTamanho) then
      FreeAndNil(oListaTamanho);
  end;

end;

constructor TControllerPedidoQuantidade.NewCreate(AGrid: TDBGrid;
  var ADtoPedidoProduto: TDtoPedidoProduto);
begin
  inherited Create;
  oDtoPedidoProduto := ADtoPedidoProduto;

  oGridItens := AGrid;

  if not(Assigned(oRegraPedidoQuantidade)) then
    oRegraPedidoQuantidade := TRegraPedidoQuantidade.Create;

  if not(Assigned(oModelPedidoQuantidade)) then
    oModelPedidoQuantidade := TModelPedidoQuantidade.Create;

end;

procedure TControllerPedidoQuantidade.OnCheckSabor(Sender: TObject);
var
  SubTotal, valor, maiorValor: Currency;
  idSabor: Integer;
  oModelSabor: TModelSabor;
begin
  try
    maiorValor := 0;
    if not(Assigned(oModelSabor)) then
      oModelSabor := TModelSabor.Create;
    PreencherDTO;
    for idSabor in oDtoPedidoProduto.Sabor.Keys do
    begin
      valor := StrToCurr(oModelSabor.BuscarValor(idSabor));
      if valor > maiorValor then
        maiorValor := valor;
    end;
  finally
    FreeAndNil(oModelSabor);
    oDtoPedidoProduto.ValorUnitario := CurrToStr(maiorValor);
    CalcularSubTotal(nil);
  end;

end;

procedure TControllerPedidoQuantidade.OnSelectSabor(Sender: TObject);
var
  oModelSabor: TModelSabor;
  idSabor, i: Integer;
begin
  try
    if not(Assigned(oModelSabor)) then
      oModelSabor := TModelSabor.Create;

    for i := 0 to TfrmViewQuantidade(oFormularioCadastro)
      .CheckListBoxSabores.Items.Count - 1 do
    begin
      if TfrmViewQuantidade(oFormularioCadastro).CheckListBoxSabores.Checked[i]
      then
      begin
        idSabor := Integer(TfrmViewQuantidade(oFormularioCadastro)
          .CheckListBoxSabores.Items.Objects[i]);
      end;
    end;

    TfrmViewQuantidade(oFormularioCadastro).edtValor.Text :=
      oModelSabor.BuscarValor(TfrmViewQuantidade(oFormularioCadastro)
      .CheckListBoxSabores.ItemIndex);
  finally
    FreeAndNil(oModelSabor);

  end;

end;

procedure TControllerPedidoQuantidade.PreencherDTO;
var
  i: Integer;
  newListaSaboresItem: TListaSaboresItem;
begin
  oDtoPedidoProduto.Quantidade :=
    StrToInt(TfrmViewQuantidade(oFormularioCadastro).edtQuantidade.Text);

  if TfrmViewQuantidade(oFormularioCadastro).cmbTamanho.ItemIndex > -1 then
    oDtoPedidoProduto.Tamanho := TfrmViewQuantidade(oFormularioCadastro)
      .cmbTamanho.ItemIndex;

  try
    if not(Assigned(oDtoPedidoProduto.Sabor)) then
    begin
      oDtoPedidoProduto.Sabor := TListaSaboresItem.Create(nil);
    end;
    for i := 0 to TfrmViewQuantidade(oFormularioCadastro)
      .CheckListBoxSabores.Items.Count - 1 do
    begin
      if TfrmViewQuantidade(oFormularioCadastro).CheckListBoxSabores.Checked[i]
      then
      begin

        oDtoPedidoProduto.Sabor.Add(Integer(TfrmViewQuantidade(oFormularioCadastro)
          .CheckListBoxSabores.Items.Objects[i]), '');
      end;
    end;
  finally
//    oDtoPedidoProduto.Sabor := newListaSaboresItem;
  end;

  oDtoPedidoProduto.Observacoes := TfrmViewQuantidade(oFormularioCadastro)
    .MemoObservacoes.Text;

  // oDtoPedidoProduto.Subtotal:
end;

end.
