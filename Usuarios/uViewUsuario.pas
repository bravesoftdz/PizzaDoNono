unit uViewUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Buttons, Vcl.Imaging.pngimage,
  uDtoUsuario, uControllerUsuario, dataModuleFuncoesGlobais;

type
  TfrmUsuario = class(TfrmCadastroBase)
    edtNome: TLabeledEdit;
    edtIdCodigo: TLabeledEdit;
    edtSenha: TLabeledEdit;
    edtConfirmaSenha: TLabeledEdit;
    labelFeedbackNome: TLabel;
    labelFeedbackSenha: TLabel;
    labelFeedbackConfirmaSenha: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtNomeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtSenhaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtConfirmaSenhaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    oControllerUsuario: TControllerUsuario;
    oDtoUsuario: TDtoUsuario;

    procedure ChangeEditStatus(Status: Boolean);
    procedure ClearEdits;
  public
    { Public declarations }

  end;

var
  frmUsuario: TfrmUsuario;

implementation

{$R *.dfm}
{ TfrmUsuarios }

procedure TfrmUsuario.btnCancelarClick(Sender: TObject);
begin
  inherited;
  ChangeEditStatus(false);
  ClearEdits;
end;

procedure TfrmUsuario.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmUsuario.btnNovoClick(Sender: TObject);
begin
  inherited;
  ChangeEditStatus(true);
  oControllerUsuario.DefinirNovoID(edtIdCodigo);
end;

procedure TfrmUsuario.btnSalvarClick(Sender: TObject);
begin
  inherited;
  oDtoUsuario.IdUsuario := StrToInt(edtIdCodigo.Text);
  oDtoUsuario.Nome := edtNome.Text;
  oDtoUsuario.Senha := edtSenha.Text;
  oDtoUsuario.ConfirmaSenha := edtSenha.Text;
  if oControllerUsuario.Salvar(oDtoUsuario) then
  begin
    ClearEdits;
    ChangeEditStatus(false);
  end;
end;

procedure TfrmUsuario.ChangeEditStatus(Status: Boolean);
begin
  if Status then
  begin
    edtIdCodigo.Enabled := true;
    edtNome.Enabled := true;
    edtSenha.Enabled := true;
    edtConfirmaSenha.Enabled := true;
  end
  else
  begin
    edtIdCodigo.Enabled := false;
    edtNome.Enabled := false;
    edtSenha.Enabled := false;
    edtConfirmaSenha.Enabled := false;
  end;

end;

procedure TfrmUsuario.ClearEdits;
begin
  edtIdCodigo.Text := EmptyStr;
  edtNome.Text := EmptyStr;
  edtSenha.Text := EmptyStr;
  edtConfirmaSenha.Text := EmptyStr;
end;

procedure TfrmUsuario.edtConfirmaSenhaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  oControllerUsuario.ValidarConfirmaSenha(edtSenha, edtConfirmaSenha,
    labelFeedbackConfirmaSenha);
end;

procedure TfrmUsuario.edtNomeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  oControllerUsuario.ValidarNome(edtNome, labelFeedbackNome);
end;

procedure TfrmUsuario.edtSenhaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  oControllerUsuario.ValidarSenha(edtSenha, labelFeedbackSenha);
end;

procedure TfrmUsuario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(oControllerUsuario) then
    FreeAndNil(oControllerUsuario);

  if Assigned(oDtoUsuario) then
    FreeAndNil(oDtoUsuario);

  dmFuncoesGlobais.DestruirForm(frmUsuario);
end;

procedure TfrmUsuario.FormCreate(Sender: TObject);
begin
  inherited;
  if not(Assigned(oDtoUsuario)) then
    oDtoUsuario := TDtoUsuario.Create;

  if not(Assigned(oControllerUsuario)) then
    oControllerUsuario := TControllerUsuario.Create;

  ChangeEditStatus(false);
end;

end.
