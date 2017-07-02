unit uControllerCRUD;

interface

uses
  Vcl.ExtCtrls, Vcl.StdCtrls, System.Classes, Vcl.Forms, Vcl.Dialogs,
  System.SysUtils, Data.DB, System.Generics.Collections, Vcl.Mask, Vcl.CheckLst,
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
    procedure LimparFormulario; virtual;
    procedure ListarEstados(var ACmbEstados: TComboBox);
    procedure FiltrarGrid(Sender: TObject); virtual;
    procedure AjustarListagem; virtual;
    procedure OnActivateForm(Sender: TObject); virtual;
    procedure CheckBoxMarcarTudo(Sender: TObject); virtual;
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
    begin
      if (oFormularioCadastro.Components[iIndiceComponente] as TCustomLabeledEdit).Tag <> 1 then
        (oFormularioCadastro.Components[iIndiceComponente] as TCustomLabeledEdit).Enabled :=
          AStatusBtnSalvar;
    end;
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
    if (oFormularioCadastro.Components[iIndiceComponente] is TCheckListBox) then
      (oFormularioCadastro.Components[iIndiceComponente] as TCustomListBox).Enabled :=
        AStatusBtnSalvar;
    if (oFormularioCadastro.Components[iIndiceComponente] is TCheckBox) then
      (oFormularioCadastro.Components[iIndiceComponente] as TCustomCheckBox).Enabled :=
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
  AjustarModoInsercao(False);
end;

procedure TControllerCRUD.CheckBoxMarcarTudo(Sender: TObject);
begin
  //
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

  // fun�ao AjustarFormulario() renomeada para AjustarModoInsercao()
  { iniciando formul�rio com modo de inser��o desabilitado. S� habilita quando
    clicar em btnNovo, por exemplo. }
  oFormularioCadastro.btnExcluir.Enabled := False;
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
  oFormularioCadastro.btnExcluir.Enabled := True;
end;

procedure TControllerCRUD.Excluir;
begin
  oFormularioCadastro.btnExcluir.Enabled := False;
  LimparFormulario;
  AjustarModoInsercao(False);
end;

procedure TControllerCRUD.AjustarListagem;
begin
  oFormularioListagem.dbGridListagem.Hide;
  ShowMessage
    ('Nenhum registro encontrado no banco de dados. Realize um novo cadastro e ele ser� exibido aqui.');

  oFormularioListagem.SearchBoxListagem.Enabled := False;
  oFormularioListagem.LabelFiltro.Enabled := False;
end;

procedure TControllerCRUD.FecharFormCadastro(ASender: TObject);
begin
  if not(Assigned(oFormularioCadastro)) then
    exit;
  FreeAndNil(oFormularioCadastro);
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
  // realiza a filtragem com UPPER CASE pois o Filter � case sensitive
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
      (oFormularioCadastro.Components[iIndiceComponente] as TCustomLabeledEdit).Clear;

    if (oFormularioCadastro.Components[iIndiceComponente] is TMaskEdit) then
      (oFormularioCadastro.Components[iIndiceComponente] as TCustomMaskEdit).Clear;

    if (oFormularioCadastro.Components[iIndiceComponente] is TComboBox) then
      (oFormularioCadastro.Components[iIndiceComponente] as TCustomComboBox).ItemIndex := -1;

    if (oFormularioCadastro.Components[iIndiceComponente] is TCheckListBox) then
      (oFormularioCadastro.Components[iIndiceComponente] as TCustomListBox).ItemIndex := -1;
  end;
  oFormularioCadastro.btnExcluir.Enabled := False;
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
  LimparFormulario;
  AjustarModoInsercao(True);
end;

procedure TControllerCRUD.OnActivateForm(Sender: TObject);
begin
  //
end;

procedure TControllerCRUD.PreencherDTO;
begin

end;

procedure TControllerCRUD.Salvar(ASender: TObject);
begin
  Novo(nil);
end;

end.
