unit uControllerPedidoProduto;

interface

uses
  System.Classes, System.SysUtils, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Dialogs, Winapi.Windows,
  Vcl.Forms, Vcl.Buttons, Vcl.DBGrids, Data.DB, System.Generics.Collections, System.UITypes,
  uControllerCRUD, uRegraPedidoProduto, uDtoPedidoProduto, uViewProduto, uModelPedidoProduto,
  uViewPedido;

type
  TControllerPedidoProduto = class(TControllerCRUD)
  private
    oRegraPedidoProduto: TRegraPedidoProduto;
    oModelPedidoProduto: TModelPedidoProduto;

    procedure PreencherDTO;
    procedure LimparDto;
    procedure AjustarModoInsercao(AStatusBtnSalvar: Boolean); override;
    procedure AdicionarProduto(Sender: TObject);
    procedure FiltrarPorCodigo(Sender: TObject);
    procedure FiltrarPorNome(Sender: TObject);
  public

    oDtoPedidoProduto: TDtoPedidoProduto;

    constructor Create; override;
    destructor Destroy; override;

    procedure CriarFormCadastro(aOwner: TComponent); override;
    procedure FecharFormCadastro(ASender: TObject); override;
  end;

var
  oControllerPedidoProduto: TControllerPedidoProduto;

implementation

{ TControllerPedidoProduto }

procedure TControllerPedidoProduto.AdicionarProduto(Sender: TObject);
begin
  showMessage('Ola mundo');
end;

procedure TControllerPedidoProduto.AjustarModoInsercao(AStatusBtnSalvar: Boolean);
begin
  //

end;

constructor TControllerPedidoProduto.Create;
begin
  inherited;

  if not(Assigned(oDtoPedidoProduto)) then
    oDtoPedidoProduto := TDtoPedidoProduto.Create;

  if not(Assigned(oRegraPedidoProduto)) then
    oRegraPedidoProduto := TRegraPedidoProduto.Create;

  if not(Assigned(oModelPedidoProduto)) then
    oModelPedidoProduto := TModelPedidoProduto.Create;

end;

procedure TControllerPedidoProduto.CriarFormCadastro(aOwner: TComponent);
begin
  if not(Assigned(oFormularioCadastro)) then
    TfrmViewProduto(oFormularioCadastro) := TfrmViewProduto.Create(aOwner);

  oFormularioCadastro.iInterfaceCrud := oControllerPedidoProduto;

  TfrmViewProduto(oFormularioCadastro).dbGridListagem.OnDblClick := AdicionarProduto;
  TfrmViewProduto(oFormularioCadastro).SearchBoxCodigo.OnChange := FiltrarPorCodigo;
  TfrmViewProduto(oFormularioCadastro).SearchBoxNome.OnChange := FiltrarPorNome;

  if oModelPedidoProduto.Listar then
  begin
    oDataSource.DataSet := oModelPedidoProduto.oQuery;
    TfrmViewProduto(oFormularioCadastro).dbGridListagem.DataSource := oDataSource;
  end;

  inherited;
end;

destructor TControllerPedidoProduto.Destroy;
begin
  if Assigned(oDtoPedidoProduto) then
    FreeAndNil(oDtoPedidoProduto);

  if Assigned(oRegraPedidoProduto) then
    FreeAndNil(oRegraPedidoProduto);

  if Assigned(oModelPedidoProduto) then
    FreeAndNil(oModelPedidoProduto);

  inherited;
end;

procedure TControllerPedidoProduto.FecharFormCadastro(ASender: TObject);
begin
  inherited;
  oControllerPedidoProduto := nil;
end;

procedure TControllerPedidoProduto.FiltrarPorCodigo(Sender: TObject);
begin
  TfrmViewProduto(oFormularioCadastro).dbGridListagem.DataSource.DataSet.Filtered := False;
  TfrmViewProduto(oFormularioCadastro).SearchBoxNome.Text := EmptyStr;
  if TfrmViewProduto(oFormularioCadastro).SearchBoxCodigo.Text <> EmptyStr then
  begin
    TfrmViewProduto(oFormularioCadastro).dbGridListagem.DataSource.DataSet.Filter :=
      'idproduto LIKE ' + QuotedStr(TfrmViewProduto(oFormularioCadastro).SearchBoxCodigo.Text);

    TfrmViewProduto(oFormularioCadastro).dbGridListagem.DataSource.DataSet.Filtered := True;
  end;
end;

procedure TControllerPedidoProduto.FiltrarPorNome(Sender: TObject);
begin
  TfrmViewProduto(oFormularioCadastro).dbGridListagem.DataSource.DataSet.Filtered := False;
  TfrmViewProduto(oFormularioCadastro).SearchBoxCodigo.Text := EmptyStr;
  if TfrmViewProduto(oFormularioCadastro).SearchBoxNome.Text <> EmptyStr then
  begin
    TfrmViewProduto(oFormularioCadastro).dbGridListagem.DataSource.DataSet.Filter :=
      'UPPER(nome) Like ' + UpperCase(QuotedStr('%' + TfrmViewProduto(oFormularioCadastro)
      .SearchBoxNome.Text + '%'));

    TfrmViewProduto(oFormularioCadastro).dbGridListagem.DataSource.DataSet.Filtered := True;
  end;
end;

procedure TControllerPedidoProduto.LimparDto;
begin
  oDtoPedidoProduto.IdProduto := 0;
  oDtoPedidoProduto.Quantidade := 0;
  oDtoPedidoProduto.Nome := EmptyStr;
  oDtoPedidoProduto.Tamanho := 0;
  oDtoPedidoProduto.Sabor := nil;
  oDtoPedidoProduto.Observacoes := EmptyStr;
end;

procedure TControllerPedidoProduto.PreencherDTO;
begin
  oDtoPedidoProduto.IdProduto := TfrmViewProduto(oFormularioCadastro)
    .dbGridListagem.SelectedField.DataSet.FieldByName('idproduto').AsInteger;
  oDtoPedidoProduto.Nome := TfrmViewProduto(oFormularioCadastro)
    .dbGridListagem.SelectedField.DataSet.FieldByName('nome').AsString;

end;

end.
