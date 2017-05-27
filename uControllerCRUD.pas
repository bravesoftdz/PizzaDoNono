unit uControllerCRUD;

interface

uses
  Vcl.ExtCtrls, Vcl.StdCtrls, System.Classes, Vcl.Forms, Vcl.Dialogs,
  System.SysUtils, Data.DB,
  uInterfaceCRUD, uCadastroBase, uListagemBase;

type
  TControllerCRUD = class(TInterfacedObject, ICrud)
  private
  protected
    oFormularioCadastro: TfrmCadastroBase;
    oFormularioListagem: TfrmListagemBase;
    oDataSource: TDataSource;
    procedure PreencherDTO;
    procedure AjustarModoInsercao(AStatusBtnSalvar: Boolean); virtual;
    procedure LimparFormulario;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure CriarFormCadastro(aOwner: TComponent); virtual;
    procedure FecharFormListagem(ASender: TObject); virtual;
    procedure FecharFormCadastro(ASender: TObject); virtual;
    procedure Salvar(ASender: TObject); virtual;
    procedure Cancelar(ASender: TObject); virtual;
    procedure Localizar(aOwner: TComponent); virtual;
    procedure Novo(ASender: TObject); virtual;
    procedure Editar(ASender: TObject); virtual;
  end;

var
  oControllerCRUD: TControllerCRUD;

implementation

{ TControllerCRUD }

procedure TControllerCRUD.AjustarModoInsercao(AStatusBtnSalvar: Boolean);
var
  iIndiceComponente: Integer;
begin
  for iIndiceComponente := 0 to pred(oFormularioCadastro.ComponentCount) do
  begin
    if (oFormularioCadastro.Components[iIndiceComponente] is TLabeledEdit) then
      (oFormularioCadastro.Components[iIndiceComponente] as TCustomEdit).Enabled
        := AStatusBtnSalvar;
    if (oFormularioCadastro.Components[iIndiceComponente] is TComboBox) then
      (oFormularioCadastro.Components[iIndiceComponente] as TComboBox).Enabled
        := AStatusBtnSalvar;
  end;
  oFormularioCadastro.btnSalvar.Enabled := AStatusBtnSalvar;
  oFormularioCadastro.btnCancelar.Enabled := AStatusBtnSalvar;
  oFormularioCadastro.btnNovo.Enabled := not(AStatusBtnSalvar);
  oFormularioCadastro.btnLocalizar.Enabled := not(AStatusBtnSalvar);
end;

procedure TControllerCRUD.Cancelar(ASender: TObject);
begin
  LimparFormulario;
  AjustarModoInsercao(False);
end;

constructor TControllerCRUD.Create;
begin
  if not(Assigned(oDataSource)) then
    oDataSource := TDataSource.Create(nil);
end;

procedure TControllerCRUD.CriarFormCadastro(aOwner: TComponent);
begin
  // exibir o form de cadastro
  oFormularioCadastro.Show;

  // funçao AjustarFormulario() renomeada para AjustarModoInsercao()
  { iniciando formulário com modo de inserção desabilitado. Só habilita quando
    clicar em btnNovo, por exemplo. }
  AjustarModoInsercao(False);
end;

destructor TControllerCRUD.Destroy;
begin
  if Assigned(oDataSource) then
    FreeAndNil(oDataSource);
  inherited;
end;

procedure TControllerCRUD.Editar(ASender: TObject);
begin
  //
end;

procedure TControllerCRUD.FecharFormCadastro(ASender: TObject);
begin
  if not(Assigned(oFormularioCadastro)) then
    exit;

  LimparFormulario;
  oFormularioCadastro.Close;
end;

procedure TControllerCRUD.FecharFormListagem(ASender: TObject);
begin
  if not(Assigned(oFormularioListagem)) then
    exit;

  FreeAndNil(oFormularioListagem);
end;

procedure TControllerCRUD.LimparFormulario;
var
  iIndiceComponente: Integer;
begin
  for iIndiceComponente := 0 to pred(oFormularioCadastro.ComponentCount) do
  begin
    if (oFormularioCadastro.Components[iIndiceComponente] is TLabeledEdit) then
      (oFormularioCadastro.Components[iIndiceComponente] as TCustomEdit).Clear;

    if (oFormularioCadastro.Components[iIndiceComponente] is TComboBox) then
      (oFormularioCadastro.Components[iIndiceComponente] as TComboBox)
        .ItemIndex := -1;
  end;
end;

procedure TControllerCRUD.Localizar(aOwner: TComponent);
begin
  oFormularioListagem.Show;
end;

procedure TControllerCRUD.Novo(ASender: TObject);
begin
  AjustarModoInsercao(True);
end;

procedure TControllerCRUD.PreencherDTO;
begin

end;

procedure TControllerCRUD.Salvar(ASender: TObject);
begin

end;

end.
