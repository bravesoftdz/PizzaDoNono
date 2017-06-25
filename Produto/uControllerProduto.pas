unit uControllerProduto;

interface

uses
  System.Classes, System.SysUtils, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Dialogs,
  Vcl.Forms, Vcl.Buttons, Vcl.DBGrids, Data.DB, System.Generics.Collections, System.UITypes,
  uInterfaceCRUD, uInterfaceRegra, uControllerCRUD, uDtoProduto,
  uModelProduto, uRegraProduto, uViewCadastroProduto,
  uViewListagemProduto, uEnumeradorCamposProduto;

type
  TControllerProduto = class(TControllerCRUD)
  private
    oRegraProduto: TRegraProduto;
    oModelProduto: TModelProduto;
    oDtoProduto: TDtoProduto;

    procedure PreencherDTO;
    procedure LimparDto();
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
    procedure AjustarListagem; override;
  end;

var
  oControllerProduto: TControllerProduto;

implementation

{ TControllerUsuario }

procedure TControllerProduto.AjustarListagem;
begin
  if not(oRegraProduto.CountRegistros(oModelProduto)) then
    inherited;
end;

procedure TControllerProduto.Cancelar;
begin
  inherited;
end;

constructor TControllerProduto.Create;
begin
  inherited;

  if not(Assigned(oDtoProduto)) then
    oDtoProduto := TDtoProduto.Create;

  if not(Assigned(oRegraProduto)) then
    oRegraProduto := TRegraProduto.Create;

  if not(Assigned(oModelProduto)) then
    oModelProduto := TModelProduto.Create;
end;

procedure TControllerProduto.CriarFormCadastro(aOwner: TComponent);
begin
  if not(Assigned(oFormularioCadastro)) then
    oFormularioCadastro := TfrmCadastroProduto.Create(aOwner);

  oFormularioCadastro.iInterfaceCrud := oControllerProduto;

  inherited;
end;

destructor TControllerProduto.Destroy;
begin
  if Assigned(oDtoProduto) then
    FreeAndNil(oDtoProduto);

  if Assigned(oRegraProduto) then
    FreeAndNil(oRegraProduto);

  if Assigned(oModelProduto) then
    FreeAndNil(oModelProduto);

  inherited;
end;

procedure TControllerProduto.Editar(Sender: TObject);
begin
  inherited;
  // resgatando dados da linha selecionada no DBGrid
  // resgatando IdProduto e setando no Edit
  TfrmCadastroProduto(oFormularioCadastro).edtIdCodigo.Text :=
    oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('ID').AsString;

  // resgatando Nome do Produto e setando no Edit
  TfrmCadastroProduto(oFormularioCadastro).edtNome.Text :=
    oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('Nome').AsString;

   // resgatando se o produto tem sabor e setando no Edit


    // resgatando o valor e setando no Edit
  TfrmCadastroProduto(oFormularioCadastro).edtValor.Text :=
    oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('Valor').AsString;

  FecharFormListagem(oFormularioListagem);

  AjustarModoInsercao(true);
  //
end;

procedure TControllerProduto.Excluir;
begin
  inherited;
  // resgatando idingredient do DBGrid e setando no DTO
  oDtoProduto.idProduto := oFormularioListagem.dbGridListagem.SelectedField.DataSet.
    FieldByName('ID').AsInteger;

  if MessageDlg('Deseja realmente excluir?', mtConfirmation, mbYesNo, 0) = mrYes then
  begin
    if oRegraProduto.Excluir(oModelProduto, oDtoProduto) then
    begin
      PreencherGrid(oFormularioListagem.dbGridListagem);
      ShowMessage('Registro excluído com sucesso.');
    end
    else
    begin
      PreencherGrid(oFormularioListagem.dbGridListagem);
      ShowMessage('Não foi possível excluir.');
    end;
  end;
end;

procedure TControllerProduto.FecharFormCadastro(ASender: TObject);
begin
  inherited;
end;

procedure TControllerProduto.FecharFormListagem(ASender: TObject);
begin
  inherited;
end;

procedure TControllerProduto.LimparDto();
begin
  ODtoProduto.idProduto := 0;
  ODtoProduto.Valor := 0;
  ODtoProduto.Nome := EmptyStr;
  //Radio
end;

procedure TControllerProduto.Localizar;
begin
  if not(Assigned(TfrmListagemProduto(oFormularioListagem))) then
    TfrmListagemProduto(oFormularioListagem) := TfrmListagemProduto.Create(aOwner);

  TfrmListagemProduto(oFormularioListagem).iInterfaceCrud := oControllerProduto;

  PreencherGrid(TfrmListagemProduto(oFormularioListagem).dbGridListagem);
  inherited;
end;

procedure TControllerProduto.Novo;
begin
  inherited;

  TfrmCadastroProduto(oFormularioCadastro).edtNome.SetFocus;
end;

procedure TControllerProduto.Salvar;
begin
  PreencherDTO;

  case oRegraProduto.ValidarDados(oDtoProduto) of
    resultNome:
      begin
        ShowMessage('Preencha a descrição.');
        TfrmCadastroProduto(oFormularioCadastro).edtNome.SetFocus;
      end;
    resultValor:
      begin
        ShowMessage('Preencha o valor.');
        TfrmCadastroProduto(oFormularioCadastro).edtValor.SetFocus;
      end;
 
    resultOk:
      begin
        // testa se o edit do ID está vazio
        if oDtoProduto.idProduto = 0 then
        begin
          // se o ID for vazio, testa se o nome informado ja esta cadastrado
          if oRegraProduto.VerificarProdutoCadastrado(oModelProduto, oDtoProduto)
          then
          begin
            ShowMessage('Já existe um Produto cadastrado com o nome "' +
              UpperCase(oDtoProduto.Nome) + '".');
            TfrmCadastroProduto(oFormularioCadastro).edtNome.SetFocus;
          end
          else
          // se o nome informado nao estiver cadastrado, realiza a inserção
          begin
            // testa se a inserção foi realizada
            if oRegraProduto.Inserir(oModelProduto, oDtoProduto) then
            begin
              // se a inserção for realizada
              AjustarModoInsercao(False);
              LimparFormulario;
              LimparDto;
            end;
          end;
        end
        else
        // se o edit de ID nao estiver vazio, fazer UPDATE
        begin
          // se o nome informado nao estiver cadastrado, realiza a inserção
          begin
            // testa se a inserção foi realizada
            if oRegraProduto.Editar(oModelProduto, oDtoProduto) then
            begin
              // se a alteração for realizada
              AjustarModoInsercao(False);
              LimparFormulario;
              LimparDto;
            end;
          end;
        end;
      end;
  end;

end;

procedure TControllerProduto.PreencherDTO;
begin

  if TfrmCadastroProduto(oFormularioCadastro).edtIdCodigo.Text <> '' then
    oDtoProduto.idProduto := StrToInt(TfrmCadastroProduto(oFormularioCadastro)
      .edtIdCodigo.Text)
  else
    oDtoProduto.idProduto := 0;

  oDtoProduto.Nome := Trim(TfrmCadastroProduto(oFormularioCadastro).edtNome.Text);
  oDtoProduto.Valor :=StrToCurr(Trim(TfrmCadastroProduto(oFormularioCadastro).edtValor.Text));
end;

procedure TControllerProduto.PreencherGrid(var DbGrid: TDBGrid);
begin

  if oModelProduto.Listar then
  begin
    oDataSource.DataSet := oModelProduto.oQuery;
    TfrmListagemProduto(oFormularioListagem).dbGridListagem.DataSource := oDataSource;
  end;
  AjustarListagem;
end;

end.
