unit uControllerTamanho;

interface

uses
  System.Classes, System.SysUtils, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Dialogs,
  Vcl.Forms, Vcl.Buttons, Vcl.DBGrids, Data.DB, System.Generics.Collections, System.UITypes,
  uInterfaceCRUD, uInterfaceRegra, uControllerCRUD, uDtoTamanho,
  uModelTamanho, uRegraTamanho, uViewCadastroTamanho,
  uViewListagemTamanho, uEnumeradorCamposTamanho;

type
  TControllerTamanho = class(TControllerCRUD)
  private
    oRegraTamanho: TRegraTamanho;
    oModelTamanho: TModelTamanho;
    oDtoTamanho: TDtoTamanho;

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
  oControllerTamanho: TControllerTamanho;

implementation

{ TControllerUsuario }

procedure TControllerTamanho.AjustarListagem;
begin
  if not(oRegraTamanho.CountRegistros(oModelTamanho)) then
    inherited;
end;

procedure TControllerTamanho.Cancelar;
begin
  inherited;
end;

constructor TControllerTamanho.Create;
begin
  inherited;

  if not(Assigned(oDtoTamanho)) then
    oDtoTamanho := TDtoTamanho.Create;

  if not(Assigned(oRegraTamanho)) then
    oRegraTamanho := TRegraTamanho.Create;

  if not(Assigned(oModelTamanho)) then
    oModelTamanho := TModelTamanho.Create;
end;

procedure TControllerTamanho.CriarFormCadastro(aOwner: TComponent);
begin
  if not(Assigned(oFormularioCadastro)) then
    oFormularioCadastro := TfrmCadastroTamanho.Create(aOwner);

  oFormularioCadastro.iInterfaceCrud := oControllerTamanho;

  inherited;
end;

destructor TControllerTamanho.Destroy;
begin
  if Assigned(oDtoTamanho) then
    FreeAndNil(oDtoTamanho);

  if Assigned(oRegraTamanho) then
    FreeAndNil(oRegraTamanho);

  if Assigned(oModelTamanho) then
    FreeAndNil(oModelTamanho);

  inherited;
end;

procedure TControllerTamanho.Editar(Sender: TObject);
begin
  inherited;
  // resgatando dados da linha selecionada no DBGrid
  // resgatando IdTamanho e setando no Edit
  TfrmCadastroTamanho(oFormularioCadastro).edtIdCodigo.Text :=
    oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('ID').AsString;

  // resgatando Nome do tamanho e setando no Edit
  TfrmCadastroTamanho(oFormularioCadastro).edtNome.Text :=
    oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('Nome').AsString;

    // resgatando o maximo de sabores e setando no Edit
  TfrmCadastroTamanho(oFormularioCadastro).edtMaxSabores.Text :=
    oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('MaxSabores').AsString;

  FecharFormListagem(oFormularioListagem);

  AjustarModoInsercao(true);
  //
end;

procedure TControllerTamanho.Excluir;
begin
  inherited;
  // resgatando idingredient do DBGrid e setando no DTO
  oDtoTamanho.idTamanho := oFormularioListagem.dbGridListagem.SelectedField.DataSet.
    FieldByName('ID').AsInteger;

  if MessageDlg('Deseja realmente excluir?', mtConfirmation, mbYesNo, 0) = mrYes then
  begin
    if oRegraTamanho.Excluir(oModelTamanho, oDtoTamanho) then
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

procedure TControllerTamanho.FecharFormCadastro(ASender: TObject);
begin
  inherited;
end;

procedure TControllerTamanho.FecharFormListagem(ASender: TObject);
begin
  inherited;
end;

procedure TControllerTamanho.LimparDto();
begin
  ODtoTamanho.idTamanho := 0;
  ODtoTamanho.MaxSabores := 0;
  ODtoTamanho.Nome := EmptyStr;
end;

procedure TControllerTamanho.Localizar;
begin
  if not(Assigned(TfrmListagemTamanho(oFormularioListagem))) then
    TfrmListagemTamanho(oFormularioListagem) := TfrmListagemTamanho.Create(aOwner);

  TfrmListagemTamanho(oFormularioListagem).iInterfaceCrud := oControllerTamanho;

  PreencherGrid(TfrmListagemTamanho(oFormularioListagem).dbGridListagem);
  inherited;
end;

procedure TControllerTamanho.Novo;
begin
  inherited;

  TfrmCadastroTamanho(oFormularioCadastro).edtNome.SetFocus;
end;

procedure TControllerTamanho.Salvar;
begin
  PreencherDTO;

  case oRegraTamanho.ValidarDados(oDtoTamanho) of
    resultNome:
      begin
        ShowMessage('Preencha a descrição.');
        TfrmCadastroTamanho(oFormularioCadastro).edtNome.SetFocus;
      end;
    resultMaxSabores:
      begin
        ShowMessage('Informe a quantidade máxima de sabores.');
        TfrmCadastroTamanho(oFormularioCadastro).edtMaxSabores.SetFocus;
      end;
    resultOk:
      begin
        // testa se o edit do ID está vazio
        if oDtoTamanho.idTamanho = 0 then
        begin
          // se o ID for vazio, testa se o nome informado ja esta cadastrado
          if oRegraTamanho.VerificarTamanhoCadastrado(oModelTamanho, oDtoTamanho)
          then
          begin
            ShowMessage('Já existe um tamanho cadastrado com o nome "' +
              UpperCase(oDtoTamanho.Nome) + '".');
            TfrmCadastroTamanho(oFormularioCadastro).edtNome.SetFocus;
          end
          else
          // se o nome informado nao estiver cadastrado, realiza a inserção
          begin
            // testa se a inserção foi realizada
            if oRegraTamanho.Inserir(oModelTamanho, oDtoTamanho) then
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
            if oRegraTamanho.Editar(oModelTamanho, oDtoTamanho) then
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

procedure TControllerTamanho.PreencherDTO;
begin

  if TfrmCadastroTamanho(oFormularioCadastro).edtIdCodigo.Text <> '' then
    oDtoTamanho.idTamanho := StrToInt(TfrmCadastroTamanho(oFormularioCadastro)
      .edtIdCodigo.Text)
  else
    oDtoTamanho.idTamanho := 0;

  oDtoTamanho.Nome := Trim(TfrmCadastroTamanho(oFormularioCadastro).edtNome.Text);
  oDtoTamanho.MaxSabores := StrToInt(Trim(TfrmCadastroTamanho(oFormularioCadastro).edtMaxSabores.Text));

end;

procedure TControllerTamanho.PreencherGrid(var DbGrid: TDBGrid);
begin

  if oModelTamanho.Listar then
  begin
    oDataSource.DataSet := oModelTamanho.oQuery;
    TfrmListagemTamanho(oFormularioListagem).dbGridListagem.DataSource := oDataSource;
  end;
  AjustarListagem;
end;

end.
