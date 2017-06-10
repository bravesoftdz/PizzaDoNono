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
    procedure Editar; override;
    procedure Excluir; override;
    procedure CriarFormCadastro(aOwner: TComponent); override;
    procedure FecharFormCadastro(ASender: TObject); override;
    procedure FecharFormListagem(ASender: TObject); override;
    procedure AjustarModoInsercao(AStatusBtnSalvar: Boolean); override;
  end;

var
  oControllerMunicipio: TControllerMunicipio;

implementation

{ TControllerUsuario }

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

procedure TControllerMunicipio.Editar;
var
  nomeEstado: string;
begin
  inherited;
  // resgatando dados da linha selecionada no DBGrid
  // resgatando idmunicipio e setando no Edit
  TfrmCadastroMunicipio(oFormularioCadastro).edtIdCodigo.Text :=
    oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('ID').AsString;

  // resgatando Nome do municipio e setando no Edit
  TfrmCadastroMunicipio(oFormularioCadastro).edtNome.Text :=
    oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('Nome').AsString;

  // resgatando nome do estado
  nomeEstado := oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('Estado').AsString;

  TfrmCadastroMunicipio(oFormularioCadastro).cmbEstado.ItemIndex := TfrmCadastroMunicipio(oFormularioCadastro)
    .cmbEstado.Items.IndexOf(nomeEstado);

  FecharFormListagem(oFormularioListagem);

  AjustarModoInsercao(true);
end;

procedure TControllerMunicipio.Excluir;
begin
  inherited;
  // resgatando idmunicipio do DBGrid e setando no DTO
  oDtoMunicipio.IdMunicipio := oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('ID').AsInteger;

  if MessageDlg('Deseja realmente excluir?', mtConfirmation, mbYesNo, 0) = mrYes then
  begin
    if oRegraMunicipio.Excluir(oModelMunicipio, oDtoMunicipio) then
    begin
      PreencherGrid(oFormularioListagem.dbGridListagem);
      ShowMessage('Registro exclu�do com sucesso.');
    end
    else
    begin
      PreencherGrid(oFormularioListagem.dbGridListagem);
      ShowMessage('N�o foi poss�vel excluir.');
    end;
  end
end;

procedure TControllerMunicipio.FecharFormCadastro(ASender: TObject);
begin
  inherited;
end;

procedure TControllerMunicipio.FecharFormListagem(ASender: TObject);
begin
  inherited;
end;

procedure TControllerMunicipio.AjustarModoInsercao(AStatusBtnSalvar: Boolean);
begin
  inherited;
  TfrmCadastroMunicipio(oFormularioCadastro).labelEstado.Enabled := AStatusBtnSalvar;
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
  TfrmCadastroMunicipio(oFormularioCadastro).edtNome.SetFocus;
end;

procedure TControllerMunicipio.Salvar;
begin
  PreencherDTO;
  case oRegraMunicipio.ValidarDados(oDtoMunicipio) of
    resultNome:
      begin
        showMessage('Preencha o campo Nome.');
        TfrmCadastroMunicipio(oFormularioCadastro).edtNome.SetFocus;
      end;
    resultUF:
      begin
        showMessage('Selecione o Estado.');
        TfrmCadastroMunicipio(oFormularioCadastro).cmbEstado.SetFocus;
      end;
    resultOk:
      begin
        // testa se o edit do ID est� vazio
        if oDtoMunicipio.IdMunicipio = 0 then
        begin
          // se o ID for vazio, testa se o nome informado ja esta cadastrado
          if oRegraMunicipio.VerificarMunicipioCadastrado(oModelMunicipio, oDtoMunicipio) then
          begin
            showMessage('J� existe um munic�pio com o nome "' + UpperCase(oDtoMunicipio.Nome) +
              '" associado ao estado selecionado.');
            TfrmCadastroMunicipio(oFormularioCadastro).edtNome.SetFocus;
          end
          else
          // se o nome informado nao estiver cadastrado, realiza a inser��o
          begin
            // testa se a inser��o foi realizada
            if oRegraMunicipio.Inserir(oModelMunicipio, oDtoMunicipio) then
            begin
              // se a inser��o for realizada
              AjustarModoInsercao(False);
              LimparFormulario;
              LimparDto(oDtoMunicipio);
            end;
          end;
        end
        else
        // se o edit de ID nao estiver vazio, fazer UPDATE
        begin
          if oRegraMunicipio.VerificarMunicipioCadastrado(oModelMunicipio, oDtoMunicipio) then
          begin
            showMessage('J� existe um munic�pio com o nome "' + UpperCase(oDtoMunicipio.Nome) +
              '" associado ao estado selecionado.');
            TfrmCadastroMunicipio(oFormularioCadastro).edtNome.SetFocus;
          end
          else
          // se o nome informado nao estiver cadastrado, realiza a alteracao
          begin
            // testa se a inser��o foi realizada
            if oRegraMunicipio.Editar(oModelMunicipio, oDtoMunicipio) then
            begin
              // se a altera��o for realizada
              AjustarModoInsercao(False);
              LimparFormulario;
              LimparDto(oDtoMunicipio);
            end;
          end;
        end;
      end;
  end;
end;

procedure TControllerMunicipio.PreencherDTO;
begin
  if TfrmCadastroMunicipio(oFormularioCadastro).edtIdCodigo.Text <> '' then
    oDtoMunicipio.IdMunicipio := StrToInt(TfrmCadastroMunicipio(oFormularioCadastro).edtIdCodigo.Text);

  oDtoMunicipio.Nome := Trim(TfrmCadastroMunicipio(oFormularioCadastro).edtNome.Text);

  if TfrmCadastroMunicipio(oFormularioCadastro).cmbEstado.ItemIndex > -1 then
  begin
    oDtoMunicipio.Estado := Integer(TfrmCadastroMunicipio(oFormularioCadastro).cmbEstado.Items.Objects
      [TfrmCadastroMunicipio(oFormularioCadastro).cmbEstado.ItemIndex]);
  end;

end;

procedure TControllerMunicipio.PreencherGrid(var DbGrid: TDBGrid);
begin

  if oModelMunicipio.Listar then
  begin
    oDataSource.DataSet := oModelMunicipio.oQuery;
    TfrmListagemMunicipio(oFormularioListagem).dbGridListagem.DataSource := oDataSource;
  end;
end;

end.