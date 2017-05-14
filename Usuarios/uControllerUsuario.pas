unit uControllerUsuario;

interface

uses
  System.SysUtils, System.Generics.Collections, Vcl.StdCtrls, Dialogs,
  Vcl.ExtCtrls, Vcl.Forms,
  uDtoUsuario, uModelUsuario;

type
  TControllerUsuario = class
  private
    oModelUsuario: TModelUsuario;

  public
    function Salvar(var oDtoUsuario: TDtoUsuario): Boolean;
    procedure DefinirNovoID(var edtIdCodigo: TLabeledEdit);
    procedure ValidarNome(var edit: TLabeledEdit; var labelFeedback: TLabel);
    procedure ValidarSenha(var edit: TLabeledEdit; var labelFeedback: TLabel);
    procedure ValidarConfirmaSenha(var editSenha: TLabeledEdit;
      var editConfirmaSenha: TLabeledEdit; var labelFeedback: TLabel);
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TControllerUsuario }

constructor TControllerUsuario.Create;
begin
  if not(Assigned(oModelUsuario)) then
    oModelUsuario := TModelUsuario.Create(nil);

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
  inherited;
end;

function TControllerUsuario.Salvar(var oDtoUsuario: TDtoUsuario): Boolean;
begin
  Result := false;
  if oDtoUsuario.Nome = '' then
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
  end
  else if oModelUsuario.Inserir(oDtoUsuario) then
    Result := true;

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
    labelFeedback.Visible := false;
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
    labelFeedback.Visible := false;
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
    labelFeedback.Visible := false;
  end;

end;

end.
