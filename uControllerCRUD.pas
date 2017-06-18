unit uControllerCRUD;

interface

uses
  Vcl.ExtCtrls, Vcl.StdCtrls, System.Classes, Vcl.Forms, Vcl.Dialogs,
  System.SysUtils, Data.DB, System.Generics.Collections, Vcl.Mask,
  uInterfaceCRUD, uCadastroBase, uListagemBase, uModelEstado, uDtoEstado,
  uListaEstado;

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
    procedure ListarEstados(var ACmbEstados: TComboBox);
    procedure FiltrarGrid(Sender: TObject); virtual;
    procedure AjustarListagem; virtual;
    procedure OnExitUltimoCampo(Sender: TObject; var Key: char); virtual;
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
    procedure Editar(Sender: TObject); virtual;
    procedure Excluir; virtual;

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
    if AStatusBtnSalvar then
      oFormularioCadastro.btnSalvar.Tag := 1
    else
      oFormularioCadastro.btnSalvar.Tag := 0;

    if (oFormularioCadastro.Components[iIndiceComponente] is TLabeledEdit) then
      (oFormularioCadastro.Components[iIndiceComponente] as TCustomEdit).Enabled :=
        AStatusBtnSalvar;
    if (oFormularioCadastro.Components[iIndiceComponente] is TLabel) then
      (oFormularioCadastro.Components[iIndiceComponente] as TCustomLabel).Enabled :=
        AStatusBtnSalvar;
    if (oFormularioCadastro.Components[iIndiceComponente] is TMaskEdit) then
      (oFormularioCadastro.Components[iIndiceComponente] as TCustomMaskEdit).Enabled :=
        AStatusBtnSalvar;
    if (oFormularioCadastro.Components[iIndiceComponente] is TRadioButton) then
      (oFormularioCadastro.Components[iIndiceComponente] as TRadioButton).Enabled :=
        AStatusBtnSalvar;
    if (oFormularioCadastro.Components[iIndiceComponente] is TComboBox) then
      (oFormularioCadastro.Components[iIndiceComponente] as TCustomComboBox).Enabled :=
        AStatusBtnSalvar;
  end;
  oFormularioCadastro.btnSalvar.Enabled := AStatusBtnSalvar;
  oFormularioCadastro.btnCancelar.Enabled := AStatusBtnSalvar;
  oFormularioCadastro.btnNovo.Enabled := not(AStatusBtnSalvar);
  oFormularioCadastro.btnLocalizar.Enabled := not(AStatusBtnSalvar);
  // label de titulo deve estar sempre habilitado
  oFormularioCadastro.labelTitulo.Enabled := True;
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

procedure TControllerCRUD.Editar(Sender: TObject);
begin
  //
end;

procedure TControllerCRUD.Excluir;
begin
  //
end;

procedure TControllerCRUD.AjustarListagem;
begin
  oFormularioListagem.dbGridListagem.Hide;
  ShowMessage
    ('Nenhum registro encontrado no banco de dados. Realize um novo cadastro e ele será exibido aqui.');
  oFormularioListagem.btnEditar.Enabled := False;
  oFormularioListagem.btnExcluir.Enabled := False;
  oFormularioListagem.SearchBoxListagem.Enabled := False;
  oFormularioListagem.Label1.Enabled := False;
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

procedure TControllerCRUD.FiltrarGrid(Sender: TObject);
begin
  oFormularioListagem.dbGridListagem.DataSource.DataSet.Filtered := False;
  // realiza a filtragem com UPPER CASE pois o Filter é case sensitive
  oFormularioListagem.dbGridListagem.DataSource.DataSet.Filter := 'UPPER(nome) Like ' +
    UpperCase(QuotedStr('%' + oFormularioListagem.SearchBoxListagem.Text + '%'));

  oFormularioListagem.dbGridListagem.DataSource.DataSet.Filtered := True;
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
      (oFormularioCadastro.Components[iIndiceComponente] as TComboBox).ItemIndex := -1;
  end;
end;

procedure TControllerCRUD.ListarEstados(var ACmbEstados: TComboBox);
var
  oListaEstado: TListaEstado;
  oModelEstado: TModelEstado;
  oDtoEstado: TDtoEstado;
begin
  ACmbEstados.Items.Clear;
  oModelEstado := TModelEstado.Create;
  try

    oListaEstado := TListaEstado.Create([doOwnsValues]);

    if oModelEstado.ListarEstados(oListaEstado) then
    begin
      for oDtoEstado in oListaEstado.Values do
        ACmbEstados.Items.AddObject(oDtoEstado.Nome, TObject(oDtoEstado.IdEstado));
    end;
  finally
    if Assigned(oModelEstado) then
      FreeAndNil(oModelEstado);

    if Assigned(oListaEstado) then
      FreeAndNil(oListaEstado);
  end;
end;

procedure TControllerCRUD.Localizar(aOwner: TComponent);
begin
  oFormularioListagem.SearchBoxListagem.OnChange := FiltrarGrid;
  oFormularioListagem.dbGridListagem.OnDblClick := Editar;
  oFormularioListagem.Show;
end;

procedure TControllerCRUD.Novo(ASender: TObject);
begin
  AjustarModoInsercao(True);
end;

procedure TControllerCRUD.OnExitUltimoCampo(Sender: TObject; var Key: char);
var
  iIndiceComponente: Integer;
begin
  if Key = #10 then
  begin
    for iIndiceComponente := 0 to pred(oFormularioCadastro.ComponentCount) do
    begin
      if (oFormularioCadastro.Components[iIndiceComponente].Tag = 1) then
        Salvar(nil);
    end;
  end;
end;

procedure TControllerCRUD.PreencherDTO;
begin

end;

procedure TControllerCRUD.Salvar(ASender: TObject);
begin

end;

end.
