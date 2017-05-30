unit uControllerMunicipio;

interface

uses
  System.Classes, System.SysUtils, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Dialogs,
  Vcl.Forms, Vcl.Buttons, Vcl.DBGrids, Data.DB,
  uInterfaceCRUD, uInterfaceRegra, uControllerCRUD, uDtoMunicipio,
  uModelMunicipio, uRegraMunicipio, uViewCadastroMunicipio,
  uViewListagemMunicipio, uEnumeradorCamposMunicipio;

type
  TControllerMunicipio = class(TControllerCRUD)
  private
    oRegraMunicipio: TRegraMunicipio;
    oModelMunicipio: TModelMunicipio;
    oDtoMunicipio: TDtoMunicipio;
    procedure BuscarMaiorID;
    procedure PreencherDTO;
    procedure LimparDto(var ADtoMunicipio: TDtoMunicipio);
    procedure PreencherGrid(var DbGrid: TDBGrid);
    function VerificarMunicipioCadastrado(var ADtoMunicipio
      : TDtoMunicipio): Boolean;
  public
    constructor Create; override;
    destructor Destroy; override;

    procedure Salvar(ASender: TObject); override;
    procedure Cancelar(ASender: TObject); override;
    procedure Localizar(aOwner: TComponent); override;
    procedure Novo(ASender: TObject); override;
    procedure Editar(ASender: TObject); override;
    procedure CriarFormCadastro(aOwner: TComponent); override;
    procedure FecharFormCadastro(ASender: TObject); override;
    procedure FecharFormListagem(ASender: TObject); override;
    procedure AjustarModoInsercao(AStatusBtnSalvar: Boolean); override;
  end;

var
  oControllerMunicipio: TControllerMunicipio;

implementation

{ TControllerUsuario }

procedure TControllerMunicipio.Cancelar(ASender: TObject);
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

procedure TControllerMunicipio.Editar(ASender: TObject);
begin
  inherited;
  //
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
  TfrmCadastroMunicipio(oFormularioCadastro).labelEstado.Enabled :=
    AStatusBtnSalvar;
end;

procedure TControllerMunicipio.BuscarMaiorID;
begin
  if oModelMunicipio.BuscarMaiorID(oDtoMunicipio) then
    TfrmCadastroMunicipio(oFormularioCadastro).edtIdCodigo.Text :=
      IntToStr(oDtoMunicipio.IdMunicipio + 1);
end;

procedure TControllerMunicipio.LimparDto(var ADtoMunicipio: TDtoMunicipio);
begin
  ADtoMunicipio.IdMunicipio := 0;
  ADtoMunicipio.Nome := EmptyStr;
  ADtoMunicipio.Estado := 0;
end;


procedure TControllerMunicipio.Localizar(aOwner: TComponent);
begin
  if not(Assigned(TfrmListagemMunicipio(oFormularioListagem))) then
    TfrmListagemMunicipio(oFormularioListagem) :=
      TfrmListagemMunicipio.Create(aOwner);

  TfrmListagemMunicipio(oFormularioListagem).iInterfaceCrud :=
    oControllerMunicipio;

  PreencherGrid(TfrmListagemMunicipio(oFormularioListagem).dbGridListagem);
  inherited;
end;

procedure TControllerMunicipio.Novo(ASender: TObject);
begin
  inherited;
  BuscarMaiorID;
  TfrmCadastroMunicipio(oFormularioCadastro).edtNome.SetFocus;
end;

procedure TControllerMunicipio.Salvar(ASender: TObject);
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
        if not(VerificarMunicipioCadastrado(oDtoMunicipio)) then
        begin
          if oModelMunicipio.Inserir(oDtoMunicipio) then
          begin
            AjustarModoInsercao(False);
            LimparFormulario;
            LimparDto(oDtoMunicipio);
          end;
        end;
      end;
  end;
end;

function TControllerMunicipio.VerificarMunicipioCadastrado(var ADtoMunicipio
  : TDtoMunicipio): Boolean;
begin
  Result := False;
  if oModelMunicipio.VerificarMunicipioCadastrado(ADtoMunicipio) then
  begin
    showMessage('Já existe um município com o nome "' + ADtoMunicipio.Nome +
      '" associado ao estado selecionado.');
    TfrmCadastroMunicipio(oFormularioCadastro).edtNome.SetFocus;
    Result := true;
  end

end;

procedure TControllerMunicipio.PreencherDTO;
begin
  oDtoMunicipio.IdMunicipio :=
    StrToInt(TfrmCadastroMunicipio(oFormularioCadastro).edtIdCodigo.Text);

  oDtoMunicipio.Nome := Trim(TfrmCadastroMunicipio(oFormularioCadastro)
    .edtNome.Text);

  if TfrmCadastroMunicipio(oFormularioCadastro).cmbEstado.ItemIndex > -1 then
  begin
    oDtoMunicipio.Estado := Integer(TfrmCadastroMunicipio(oFormularioCadastro)
      .cmbEstado.Items.Objects[TfrmCadastroMunicipio(oFormularioCadastro)
      .cmbEstado.ItemIndex]);
  end;

end;

procedure TControllerMunicipio.PreencherGrid(var DbGrid: TDBGrid);
begin

  if oModelMunicipio.Listar then
  begin
    oDataSource.DataSet := oModelMunicipio.oQuery;
    TfrmListagemMunicipio(oFormularioListagem).dbGridListagem.DataSource :=
      oDataSource;
  end;
end;

end.
