unit uControllerUsuario;

interface

uses
  System.Classes, System.SysUtils, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Dialogs,
  Vcl.Forms, Vcl.Buttons, Vcl.DBGrids, Data.DB, System.UITypes,
  uInterfaceCRUD, uViewCadastroUsuario, uInterfaceRegra,
  uModelUsuario, uDtoUsuario, uControllerCRUD, uEnumeradorCamposUsuario,
  uViewListagemUsuario, uRegraUsuario;

type
  TControllerUsuario = class(TControllerCRUD)
  private
    oRegraUsuario: TRegraUsuario;
    oModelUsuario: TModelUsuario;
    oDtoUsuario: TDtoUsuario;
    procedure PreencherDTO;
    procedure LimparDto(var ADtoUsuario: TDtoUsuario);
    procedure PreencherGrid(var DbGrid: TDBGrid);

  public
    constructor Create; override;
    destructor Destroy; override;

    procedure Salvar(ASender: TObject); override;
    procedure Cancelar(ASender: TObject); override;
    procedure Localizar(aOwner: TComponent); override;
    procedure Excluir; override;
    procedure Novo(ASender: TObject); override;
    procedure Editar(Sender: TObject); override;
    procedure CriarFormCadastro(aOwner: TComponent); override;
    procedure FecharFormCadastro(ASender: TObject); override;
    procedure FecharFormListagem(ASender: TObject); override;
  end;

var
  oControllerUsuario: TControllerUsuario;

implementation

{ TControllerUsuario }

procedure TControllerUsuario.Cancelar;
begin
  inherited;
end;

constructor TControllerUsuario.Create;
begin
  if not(Assigned(oDtoUsuario)) then
    oDtoUsuario := TDtoUsuario.Create;

  if not(Assigned(oRegraUsuario)) then
    oRegraUsuario := TRegraUsuario.Create;

  if not(Assigned(oModelUsuario)) then
    oModelUsuario := TModelUsuario.Create;

  inherited;
end;

procedure TControllerUsuario.CriarFormCadastro(aOwner: TComponent);
begin
  if not(Assigned(oFormularioCadastro)) then
    oFormularioCadastro := TfrmUsuario.Create(aOwner);

  oFormularioCadastro.iInterfaceCrud := oControllerUsuario;
  inherited;
end;

destructor TControllerUsuario.Destroy;
begin
  if Assigned(oDtoUsuario) then
    FreeAndNil(oDtoUsuario);

  if Assigned(oRegraUsuario) then
    FreeAndNil(oRegraUsuario);

  if Assigned(oModelUsuario) then
    FreeAndNil(oModelUsuario);

  inherited;
end;

procedure TControllerUsuario.Editar(Sender: TObject);
begin
 inherited;
  // resgatando dados da linha selecionada no DBGrid
  // resgatando IdUsuario e setando no Edit
  TfrmUsuario(oFormularioCadastro).edtIdCodigo.Text :=
    oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('ID').AsString;

  // resgatando Nome do ingrediente e setando no Edit
  TfrmUsuario(oFormularioCadastro).edtNome.Text :=
    oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('Nome').AsString;

  FecharFormListagem(oFormularioListagem);

  AjustarModoInsercao(true);
  //
end;

procedure TControllerUsuario.Excluir;
begin
  inherited;
 // resgatando idingredient do DBGrid e setando no DTO
  oDtoUsuario.idUsuario := oFormularioListagem.dbGridListagem.SelectedField.DataSet.
    FieldByName('ID').AsInteger;

  if MessageDlg('Deseja realmente excluir?', mtConfirmation, mbYesNo, 0) = mrYes then
  begin
    if oRegraUsuario.Excluir(oModelUsuario, oDtoUsuario) then
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

procedure TControllerUsuario.FecharFormCadastro(ASender: TObject);
begin
  inherited;
end;

procedure TControllerUsuario.FecharFormListagem(ASender: TObject);
begin
  inherited;
end;

procedure TControllerUsuario.LimparDto(var ADtoUsuario: TDtoUsuario);
begin
  ADtoUsuario.IdUsuario := 0;
  ADtoUsuario.Nome := EmptyStr;
  ADtoUsuario.Senha := EmptyStr;
  ADtoUsuario.ConfirmaSenha := EmptyStr;
end;

procedure TControllerUsuario.Localizar;
begin
  if not(Assigned(TfrmListagemUsuario(oFormularioListagem))) then
    TfrmListagemUsuario(oFormularioListagem) :=
      TfrmListagemUsuario.Create(aOwner);

  TfrmListagemUsuario(oFormularioListagem).iInterfaceCrud := oControllerUsuario;

  PreencherGrid(TfrmListagemUsuario(oFormularioListagem).dbGridListagem);
  inherited;
end;

procedure TControllerUsuario.Novo;
begin
  inherited;

  TfrmUsuario(oFormularioCadastro).edtNome.SetFocus;
end;

procedure TControllerUsuario.Salvar;
begin
  PreencherDTO;

  case oRegraUsuario.ValidarDados(oDtoUsuario) of
    resultNome:
      TfrmUsuario(oFormularioCadastro).edtNome.SetFocus;
    resultSenha:
      TfrmUsuario(oFormularioCadastro).edtSenha.SetFocus;
    resultConfirmaSenha:
      begin
        TfrmUsuario(oFormularioCadastro).edtConfirmaSenha.Text := EmptyStr;
        TfrmUsuario(oFormularioCadastro).edtConfirmaSenha.SetFocus;
      end;
    resultOk:
      begin
        if oModelUsuario.Inserir(oDtoUsuario) then
        begin
          AjustarModoInsercao(False);
          LimparFormulario;
          LimparDto(oDtoUsuario);
        end;
      end;
  end;
end;

procedure TControllerUsuario.PreencherDTO;
begin

if TfrmUsuario(oFormularioCadastro).edtIdCodigo.Text <> '' then
     oDtoUsuario.IdUsuario := StrToInt(TfrmUsuario(oFormularioCadastro)
    .edtIdCodigo.Text);
        oDtoUsuario.Nome := Trim(TfrmUsuario(oFormularioCadastro).edtNome.Text);
  oDtoUsuario.Senha := Trim(TfrmUsuario(oFormularioCadastro).edtSenha.Text);
  oDtoUsuario.ConfirmaSenha :=
    Trim(TfrmUsuario(oFormularioCadastro).edtConfirmaSenha.Text);
end;

procedure TControllerUsuario.PreencherGrid(var DbGrid: TDBGrid);
begin

  if oModelUsuario.Listar then
  begin
    oDataSource.DataSet := oModelUsuario.oQuery;
    TfrmListagemUsuario(oFormularioListagem).dbGridListagem.DataSource :=
      oDataSource;
  end;
end;

end.
