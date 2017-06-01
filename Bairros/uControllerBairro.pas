unit uControllerBairro;

interface

uses
  System.Classes, System.SysUtils, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Dialogs,
  Vcl.Forms, Vcl.Buttons, Vcl.DBGrids, Data.DB, System.Generics.Collections,
  uInterfaceCRUD, uInterfaceRegra, uControllerCRUD, uDtoBairro, Vcl.Controls,
  uModelBairro, uRegraBairro, uViewCadastroBairro,
  uViewListagemBairro, uEnumeradorCamposBairro, uDtoMunicipio, uModelMunicipio,
  uListaMunicipio, uDtoEstado;

type
  TControllerBairro = class(TControllerCRUD)
  private
    oRegraBairro: TRegraBairro;
    oModelBairro: TModelBairro;
    oDtoBairro: TDtoBairro;
    procedure BuscarMaiorID;
    procedure PreencherDTO;
    procedure LimparDto(var ADtoBairro: TDtoBairro);
    procedure PreencherGrid(var DbGrid: TDBGrid);

    procedure AtualizarComboBoxMunicipio(Sender: TObject);
  public
    constructor Create; override;
    destructor Destroy; override;

    procedure Salvar; override;
    procedure Cancelar; override;
    procedure Localizar; override;
    procedure Novo; override;
    procedure Editar; override;
    procedure Excluir; override;
    procedure CriarFormCadastro(aOwner: TComponent); override;
    procedure FecharFormCadastro(ASender: TObject); override;
    procedure FecharFormListagem(ASender: TObject); override;
    procedure AjustarModoInsercao(AStatusBtnSalvar: Boolean); override;
  end;

var
  oControllerBairro: TControllerBairro;

implementation

{ TControllerUsuario }

procedure TControllerBairro.Cancelar;
begin
  inherited;
end;

constructor TControllerBairro.Create;
begin
  inherited;

  if not(Assigned(oDtoBairro)) then
    oDtoBairro := TDtoBairro.Create;

  if not(Assigned(oRegraBairro)) then
    oRegraBairro := TRegraBairro.Create;

  if not(Assigned(oModelBairro)) then
    oModelBairro := TModelBairro.Create;
end;

procedure TControllerBairro.CriarFormCadastro(aOwner: TComponent);
begin
  if not(Assigned(oFormularioCadastro)) then
    oFormularioCadastro := TfrmCadastroBairro.Create(aOwner);

  oFormularioCadastro.iInterfaceCrud := oControllerBairro;

  ListarEstados(TfrmCadastroBairro(oFormularioCadastro).cmbEstado);

  TfrmCadastroBairro(oFormularioCadastro).cmbEstado.OnChange :=
    AtualizarComboBoxMunicipio;

  inherited;
end;

destructor TControllerBairro.Destroy;
begin
  if Assigned(oDtoBairro) then
    FreeAndNil(oDtoBairro);

  if Assigned(oRegraBairro) then
    FreeAndNil(oRegraBairro);

  if Assigned(oModelBairro) then
    FreeAndNil(oModelBairro);
  inherited;
end;

procedure TControllerBairro.Editar;
var
  nomeMunicipio: string;
begin
  inherited;
  // resgatando dados da linha selecionada no DBGrid
  // resgatando IdBairro e setando no Edit
  TfrmCadastroBairro(oFormularioCadastro).edtIdCodigo.Text :=
    oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName
    ('ID').AsString;

  // resgatando Nome do bairro e setando no Edit
  TfrmCadastroBairro(oFormularioCadastro).edtNome.Text :=
    oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName
    ('Nome').AsString;

  // resgatando nome do municipio - precisa ser feito antes de buscar o estado
  nomeMunicipio := oFormularioListagem.dbGridListagem.SelectedField.DataSet.
    FieldByName('munic�pio').AsString;

  { para listar o municipio no ComboBox, � necess�rio ter o estado listado
    no ComboBox do estado }
  // buscando estado do municipio do bairro
  PreencherDTO;
  if oRegraBairro.BuscarEstado(oModelBairro, oDtoBairro) then
  begin
    TfrmCadastroBairro(oFormularioCadastro).cmbEstado.ItemIndex :=
      TfrmCadastroBairro(oFormularioCadastro).cmbEstado.Items.IndexOfObject
      (TObject(oDtoBairro.Estado));
  end;

  AtualizarComboBoxMunicipio(nil);
  // setando municicipio no ComboBox a partir do nome
  TfrmCadastroBairro(oFormularioCadastro).cmbMunicipio.ItemIndex :=
    TfrmCadastroBairro(oFormularioCadastro).cmbMunicipio.Items.IndexOf
    (nomeMunicipio);

  FecharFormListagem(oFormularioListagem);

  AjustarModoInsercao(true);
end;

procedure TControllerBairro.Excluir;
begin
  inherited;
  // resgatando idBairro do DBGrid e setando no DTO
  oDtoBairro.idBairro := oFormularioListagem.dbGridListagem.SelectedField.
    DataSet.FieldByName('ID').AsInteger;

  if MessageDlg('Deseja realmente excluir?', mtConfirmation, mbYesNo, 0) = mrYes then
  begin
    if oRegraBairro.Excluir(oModelBairro, oDtoBairro) then
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

procedure TControllerBairro.FecharFormCadastro(ASender: TObject);
begin
  inherited;
end;

procedure TControllerBairro.FecharFormListagem(ASender: TObject);
begin
  inherited;
end;

procedure TControllerBairro.AjustarModoInsercao(AStatusBtnSalvar: Boolean);
begin
  inherited;
  if AStatusBtnSalvar then
    TfrmCadastroBairro(oFormularioCadastro).edtNome.SetFocus;

  TfrmCadastroBairro(oFormularioCadastro).labelEstado.Enabled :=
    AStatusBtnSalvar;

  TfrmCadastroBairro(oFormularioCadastro).labelMunicipio.Enabled :=
    AStatusBtnSalvar;
end;

procedure TControllerBairro.AtualizarComboBoxMunicipio(Sender: TObject);
var
  oListaMunicipio: TListaMunicipio;
  oModelMunicipio: TModelMunicipio;
  oDtoMunicipio: TDtoMunicipio;
begin
  TfrmCadastroBairro(oFormularioCadastro).cmbMunicipio.ItemIndex := -1;
  TfrmCadastroBairro(oFormularioCadastro).cmbMunicipio.Items.Clear;
  TfrmCadastroBairro(oFormularioCadastro).cmbMunicipio.Text := '';
  PreencherDTO;
  oModelMunicipio := TModelMunicipio.Create;
  try
    oListaMunicipio := TListaMunicipio.Create([doOwnsValues]);

    if oModelMunicipio.ListarMunicipios(oListaMunicipio, oDtoBairro) then
    begin
      for oDtoMunicipio in oListaMunicipio.Values do
        TfrmCadastroBairro(oFormularioCadastro).cmbMunicipio.Items.AddObject
          (oDtoMunicipio.Nome, TObject(oDtoMunicipio.IdMunicipio));
    end
  finally
    if Assigned(oModelMunicipio) then
      oModelMunicipio.Free;

    if Assigned(oListaMunicipio) then
      FreeAndNil(oListaMunicipio);
  end;
end;

procedure TControllerBairro.BuscarMaiorID;
begin
  if oRegraBairro.BuscarMaiorID(oModelBairro, oDtoBairro) then
    TfrmCadastroBairro(oFormularioCadastro).edtIdCodigo.Text :=
      IntToStr(oDtoBairro.idBairro + 1);
end;

procedure TControllerBairro.LimparDto(var ADtoBairro: TDtoBairro);
begin
  ADtoBairro.idBairro := 0;
  ADtoBairro.Nome := EmptyStr;
  ADtoBairro.Estado := 0;
end;

procedure TControllerBairro.Localizar;
begin
  if not(Assigned(TfrmListagemBairro(oFormularioListagem))) then
    TfrmListagemBairro(oFormularioListagem) :=
      TfrmListagemBairro.Create(aOwner);

  TfrmListagemBairro(oFormularioListagem).iInterfaceCrud := oControllerBairro;

  PreencherGrid(TfrmListagemBairro(oFormularioListagem).dbGridListagem);
  inherited;
end;

procedure TControllerBairro.Novo;
begin
  inherited;
  BuscarMaiorID;
end;

procedure TControllerBairro.Salvar;
begin
  PreencherDTO;

  case oRegraBairro.ValidarDados(oDtoBairro) of
    resultNome:
      begin
        ShowMessage('Informe o nome do Bairro.');
        TfrmCadastroBairro(oFormularioCadastro).edtNome.SetFocus;
      end;
    resultEstado:
      begin
        ShowMessage('Selecione o Estado.');
        TfrmCadastroBairro(oFormularioCadastro).cmbEstado.SetFocus;
      end;
    resultMunicipio:
      begin
        ShowMessage('Selecione o Munic�pio.');
        TfrmCadastroBairro(oFormularioCadastro).cmbMunicipio.SetFocus;
      end;
    resultOk:
      begin
        if oRegraBairro.VerificarBairroCadastrado(oModelBairro, oDtoBairro) then
        begin
          ShowMessage('J� existe um munic�pio com o nome "' +
            UpperCase(oDtoBairro.Nome) + '" associado ao estado selecionado.');
          TfrmCadastroBairro(oFormularioCadastro).edtNome.SetFocus;
        end
        else
        begin
          if oRegraBairro.Inserir(oModelBairro, oDtoBairro) then
          begin
            AjustarModoInsercao(False);
            LimparFormulario;
            LimparDto(oDtoBairro);
          end
          else
            ShowMessage('Ocorreu um erro ao Salvar o novo bairro');
        end;

      end;
  end;
end;

procedure TControllerBairro.PreencherDTO;
begin
  oDtoBairro.idBairro := StrToInt(TfrmCadastroBairro(oFormularioCadastro)
    .edtIdCodigo.Text);

  oDtoBairro.Nome := Trim(TfrmCadastroBairro(oFormularioCadastro).edtNome.Text);

  if TfrmCadastroBairro(oFormularioCadastro).cmbEstado.ItemIndex > -1 then
  begin
    oDtoBairro.Estado := Integer(TfrmCadastroBairro(oFormularioCadastro)
      .cmbEstado.Items.Objects[TfrmCadastroBairro(oFormularioCadastro)
      .cmbEstado.ItemIndex]);
  end;

  if TfrmCadastroBairro(oFormularioCadastro).cmbMunicipio.ItemIndex > -1 then
  begin
    oDtoBairro.Municipio := Integer(TfrmCadastroBairro(oFormularioCadastro)
      .cmbMunicipio.Items.Objects[TfrmCadastroBairro(oFormularioCadastro)
      .cmbMunicipio.ItemIndex]);
  end;

end;

procedure TControllerBairro.PreencherGrid(var DbGrid: TDBGrid);
begin

  if oModelBairro.Listar then
  begin
    oDataSource.DataSet := oModelBairro.oQuery;
    TfrmListagemBairro(oFormularioListagem).dbGridListagem.DataSource :=
      oDataSource;
  end;
end;

end.
