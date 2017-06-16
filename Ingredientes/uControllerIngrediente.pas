unit uControllerIngrediente;

interface

uses
  System.Classes, System.SysUtils, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Dialogs,
  Vcl.Forms, Vcl.Buttons, Vcl.DBGrids, Data.DB, System.Generics.Collections, System.UITypes,
  uInterfaceCRUD, uInterfaceRegra, uControllerCRUD, uDtoIngrediente,
  uModelIngrediente, uRegraIngrediente, uViewCadastroIngrediente,
  uViewListagemIngrediente, uEnumeradorCamposIngrediente;

type
  TControllerIngrediente = class(TControllerCRUD)
  private
    oRegraIngrediente: TRegraIngrediente;
    oModelIngrediente: TModelIngrediente;
    oDtoIngrediente: TDtoIngrediente;

    procedure PreencherDTO;
    procedure LimparDto(var ADtoIngrediente: TDtoIngrediente);
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
  end;

var
  oControllerIngrediente: TControllerIngrediente;

implementation

{ TControllerUsuario }

procedure TControllerIngrediente.Cancelar;
begin
  inherited;
end;

constructor TControllerIngrediente.Create;
begin
  inherited;

  if not(Assigned(oDtoIngrediente)) then
    oDtoIngrediente := TDtoIngrediente.Create;

  if not(Assigned(oRegraIngrediente)) then
    oRegraIngrediente := TRegraIngrediente.Create;

  if not(Assigned(oModelIngrediente)) then
    oModelIngrediente := TModelIngrediente.Create;
end;

procedure TControllerIngrediente.CriarFormCadastro(aOwner: TComponent);
begin
  if not(Assigned(oFormularioCadastro)) then
    oFormularioCadastro := TfrmCadastroIngrediente.Create(aOwner);

  oFormularioCadastro.iInterfaceCrud := oControllerIngrediente;

  inherited;
end;

destructor TControllerIngrediente.Destroy;
begin
  if Assigned(oDtoIngrediente) then
    FreeAndNil(oDtoIngrediente);

  if Assigned(oRegraIngrediente) then
    FreeAndNil(oRegraIngrediente);

  if Assigned(oModelIngrediente) then
    FreeAndNil(oModelIngrediente);

  inherited;
end;

procedure TControllerIngrediente.Editar(Sender: TObject);
begin
  inherited;
  // resgatando dados da linha selecionada no DBGrid
  // resgatando IdIgrediente e setando no Edit
  TfrmCadastroIngrediente(oFormularioCadastro).edtIdCodigo.Text :=
    oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('ID').AsString;

  // resgatando Nome do ingrediente e setando no Edit
  TfrmCadastroIngrediente(oFormularioCadastro).edtNome.Text :=
    oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('Nome').AsString;

  FecharFormListagem(oFormularioListagem);

  AjustarModoInsercao(true);
  //
end;

procedure TControllerIngrediente.Excluir;
begin
  inherited;
  // resgatando idingredient do DBGrid e setando no DTO
  oDtoIngrediente.idIngrediente := oFormularioListagem.dbGridListagem.SelectedField.DataSet.
    FieldByName('ID').AsInteger;

  if MessageDlg('Deseja realmente excluir?', mtConfirmation, mbYesNo, 0) = mrYes then
  begin
    if oRegraIngrediente.Excluir(oModelIngrediente, oDtoIngrediente) then
    begin
      PreencherGrid(oFormularioListagem.dbGridListagem);
      ShowMessage('Registro exclu�do com sucesso.');
    end
    else
    begin
      PreencherGrid(oFormularioListagem.dbGridListagem);
      ShowMessage('N�o foi poss�vel excluir.');
    end;
  end;
end;

procedure TControllerIngrediente.FecharFormCadastro(ASender: TObject);
begin
  inherited;
end;

procedure TControllerIngrediente.FecharFormListagem(ASender: TObject);
begin
  inherited;
end;

procedure TControllerIngrediente.LimparDto(var ADtoIngrediente: TDtoIngrediente);
begin
  ADtoIngrediente.idIngrediente := 0;
  ADtoIngrediente.Nome := EmptyStr;
end;

procedure TControllerIngrediente.Localizar;
begin
  if not(Assigned(TfrmListagemIngrediente(oFormularioListagem))) then
    TfrmListagemIngrediente(oFormularioListagem) := TfrmListagemIngrediente.Create(aOwner);

  TfrmListagemIngrediente(oFormularioListagem).iInterfaceCrud := oControllerIngrediente;

  PreencherGrid(TfrmListagemIngrediente(oFormularioListagem).dbGridListagem);
  inherited;
end;

procedure TControllerIngrediente.Novo;
begin
  inherited;

  TfrmCadastroIngrediente(oFormularioCadastro).edtNome.SetFocus;
end;

procedure TControllerIngrediente.Salvar;
begin
  PreencherDTO;

  case oRegraIngrediente.ValidarDados(oDtoIngrediente) of
    resultNome:
      begin
        ShowMessage('Informe o nome do Ingrediente.');
        TfrmCadastroIngrediente(oFormularioCadastro).edtNome.SetFocus;
      end;
    resultOk:
      begin
        // testa se o edit do ID est� vazio
        if oDtoIngrediente.idIngrediente = 0 then
        begin
          // se o ID for vazio, testa se o nome informado ja esta cadastrado
          if oRegraIngrediente.VerificarIngredienteCadastrado(oModelIngrediente, oDtoIngrediente)
          then
          begin
            ShowMessage('J� existe um ingrediente cadastrado com o nome "' +
              UpperCase(oDtoIngrediente.Nome) + '".');
            TfrmCadastroIngrediente(oFormularioCadastro).edtNome.SetFocus;
          end
          else
          // se o nome informado nao estiver cadastrado, realiza a inser��o
          begin
            // testa se a inser��o foi realizada
            if oRegraIngrediente.Inserir(oModelIngrediente, oDtoIngrediente) then
            begin
              // se a inser��o for realizada
              AjustarModoInsercao(False);
              LimparFormulario;
              LimparDto(oDtoIngrediente);
            end;
          end;
        end
        else
        // se o edit de ID nao estiver vazio, fazer UPDATE
        begin
          // se o nome informado nao estiver cadastrado, realiza a inser��o
          begin
            // testa se a inser��o foi realizada
            if oRegraIngrediente.Editar(oModelIngrediente, oDtoIngrediente) then
            begin
              // se a altera��o for realizada
              AjustarModoInsercao(False);
              LimparFormulario;
              LimparDto(oDtoIngrediente);
            end;
          end;
        end;
      end;
  end;

end;

procedure TControllerIngrediente.PreencherDTO;
begin

  if TfrmCadastroIngrediente(oFormularioCadastro).edtIdCodigo.Text <> '' then
    oDtoIngrediente.idIngrediente := StrToInt(TfrmCadastroIngrediente(oFormularioCadastro)
      .edtIdCodigo.Text)
  else
    oDtoIngrediente.idIngrediente := 0;

  oDtoIngrediente.Nome := Trim(TfrmCadastroIngrediente(oFormularioCadastro).edtNome.Text);

end;

procedure TControllerIngrediente.PreencherGrid(var DbGrid: TDBGrid);
begin

  if oModelIngrediente.Listar then
  begin
    oDataSource.DataSet := oModelIngrediente.oQuery;
    TfrmListagemIngrediente(oFormularioListagem).dbGridListagem.DataSource := oDataSource;
  end;
end;

end.
