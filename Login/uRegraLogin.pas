unit uRegraLogin;

interface

uses
  System.SysUtils, Vcl.Dialogs,
  uDtoLogin, uModelLogin, uEnumeradorCamposLogin;

type
  TRegraLogin = class
  private
    //
  public
    function ValidarDados(var ADtoLogin: TDtoLogin): TCamposLogin;
    function VerificarLogin(const AModelLogin: TModelLogin; var ADtoLogin: TDtoLogin): Boolean;
  end;

implementation

{ TRegraLogin }

function TRegraLogin.ValidarDados(var ADtoLogin: TDtoLogin): TCamposLogin;
begin
  // testa se o campo nome foi informado
  if ADtoLogin.Nome = EmptyStr then
  begin
    // se for vazio
    Result := resultNome;
    exit;
  end;
  // testa se o campo senha foi informado
  if ADtoLogin.Senha = EmptyStr then
  begin
    // se for vazio
    Result := resultSenha;
    exit;
  end;
  // caso não der erro nenhum retorna OK
  Result := resultOk;
end;

function TRegraLogin.VerificarLogin(const AModelLogin: TModelLogin;
  var ADtoLogin: TDtoLogin): Boolean;
begin

  Result := False;
  // testa se o nome informado para o Login já está
  if AModelLogin.VerificarLogin(ADtoLogin) then
    Result := true;

end;

end.
