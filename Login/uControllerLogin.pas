unit uControllerLogin;

interface

uses
  System.Classes, System.SysUtils, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Dialogs, Winapi.Windows,
  Vcl.Forms, Vcl.Buttons, Vcl.DBGrids, Data.DB, System.Generics.Collections, System.UITypes,
  uControllerCRUD, uDtoLogin,
  uModelLogin, uRegraLogin, uEnumeradorCamposLogin, uViewLogin, uSingletonLogin,
  uClassDBConnectionSingleton;

type
  TControllerLogin = class
  private
    oRegraLogin: TRegraLogin;
    oModelLogin: TModelLogin;
    oDtoLogin: TDtoLogin;
    numeroTentativas: integer;
    procedure PreencherDTO;
    procedure LimparDto;
    procedure VerificarLogin(Sender: TObject);
  public
    oFormLogin: TfrmViewLogin;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TControllerLogin }

constructor TControllerLogin.Create;
begin
  inherited;

  // Cria a conexão com o banco de dados
  try
    TDBConnectionSingleton.GetInstancia;
  except
    ShowMessage('Erro ao conectar com o banco de dados. O sistema não pode ser iniciado.');
    // Manda encerrar a aplicação
    Application.Terminate;
    exit;
  end;

  oDtoLogin := TSingletonLogin.GetInstancia;

  if not(Assigned(oRegraLogin)) then
    oRegraLogin := TRegraLogin.Create;

  if not(Assigned(oModelLogin)) then
    oModelLogin := TModelLogin.Create;

  if not(Assigned(oFormLogin)) then
    oFormLogin := TfrmViewLogin.Create(nil);

  oFormLogin.btnEntrar.OnClick := VerificarLogin;
end;

destructor TControllerLogin.Destroy;
begin
  if Assigned(oRegraLogin) then
    FreeAndNil(oRegraLogin);

  if Assigned(oModelLogin) then
    FreeAndNil(oModelLogin);

  if Assigned(oFormLogin) then
    FreeAndNil(oFormLogin);
  inherited;
end;

procedure TControllerLogin.LimparDto;
begin
  oDtoLogin.Senha := EmptyStr;
  oDtoLogin.Nome := EmptyStr;
end;

procedure TControllerLogin.VerificarLogin(Sender: TObject);
begin
  PreencherDTO;

  case oRegraLogin.ValidarDados(oDtoLogin) of
    resultNome:
      begin
        ShowMessage('Informe o nome de usuário.');
        oFormLogin.edtNome.SetFocus;
      end;
    resultSenha:
      begin
        ShowMessage('Informe senha.');
        oFormLogin.edtNome.SetFocus;
      end;
    resultOk:
      begin
        // se o ID for vazio, testa se o nome informado ja esta cadastrado
        if not(oRegraLogin.VerificarLogin(oModelLogin, oDtoLogin)) then
        begin
          inc(numeroTentativas); // Incrementa em 1 o valor da variável numeroTentativas
          if numeroTentativas < 5 then
          begin
            ShowMessage('Nome de usuário ou senha incorretos.');
            oFormLogin.edtNome.SetFocus;
            LimparDto;
          end
          else
          begin
            ShowMessage('Número máximo de tentativas excedido. O sistema será encerrado.');
            oFormLogin.ModalResult := mrCancel;
            LimparDto;
          end;
        end
        else
        begin
          oFormLogin.ModalResult := mrOk;
        end;
      end
  end;
end;

procedure TControllerLogin.PreencherDTO;
begin
  oDtoLogin.Nome := Trim(oFormLogin.edtNome.Text);
  oDtoLogin.Senha := Trim(oFormLogin.edtSenha.Text);
end;

end.
