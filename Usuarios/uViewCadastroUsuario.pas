unit uViewCadastroUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.Generics.Collections,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Buttons, Vcl.Imaging.pngimage,
  uDtoUsuario, uControllerUsuario, dataModuleFuncoesGlobais,
  uViewListagemUsuario, uListaHashUsuario, uSingletonListaUsuarios;

type
  TfrmUsuario = class(TfrmCadastroBase)
    labelFeedbackNome: TLabel;
    labelFeedbackSenha: TLabel;
    labelFeedbackConfirmaSenha: TLabel;
    edtIdCodigo: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtSenha: TLabeledEdit;
    edtConfirmaSenha: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtNomeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtSenhaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtConfirmaSenhaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnLocalizarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    oControllerUsuario: TControllerUsuario;
    oDtoUsuario: TDtoUsuario;

    procedure ChangeBtnStatus(Status: Boolean; BtnName: TSpeedButton);
    procedure PreencherListaHashEdits;
    procedure ClearEdits;
  public
    { Public declarations }
    oListaUsuario: TListaUsuario;
  end;

var
  frmUsuario: TfrmUsuario;

implementation

{$R *.dfm}
{ TfrmUsuarios }

procedure TfrmUsuario.btnCancelarClick(Sender: TObject);
begin
  inherited;
  oControllerUsuario.ChangeEditStatus(false);
  ChangeBtnStatus(True, btnNovo);
  ChangeBtnStatus(True, btnLocalizar);
  ChangeBtnStatus(false, btnSalvar);
  ChangeBtnStatus(false, btnCancelar);
  ClearEdits;
end;

procedure TfrmUsuario.btnLocalizarClick(Sender: TObject);
begin
  inherited;
  dmFuncoesGlobais.CriarForm(TfrmListagemUsuario, frmListagemUsuario);
end;

procedure TfrmUsuario.btnNovoClick(Sender: TObject);
begin
  inherited;

  ChangeBtnStatus(false, btnLocalizar);
  ChangeBtnStatus(True, btnCancelar);
  ChangeBtnStatus(True, btnSalvar);
  ChangeBtnStatus(false, btnNovo);
  oControllerUsuario.DefinirNovoID(edtIdCodigo);

  PreencherListaHashEdits;
  oControllerUsuario.ChangeEditStatus(True);

end;

procedure TfrmUsuario.btnSalvarClick(Sender: TObject);
begin
  inherited;
  if btnSalvar.Cursor = crHandPoint then
  begin
    PreencherListaHashEdits;

    oDtoUsuario.IdUsuario := StrToInt(edtIdCodigo.Text);
    oDtoUsuario.Nome := edtNome.Text;
    oDtoUsuario.Senha := edtSenha.Text;
    oDtoUsuario.ConfirmaSenha := edtConfirmaSenha.Text;
    if oControllerUsuario.Salvar(oDtoUsuario) then
    begin
      ClearEdits;
      oControllerUsuario.ChangeEditStatus(false);
      ChangeBtnStatus(True, btnNovo);
      ChangeBtnStatus(True, btnLocalizar);
      ChangeBtnStatus(false, btnSalvar);
      ChangeBtnStatus(false, btnCancelar);
    end
    else
    begin
      edtConfirmaSenha.Text := EmptyStr;
      edtIdCodigo.SetFocus;
    end;
  end;

end;

procedure TfrmUsuario.ChangeBtnStatus(Status: Boolean; BtnName: TSpeedButton);
begin
  if Status = false then
  begin
    BtnName.Cursor := crNo;
  end
  else
  begin
    BtnName.Cursor := crHandPoint;
  end;
end;

procedure TfrmUsuario.ClearEdits;
begin
  // limpa os campos
  edtIdCodigo.Text := EmptyStr;
  edtNome.Text := EmptyStr;
  edtSenha.Text := EmptyStr;
  edtConfirmaSenha.Text := EmptyStr;

  // esconde os labels de feedback de valida��o
  labelFeedbackNome.Visible := false;
  labelFeedbackSenha.Visible := false;
  labelFeedbackConfirmaSenha.Visible := false;
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

  // dmFuncoesGlobais.DestruirForm(frmUsuario);
  if Assigned(frmUsuario) then
  begin
    frmUsuario := nil;
    frmUsuario.Free;
  end;
end;

procedure TfrmUsuario.FormCreate(Sender: TObject);
begin
  inherited;
  if not(Assigned(oDtoUsuario)) then
    oDtoUsuario := TDtoUsuario.Create;

  if not(Assigned(oControllerUsuario)) then
    oControllerUsuario := TControllerUsuario.Create;

  TSingletonListaUsuario.getListaUsuario;

  PreencherListaHashEdits;
  oControllerUsuario.ChangeEditStatus(false);
  ChangeBtnStatus(false, btnSalvar);
  ChangeBtnStatus(false, btnCancelar);
end;

procedure TfrmUsuario.FormDestroy(Sender: TObject);
begin
  inherited;
  TSingletonListaUsuario.DestruirLista;
end;

procedure TfrmUsuario.PreencherListaHashEdits;
begin
  oControllerUsuario.oListaHashEdits.Clear;
  oControllerUsuario.oListaHashEdits.Add('ID', edtIdCodigo);
  oControllerUsuario.oListaHashEdits.Add('Nome', edtNome);
  oControllerUsuario.oListaHashEdits.Add('Senha', edtSenha);
  oControllerUsuario.oListaHashEdits.Add('ConfirmaSenha', edtConfirmaSenha);
end;

end.
