unit uControllerSabor;

interface

uses
  System.Classes, System.SysUtils, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Dialogs,
  Vcl.Forms, Vcl.Buttons, Vcl.DBGrids, Data.DB, System.Generics.Collections,
  System.UITypes, Vcl.Mask, Vcl.CheckLst,
  uInterfaceCRUD, uInterfaceRegra, uControllerCRUD, uDtoSabor,
  uModelSabor, uRegraSabor, uViewCadastroSabor, uViewListagemSabor,
  uEnumeradorCamposSabor, uListaIngrediente, uModelIngrediente,
  uDtoIngrediente, uListaTamanho, uModelTamanho, uDtoTamanho;

type
  TControllerSabor = class(TControllerCRUD)
  private
    oRegraSabor: TRegraSabor;
    oModelSabor: TModelSabor;
    oDtoSabor: TDtoSabor;

    procedure PreencherDTO;
    procedure LimparDto;
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
    procedure ListarIngredientes(var ACheckListBoxIngredientes: TCheckListBox);
    procedure ListarTamanhos(var AcmbTamanho: TComboBox);
    procedure CriarFormCadastro(aOwner: TComponent); override;
    procedure FecharFormCadastro(ASender: TObject); override;
    procedure FecharFormListagem(ASender: TObject); override;
    procedure AjustarListagem; override;

  end;

var
  oControllerSabor: TControllerSabor;

implementation

{ TControllerSabor }

procedure TControllerSabor.AjustarListagem;
begin
  if not(oRegraSabor.CountRegistros(oModelSabor)) then
    inherited;
end;

procedure TControllerSabor.Cancelar;
begin
  inherited;
end;

constructor TControllerSabor.Create;
begin
  inherited;

  if not(Assigned(oDtoSabor)) then
    oDtoSabor := TDtoSabor.Create;

  if not(Assigned(oRegraSabor)) then
    oRegraSabor := TRegraSabor.Create;

  if not(Assigned(oModelSabor)) then
    oModelSabor := TModelSabor.Create;
end;

procedure TControllerSabor.CriarFormCadastro(aOwner: TComponent);

begin
  if not(Assigned(oFormularioCadastro)) then
    oFormularioCadastro := TfrmCadastroSabor.Create(aOwner);

  oFormularioCadastro.iInterfaceCrud := oControllerSabor;

  ListarTamanhos(TfrmCadastroSabor(oFormularioCadastro).cmbTamanho);

  ListarIngredientes(TfrmCadastroSabor(oFormularioCadastro).CheckListBoxIngredientes);
  inherited;
end;

destructor TControllerSabor.Destroy;
begin
  if Assigned(oDtoSabor) then
    FreeAndNil(oDtoSabor);

  if Assigned(oRegraSabor) then
    FreeAndNil(oRegraSabor);

  if Assigned(oModelSabor) then
    FreeAndNil(oModelSabor);

  inherited;
end;

procedure TControllerSabor.Editar(Sender: TObject);
begin
  inherited;
  // resgatando dados da linha selecionada no DBGrid
  // resgatando IdTSabor e setando no Edit
  TfrmCadastroSabor(oFormularioCadastro).edtIdCodigo.Text :=
    oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('ID').AsString;

  // resgatando Nome do Sabor e setando no Edit
  TfrmCadastroSabor(oFormularioCadastro).edtNome.Text :=
    oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('Nome').AsString;

  // resgatando Valor do Sabor e setando no Edit
  TfrmCadastroSabor(oFormularioCadastro).edtValor.Text :=
    oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('Valor').AsString;

  FecharFormListagem(oFormularioListagem);

  AjustarModoInsercao(true);
  //
end;

procedure TControllerSabor.Excluir;
begin
  inherited;
  // resgatando Sabor do DBGrid e setando no DTO
  oDtoSabor.idSabor := oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('ID')
    .AsInteger;

  if MessageDlg('Deseja realmente excluir?', mtConfirmation, mbYesNo, 0) = mrYes then
  begin
    if oRegraSabor.Excluir(oModelSabor, oDtoSabor) then
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

procedure TControllerSabor.FecharFormCadastro(ASender: TObject);
begin
  inherited;
end;

procedure TControllerSabor.FecharFormListagem(ASender: TObject);
begin
  inherited;
end;

procedure TControllerSabor.LimparDto;
begin
  oDtoSabor.idSabor := 0;
  oDtoSabor.Nome := EmptyStr;
  oDtoSabor.Ingrediente := nil;
  oDtoSabor.Tamanho := 0;
  oDtoSabor.Valor := 0;
end;

procedure TControllerSabor.ListarIngredientes(var ACheckListBoxIngredientes: TCheckListBox);
var
  oListaIngrediente: TListaIngrediente;
  oModelIngrediente: TModelIngrediente;
  oDtoIngrediente: TDtoIngrediente;
begin
  ACheckListBoxIngredientes.Items.Clear;
  oModelIngrediente := TModelIngrediente.Create;
  try

    oListaIngrediente := TListaIngrediente.Create([doOwnsValues]);

    if oModelIngrediente.ListarIngredientes(oListaIngrediente) then
    begin
      for oDtoIngrediente in oListaIngrediente.Values do
        ACheckListBoxIngredientes.Items.AddObject(oDtoIngrediente.Nome, TObject(oDtoIngrediente.idIngrediente));
    end;
  finally
    if Assigned(oModelIngrediente) then
      FreeAndNil(oModelIngrediente);

    if Assigned(oListaIngrediente) then
      FreeAndNil(oListaIngrediente);
  end;
end;

procedure TControllerSabor.ListarTamanhos(var AcmbTamanho: TComboBox);
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
        AcmbTamanho.Items.AddObject(oDtoTamanho.Nome, TObject(oDtoTamanho.IdTamanho));
    end;
  finally
    if Assigned(oModelTamanho) then
      FreeAndNil(oModelTamanho);

    if Assigned(oListaTamanho) then
      FreeAndNil(oListaTamanho);
  end;

end;

procedure TControllerSabor.Localizar;
begin
  if not(Assigned(TfrmListagemSabor(oFormularioListagem))) then
    TfrmListagemSabor(oFormularioListagem) := TfrmListagemSabor.Create(aOwner);

  TfrmListagemSabor(oFormularioListagem).iInterfaceCrud := oControllerSabor;

  PreencherGrid(TfrmListagemSabor(oFormularioListagem).dbGridListagem);
  inherited;
end;

procedure TControllerSabor.Novo;
begin
  inherited;

  TfrmCadastroSabor(oFormularioCadastro).edtNome.SetFocus;
end;

procedure TControllerSabor.Salvar;
begin
  PreencherDTO;

  case oRegraSabor.ValidarDados(oDtoSabor) of
    resultNome:
      begin
        ShowMessage('Preencha a descrição.');
        TfrmCadastroSabor(oFormularioCadastro).edtNome.SetFocus;
      end;
    resultTamanho:
      begin
        ShowMessage('Selecione o Tamanho.');
        TfrmCadastroSabor(oFormularioCadastro).cmbTamanho.SetFocus;
      end;
    resultValor:
      begin
        ShowMessage('Informe o preço do sabor.');
        TfrmCadastroSabor(oFormularioCadastro).edtValor.SetFocus;
      end;
    resultIngrediente:
      begin
        ShowMessage('Selecione os ingredientes que compõem o sabor.');
        TfrmCadastroSabor(oFormularioCadastro).edtNome.SetFocus;
      end;
    resultOk:
      begin
        // se o ID for vazio, testa se o nome informado ja esta cadastrado
        if oRegraSabor.VerificarSaborCadastrado(oModelSabor, oDtoSabor) then
        begin
          ShowMessage('Já existe um sabor cadastrado com o nome "' + UpperCase(oDtoSabor.Nome) +
            '" para o tamanho selecionado.');
          TfrmCadastroSabor(oFormularioCadastro).edtNome.SetFocus;
        end
        else // se o nome informado nao estiver cadastrado, realiza a inserção
        begin
          // testa se o edit do ID está vazio
          if oDtoSabor.idSabor = 0 then

          begin
            // testa se a inserção foi realizada
            if oRegraSabor.Inserir(oModelSabor, oDtoSabor) then
            begin
              // se a inserção for realizada
              AjustarModoInsercao(False);
              LimparFormulario;
              LimparDto;
            end;
          end
          else
          // se o edit de ID nao estiver vazio, fazer UPDATE
          begin
            // testa se a alteração foi realizada
            if oRegraSabor.Editar(oModelSabor, oDtoSabor) then
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

procedure TControllerSabor.PreencherDTO;
var
  oDtoIngrediente: TDtoIngrediente;
  oListaIngrediente: TListaIngrediente;
  i: integer;
begin
  if TfrmCadastroSabor(oFormularioCadastro).edtIdCodigo.Text <> EmptyStr then
    oDtoSabor.idSabor := StrToIntDef(TfrmCadastroSabor(oFormularioCadastro).edtIdCodigo.Text, 0);

  oDtoSabor.Nome := Trim(TfrmCadastroSabor(oFormularioCadastro).edtNome.Text);

  oDtoSabor.Valor := StrToCurrDef(Trim(TfrmCadastroSabor(oFormularioCadastro).edtValor.Text), 0);

  if TfrmCadastroSabor(oFormularioCadastro).cmbTamanho.ItemIndex > -1 then
  begin
    oDtoSabor.Tamanho := integer(TfrmCadastroSabor(oFormularioCadastro).cmbTamanho.Items.Objects
      [TfrmCadastroSabor(oFormularioCadastro).cmbTamanho.ItemIndex]);
  end;

  if TfrmCadastroSabor(oFormularioCadastro).CheckListBoxIngredientes.ItemIndex > -1 then
  begin
    oListaIngrediente := TListaIngrediente.Create([doOwnsValues]);
    try
      for i := 0 to TfrmCadastroSabor(oFormularioCadastro)
        .CheckListBoxIngredientes.Items.Count - 1 do
      begin
        if TfrmCadastroSabor(oFormularioCadastro).CheckListBoxIngredientes.Checked[i] then
        begin
          oDtoIngrediente := TDtoIngrediente.Create;
          oDtoIngrediente.Nome := TfrmCadastroSabor(oFormularioCadastro)
            .CheckListBoxIngredientes.Items.Strings[i];
          oDtoIngrediente.IdIngrediente :=
            integer(TfrmCadastroSabor(oFormularioCadastro).CheckListBoxIngredientes.Items.Objects[i]);
          oListaIngrediente.Add(oDtoIngrediente.Nome, oDtoIngrediente);
        end;
      end;
    finally
      oDtoSabor.Ingrediente := oListaIngrediente;

    end;
  end
  else
    oDtoSabor.Ingrediente := nil;
end;

procedure TControllerSabor.PreencherGrid(var DbGrid: TDBGrid);
begin

  if oModelSabor.Listar then
  begin
    oDataSource.DataSet := oModelSabor.oQuery;
    TfrmListagemSabor(oFormularioListagem).dbGridListagem.DataSource := oDataSource;
  end;
  AjustarListagem;
end;

end.
