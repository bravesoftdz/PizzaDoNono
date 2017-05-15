unit uControllerUsuario;

interface

uses
  System.SysUtils, System.Generics.Collections, Vcl.StdCtrls, Dialogs,
  Vcl.ExtCtrls, Vcl.Forms, Data.DB, Vcl.DBGrids,
  uDtoUsuario, uModelUsuario, uViewCadastroUsuario;

type
  TControllerUsuario = class
  private
    oModelUsuario: TModelUsuario;
    oDataSource: TDataSource;
  public
    oListaHashEdits: TDictionary<string, TLabeledEdit>;

    function Salvar(var oDtoUsuario: TDtoUsuario): Boolean;
    procedure DefinirNovoID(var edtIdCodigo: TLabeledEdit);
    procedure ValidarNome(var edit: TLabeledEdit; var labelFeedback: TLabel);
    procedure ValidarSenha(var edit: TLabeledEdit; var labelFeedback: TLabel);
    procedure ValidarConfirmaSenha(var editSenha: TLabeledEdit;
      var editConfirmaSenha: TLabeledEdit; var labelFeedback: TLabel);
    procedure ChangeEditStatus(status: Boolean);
    function Listar(var oGrid: TDBGrid): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TControllerUsuario }

procedure TControllerUsuario.ChangeEditStatus(status: Boolean);
var
  sIndice: String;
begin
  if status = true then
  begin
    for sIndice in oListaHashEdits.Keys do
    begin
      oListaHashEdits.Items[sIndice].Enabled := true;
    end;
    oListaHashEdits.Items['ID'].SetFocus;
  end
  else
  begin
    for sIndice in oListaHashEdits.Keys do
    begin
      oListaHashEdits.Items[sIndice].Enabled := False;
    end;
  end;

end;

constructor TControllerUsuario.Create;
begin
  if not(Assigned(oModelUsuario)) then
    oModelUsuario := TModelUsuario.Create(nil);

  oListaHashEdits := TDictionary<string, TLabeledEdit>.Create;

  if not(Assigned(oDataSource)) then
    oDataSource := TDataSource.Create(nil);

  oDataSource.DataSet := oModelUsuario;

end;

procedure TControllerUsuario.DefinirNovoID(var edtIdCodigo: TLabeledEdit);
var
  MaxID: integer;
begin
  MaxID := oModelUsuario.GetMaxID;
  edtIdCodigo.Text := IntToStr(MaxID + 1);
end;

destructor TControllerUsuario.Destroy;
begin
  if Assigned(oModelUsuario) then
    FreeAndNil(oModelUsuario);

  if Assigned(oListaHashEdits) then
  begin
    oListaHashEdits.Clear;
    FreeAndNil(oListaHashEdits);
  end;

  if Assigned(oDataSource) then
    FreeAndNil(oDataSource);

  inherited;
end;

function TControllerUsuario.Listar(var oGrid: TDBGrid): Boolean;
var
  sItem: string;
begin
  oGrid.Columns.Clear;
  //oModelUsuario.Listar(frmUsuario.oListaUsuario);

  for sItem in frmUsuario.oListaUsuario.Values do
  begin

    //oGrid.//Add(sItem.Nome, sItem);
  end;
end;

function TControllerUsuario.Salvar(var oDtoUsuario: TDtoUsuario): Boolean;
begin
  Result := False;
  if (oDtoUsuario.Nome <> '') and (oDtoUsuario.Senha <> '') and
    (oDtoUsuario.ConfirmaSenha <> '') and (Length(oDtoUsuario.Senha) >= 6) and
    (oDtoUsuario.ConfirmaSenha = oDtoUsuario.Senha) then
  begin
    if oModelUsuario.Inserir(oDtoUsuario) then
      Result := true;
  end
  else
    ShowMessage('Preencha todos os campos corretamente!');
  { if oDtoUsuario.Nome = '' then
    begin
    raise Exception.Create('Preencha o campo "Nome".');
    end
    else if oDtoUsuario.Senha = '' then
    begin
    raise Exception.Create('Preencha o campo "Senha".');
    end
    else if oDtoUsuario.ConfirmaSenha = '' then
    begin
    raise Exception.Create('Preencha o campo "Confirme a Senha".');
    end }

end;

procedure TControllerUsuario.ValidarConfirmaSenha(var editSenha: TLabeledEdit;
  var editConfirmaSenha: TLabeledEdit; var labelFeedback: TLabel);
begin
  if editConfirmaSenha.Text = '' then
  begin
    labelFeedback.Caption := 'Este campo � obrigat�rio.';
    labelFeedback.Visible := true;
  end
  else if editSenha.Text <> editConfirmaSenha.Text then
  begin
    labelFeedback.Caption := 'As senhas n�o s�o iguais.';
    labelFeedback.Visible := true;
  end
  else
  begin
    labelFeedback.Visible := False;
  end;

end;

procedure TControllerUsuario.ValidarNome(var edit: TLabeledEdit;
  var labelFeedback: TLabel);
begin
  if edit.Text = '' then
  begin
    labelFeedback.Caption := 'Este campo � obrigat�rio.';
    labelFeedback.Visible := true;
  end
  else
  begin
    labelFeedback.Visible := False;

  end;

end;

procedure TControllerUsuario.ValidarSenha(var edit: TLabeledEdit;
  var labelFeedback: TLabel);
begin
  if edit.Text = '' then
  begin
    labelFeedback.Caption := 'Este campo � obrigat�rio.';
    labelFeedback.Visible := true;
  end
  else if Length(edit.Text) < 6 then
  begin
    labelFeedback.Caption := 'Insira uma senha com no m�nimo seis caracteres.';
    labelFeedback.Visible := true;
  end
  else
  begin
    labelFeedback.Visible := False;
  end;

end;

end.
