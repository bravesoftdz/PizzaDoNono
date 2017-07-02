unit uControllerPedido;

interface

uses
  System.Classes, System.SysUtils, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Dialogs, Winapi.Windows,
  Vcl.Forms, Vcl.Buttons, Vcl.DBGrids, Data.DB, System.Generics.Collections, System.UITypes,
  uControllerCRUD, uRegraPedido, uDtoPedido, uViewPedido, uModelPedido, uListagemPedido;

type
  TControllerPedido = class(TControllerCRUD)
  private
    oRegraPedido: TRegraPedido;
    oDtoPedido: TDtoPedido;
    oModelPedido: TModelPedido;

    procedure PreencherDTO;
    procedure LimparDto(var ADtoPedido: TDtoPedido);
    procedure PreencherGrid(var DbGrid: TDBGrid);
  public
    constructor Create; override;
    destructor Destroy; override;

    procedure Salvar(ASender: TObject); override;
    procedure Cancelar(ASender: TObject); override;
    procedure Localizar(aOwner: TComponent); override;
    procedure Novo(ASender: TObject); override;
    procedure Editar(Sender: TObject); override;
    procedure Excluir; override;
    procedure CriarFormCadastro(aOwner: TComponent); override;
    procedure FecharFormCadastro(ASender: TObject); override;
    procedure FecharFormListagem(ASender: TObject); override;
    procedure AjustarModoInsercao(AStatusBtnSalvar: Boolean); override;
  end;

var
  oControllerPedido: TControllerPedido;

implementation

{ TControllerPedido }

procedure TControllerPedido.AjustarModoInsercao(AStatusBtnSalvar: Boolean);
begin
  inherited;
  if AStatusBtnSalvar then
    TfrmViewPedido(oFormularioCadastro).dbGridListagem.Enabled := AStatusBtnSalvar;
  TfrmViewPedido(oFormularioCadastro).btnEditarProduto.Enabled := AStatusBtnSalvar;
  TfrmViewPedido(oFormularioCadastro).btnExcluirProduto.Enabled := AStatusBtnSalvar;
  TfrmViewPedido(oFormularioCadastro).btnSalvar.Enabled := AStatusBtnSalvar;
end;

procedure TControllerPedido.Cancelar;
begin
  inherited;
end;

constructor TControllerPedido.Create;
begin
  inherited;

  if not(Assigned(oDtoPedido)) then
    oDtoPedido := TDtoPedido.Create;

  if not(Assigned(oRegraPedido)) then
    oRegraPedido := TRegraPedido.Create;

  if not(Assigned(oModelPedido)) then
    oModelPedido := TModelPedido.Create;

end;

procedure TControllerPedido.CriarFormCadastro(aOwner: TComponent);
begin
  if not(Assigned(oFormularioCadastro)) then
    oFormularioCadastro := TfrmViewPedido.Create(aOwner);

  oFormularioCadastro.iInterfaceCrud := oControllerPedido;

  inherited;
end;

destructor TControllerPedido.Destroy;
begin
  if Assigned(oDtoPedido) then
    FreeAndNil(oDtoPedido);

  if Assigned(oRegraPedido) then
    FreeAndNil(oRegraPedido);

  if Assigned(oModelPedido) then
    FreeAndNil(oModelPedido);

  inherited;
end;

procedure TControllerPedido.Editar(Sender: TObject);
begin
  inherited;
  // // resgatando IdIgrediente e setando no Edit
  // TfrmCadastroPedido(oFormularioCadastro).edtIdCodigo.Text :=
  // oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('idPedido').AsString;
  //
  // // resgatando Nome do Pedido e setando no Edit
  // TfrmCadastroPedido(oFormularioCadastro).edtNome.Text :=
  // oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('nome').AsString;
  //
  // FecharFormListagem(oFormularioListagem);
  //
  AjustarModoInsercao(true);
end;

procedure TControllerPedido.Excluir;
begin
  If MessageBox(0, 'Deseja realmente excluir?' + #13 + 'Este processo não pode ser revertido.',
    'ATENÇÃO!', MB_YESNO + MB_TASKMODAL + MB_ICONWARNING + MB_DEFBUTTON1) = ID_YES Then
  begin
    if oModelPedido.Excluir(oDtoPedido) then
    begin
      inherited;
      ShowMessage('Registro excluído com sucesso.');
    end
    else
    begin
      ShowMessage('Não foi possível excluir.');
    end;
  end;
end;

procedure TControllerPedido.FecharFormCadastro(ASender: TObject);
begin
  inherited;
  oControllerPedido := nil;
end;

procedure TControllerPedido.FecharFormListagem(ASender: TObject);
begin
  inherited;
  oControllerPedido := nil;
end;

procedure TControllerPedido.LimparDto(var ADtoPedido: TDtoPedido);
begin
  ADtoPedido.idPedido := 0;
  ADtoPedido.QuantidadeItens := 0;
end;

procedure TControllerPedido.Localizar;
begin
  if not(Assigned(TfrmListagemPedido(oFormularioListagem))) then
    TfrmListagemPedido(oFormularioListagem) := TfrmListagemPedido.Create(aOwner);

  TfrmListagemPedido(oFormularioListagem).iInterfaceCrud := oControllerPedido;

  // PreencherGrid(TfrmListagemPedido(oFormularioListagem).dbGridListagem);
  inherited;
end;

procedure TControllerPedido.Novo;
begin
  inherited;
  oDtoPedido.idPedido := 0;
end;

procedure TControllerPedido.Salvar;
begin
  PreencherDTO;

  if oRegraPedido.ValidarDados(oDtoPedido) then
  begin
    // ShowMessage('Não é possível salvar um pedido vazio. Selecione ao menos um produto.');
    MessageBox(0, 'Não é possível salvar um pedido vazio. ' + #13 +
      'Selecione ao menos um produto.', 'ATENÇÃO!', MB_OK + MB_TASKMODAL + MB_ICONINFORMATION +
      MB_DEFBUTTON1);
  end
  else
  begin
    // testa se o edit do ID está vazio
    if oDtoPedido.idPedido = 0 then
    begin
      // testa se a inserção foi realizada
      // if oRegraPedido.Inserir(oModelPedido, oDtoPedido) then
      // begin
      // // se a inserção for realizada
      // AjustarModoInsercao(False);
      // LimparFormulario;
      // LimparDto(oDtoPedido);
      // inherited;
      // end;
    end
    else
    // se o edit de ID nao estiver vazio, fazer UPDATE
    begin
      // if oRegraPedido.Editar(oModelPedido, oDtoPedido) then
      // begin
      // // se a alteração for realizada
      // AjustarModoInsercao(False);
      // LimparFormulario;
      // LimparDto(oDtoPedido);
      // inherited;
      // end;
    end;
  end;
end;

procedure TControllerPedido.PreencherDTO;
begin

  oDtoPedido.QuantidadeItens := TfrmViewPedido(oFormularioCadastro).dbGridListagem.FieldCount;

end;

procedure TControllerPedido.PreencherGrid(var DbGrid: TDBGrid);
begin

  if oModelPedido.Listar then
  begin
    oDataSource.DataSet := oModelPedido.oQuery;
    TfrmListagemPedido(oFormularioListagem).dbGridListagem.DataSource := oDataSource;
  end;

end;

end.
