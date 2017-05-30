unit uControllerBairro;

interface

uses
  System.Classes, System.SysUtils, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Dialogs,
  Vcl.Forms, Vcl.Buttons, Vcl.DBGrids, Data.DB,
  uInterfaceCRUD, uInterfaceRegra, uControllerCRUD, uDtoBairro,
  uModelBairro, uRegraBairro, uViewCadastroBairro,
  uViewListagemBairro, uEnumeradorCamposBairro;

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
    function VerificarBairroCadastrado(var ADtoBairro
      : TDtoBairro): Boolean;
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
  oControllerBairro: TControllerBairro;

implementation

{ TControllerUsuario }

procedure TControllerBairro.Cancelar(ASender: TObject);
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

procedure TControllerBairro.Editar(ASender: TObject);
begin
  inherited;
  //
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
  TfrmCadastroBairro(oFormularioCadastro).labelEstado.Enabled :=
    AStatusBtnSalvar;
end;

procedure TControllerBairro.BuscarMaiorID;
begin
  if oModelBairro.BuscarMaiorID(oDtoBairro) then
    TfrmCadastroBairro(oFormularioCadastro).edtIdCodigo.Text :=
      IntToStr(oDtoBairro.IdBairro + 1);
end;

procedure TControllerBairro.LimparDto(var ADtoBairro: TDtoBairro);
begin
  ADtoBairro.IdBairro := 0;
  ADtoBairro.Nome := EmptyStr;
  ADtoBairro.Estado := 0;
end;


procedure TControllerBairro.Localizar(aOwner: TComponent);
begin
  if not(Assigned(TfrmListagemBairro(oFormularioListagem))) then
    TfrmListagemBairro(oFormularioListagem) :=
      TfrmListagemBairro.Create(aOwner);

  TfrmListagemBairro(oFormularioListagem).iInterfaceCrud :=
    oControllerBairro;

  PreencherGrid(TfrmListagemBairro(oFormularioListagem).dbGridListagem);
  inherited;
end;

procedure TControllerBairro.Novo(ASender: TObject);
begin
  inherited;
  BuscarMaiorID;
  TfrmCadastroBairro(oFormularioCadastro).edtNome.SetFocus;
end;

procedure TControllerBairro.Salvar(ASender: TObject);
begin
  PreencherDTO;

  case oRegraBairro.ValidarDados(oDtoBairro) of
    resultNome:
      begin
        showMessage('Preencha o campo Nome.');
        TfrmCadastroBairro(oFormularioCadastro).edtNome.SetFocus;
      end;
    resultUF:
      begin
        showMessage('Selecione o Estado.');
        TfrmCadastroBairro(oFormularioCadastro).cmbEstado.SetFocus;
      end;
    resultOk:
      begin
        if not(VerificarBairroCadastrado(oDtoBairro)) then
        begin
          if oModelBairro.Inserir(oDtoBairro) then
          begin
            AjustarModoInsercao(False);
            LimparFormulario;
            LimparDto(oDtoBairro);
          end;
        end;
      end;
  end;
end;

function TControllerBairro.VerificarBairroCadastrado(var ADtoBairro
  : TDtoBairro): Boolean;
begin
  Result := False;
  if oModelBairro.VerificarBairroCadastrado(ADtoBairro) then
  begin
    showMessage('Já existe um município com o nome "' + ADtoBairro.Nome +
      '" associado ao estado selecionado.');
    TfrmCadastroBairro(oFormularioCadastro).edtNome.SetFocus;
    Result := true;
  end

end;

procedure TControllerBairro.PreencherDTO;
begin
  oDtoBairro.IdBairro :=
    StrToInt(TfrmCadastroBairro(oFormularioCadastro).edtIdCodigo.Text);

  oDtoBairro.Nome := Trim(TfrmCadastroBairro(oFormularioCadastro)
    .edtNome.Text);

  if TfrmCadastroBairro(oFormularioCadastro).cmbEstado.ItemIndex > -1 then
  begin
    oDtoBairro.Estado := Integer(TfrmCadastroBairro(oFormularioCadastro)
      .cmbEstado.Items.Objects[TfrmCadastroBairro(oFormularioCadastro)
      .cmbEstado.ItemIndex]);
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
