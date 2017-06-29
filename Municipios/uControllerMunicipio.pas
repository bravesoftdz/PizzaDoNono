unit uControllerMunicipio;

interface

uses
  System.Classes, System.SysUtils, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Dialogs,
  Vcl.Forms, Vcl.Buttons, Vcl.DBGrids, Data.DB, System.UITypes,
  uInterfaceCRUD, uInterfaceRegra, uControllerCRUD, uDtoMunicipio,
  uModelMunicipio, uRegraMunicipio, uViewCadastroMunicipio,
  uViewListagemMunicipio, uEnumeradorCamposMunicipio;

type
  TControllerMunicipio = class(TControllerCRUD)
  private
    oRegraMunicipio: TRegraMunicipio;
    oModelMunicipio: TModelMunicipio;
    oDtoMunicipio: TDtoMunicipio;
    procedure PreencherDTO;
    procedure LimparDto(var ADtoMunicipio: TDtoMunicipio);
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
    procedure AjustarListagem; override;
  protected
    procedure OnActivateForm(Sender: TObject); override;
  end;

var
  oControllerMunicipio: TControllerMunicipio;

implementation

{ TControllerMunicipio }

procedure TControllerMunicipio.Cancelar;
begin
  inherited;
end;

constructor TControllerMunicipio.Create;
begin
  inherited;

  if not(Assigned(oDtoMunicipio)) then
    oDtoMunicipio := TDtoMunicipio.Create;

  if not(Assigned(oRegraMunicipio)) then
    oRegraMunicipio := TRegraMunicipio.Create;

  if not(Assigned(oModelMunicipio)) then
    oModelMunicipio := TModelMunicipio.Create;
end;

procedure TControllerMunicipio.CriarFormCadastro(aOwner: TComponent);
begin
  if not(Assigned(oFormularioCadastro)) then
    oFormularioCadastro := TfrmCadastroMunicipio.Create(aOwner);

  oFormularioCadastro.iInterfaceCrud := oControllerMunicipio;

  ListarEstados(TfrmCadastroMunicipio(oFormularioCadastro).cmbEstado);
  oFormularioCadastro.OnActivate := OnActivateForm;
  inherited;
end;

procedure TControllerMunicipio.AjustarListagem;
begin
  if not(oRegraMunicipio.CountRegistros(oModelMunicipio)) then
    inherited;
end;

destructor TControllerMunicipio.Destroy;
begin
  if Assigned(oDtoMunicipio) then
    FreeAndNil(oDtoMunicipio);

  if Assigned(oRegraMunicipio) then
    FreeAndNil(oRegraMunicipio);

  if Assigned(oModelMunicipio) then
    FreeAndNil(oModelMunicipio);

  inherited;
end;

procedure TControllerMunicipio.Editar(Sender: TObject);
var
  nomeEstado: string;
begin
  inherited;
  // resgatando dados da linha selecionada no DBGrid
  // resgatando idmunicipio e setando no Edit
  TfrmCadastroMunicipio(oFormularioCadastro).edtIdCodigo.Text :=
    oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('idmunicipio').AsString;

  // resgatando Nome do municipio e setando no Edit
  TfrmCadastroMunicipio(oFormularioCadastro).edtNome.Text :=
    oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('nome').AsString;

  // resgatando nome do estado
  nomeEstado := oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName
    ('estado').AsString;
  //setando estado no combobox
  TfrmCadastroMunicipio(oFormularioCadastro).cmbEstado.ItemIndex :=
    TfrmCadastroMunicipio(oFormularioCadastro).cmbEstado.Items.IndexOf(nomeEstado);

  FecharFormListagem(oFormularioListagem);

  AjustarModoInsercao(true);
end;

procedure TControllerMunicipio.Excluir;
begin

  // resgatando idmunicipio e setando no DTO
  oDtoMunicipio.IdMunicipio := StrToInt(TfrmCadastroMunicipio(oFormularioCadastro)
    .edtIdCodigo.Text);

  if MessageDlg('Deseja realmente excluir?', mtConfirmation, mbYesNo, 0) = mrYes then
  begin
    if oRegraMunicipio.Excluir(oModelMunicipio, oDtoMunicipio) then
    begin
      inherited;
      ShowMessage('Registro excluído com sucesso.');
    end
    else
    begin
      ShowMessage('Não foi possível excluir.');
    end;
  end
end;

procedure TControllerMunicipio.FecharFormCadastro(ASender: TObject);
begin
  inherited;
  oControllerMunicipio := nil;
end;

procedure TControllerMunicipio.FecharFormListagem(ASender: TObject);
begin
  inherited;
end;

procedure TControllerMunicipio.AjustarModoInsercao(AStatusBtnSalvar: Boolean);
begin
  inherited;
  TfrmCadastroMunicipio(oFormularioCadastro).labelEstado.Enabled := AStatusBtnSalvar;
  if AStatusBtnSalvar then
    TfrmCadastroMunicipio(oFormularioCadastro).edtNome.SetFocus;
end;

procedure TControllerMunicipio.LimparDto(var ADtoMunicipio: TDtoMunicipio);
begin
  ADtoMunicipio.IdMunicipio := 0;
  ADtoMunicipio.Nome := EmptyStr;
  ADtoMunicipio.Estado := 0;
end;

procedure TControllerMunicipio.Localizar;
begin
  if not(Assigned(TfrmListagemMunicipio(oFormularioListagem))) then
    TfrmListagemMunicipio(oFormularioListagem) := TfrmListagemMunicipio.Create(aOwner);

  TfrmListagemMunicipio(oFormularioListagem).iInterfaceCrud := oControllerMunicipio;

  PreencherGrid(TfrmListagemMunicipio(oFormularioListagem).dbGridListagem);

  inherited;
end;

procedure TControllerMunicipio.Novo;
begin
  inherited;
end;



procedure TControllerMunicipio.OnActivateForm(Sender: TObject);
begin
  inherited;
  ListarEstados(TfrmCadastroMunicipio(oFormularioCadastro).cmbEstado);
end;

procedure TControllerMunicipio.Salvar;
begin
  PreencherDTO;
  case oRegraMunicipio.ValidarDados(oDtoMunicipio) of
    resultNome:
      begin
        ShowMessage('Preencha o campo Nome.');
        TfrmCadastroMunicipio(oFormularioCadastro).edtNome.SetFocus;
      end;
    resultUF:
      begin
        ShowMessage('Selecione o Estado.');
        TfrmCadastroMunicipio(oFormularioCadastro).cmbEstado.SetFocus;
      end;
    resultOk:
      begin
        // testa se o edit do ID está vazio
        if oDtoMunicipio.IdMunicipio = 0 then
        begin
          // se o ID for vazio, testa se o nome informado ja esta cadastrado
          if oRegraMunicipio.VerificarMunicipioCadastrado(oModelMunicipio, oDtoMunicipio) then
          begin
            ShowMessage('Já existe um município com o nome "' + UpperCase(oDtoMunicipio.Nome) +
              '" associado ao estado selecionado.');
            TfrmCadastroMunicipio(oFormularioCadastro).edtNome.SetFocus;
          end
          else
          // se o nome informado nao estiver cadastrado, realiza a inserção
          begin
            // testa se a inserção foi realizada
            if oRegraMunicipio.Inserir(oModelMunicipio, oDtoMunicipio) then
            begin
              // se a inserção for realizada
              AjustarModoInsercao(False);
              LimparFormulario;
              LimparDto(oDtoMunicipio);
              inherited;
            end;
          end;
        end
        else
        // se o edit de ID nao estiver vazio, fazer UPDATE
        begin
          if oRegraMunicipio.VerificarMunicipioCadastrado(oModelMunicipio, oDtoMunicipio) then
          begin
            ShowMessage('Já existe um município com o nome "' + UpperCase(oDtoMunicipio.Nome) +
              '" associado ao estado selecionado.');
            TfrmCadastroMunicipio(oFormularioCadastro).edtNome.SetFocus;
          end
          else
          // se o nome informado nao estiver cadastrado, realiza a alteracao
          begin
            // testa se a inserção foi realizada
            if oRegraMunicipio.Editar(oModelMunicipio, oDtoMunicipio) then
            begin
              // se a alteração for realizada
              AjustarModoInsercao(False);
              LimparFormulario;
              LimparDto(oDtoMunicipio);
              inherited;
            end;
          end;
        end;
      end;
  end;

end;

procedure TControllerMunicipio.PreencherDTO;
begin
  if TfrmCadastroMunicipio(oFormularioCadastro).edtIdCodigo.Text <> '' then
    oDtoMunicipio.IdMunicipio := StrToInt(TfrmCadastroMunicipio(oFormularioCadastro)
      .edtIdCodigo.Text);

  oDtoMunicipio.Nome := Trim(TfrmCadastroMunicipio(oFormularioCadastro).edtNome.Text);

  if TfrmCadastroMunicipio(oFormularioCadastro).cmbEstado.ItemIndex > -1 then
  begin
    oDtoMunicipio.Estado := Integer(TfrmCadastroMunicipio(oFormularioCadastro)
      .cmbEstado.Items.Objects[TfrmCadastroMunicipio(oFormularioCadastro).cmbEstado.ItemIndex]);
  end;

end;

procedure TControllerMunicipio.PreencherGrid(var DbGrid: TDBGrid);
begin

  if oModelMunicipio.Listar then
  begin
    oDataSource.DataSet := oModelMunicipio.oQuery;
    TfrmListagemMunicipio(oFormularioListagem).dbGridListagem.DataSource := oDataSource;
  end;
  AjustarListagem;
end;

end.
