unit uRegraUsuario;

interface

uses
  System.SysUtils, Vcl.Dialogs,
  uInterfaceRegra, uDtoUsuario, uEnumeradorCamposUsuario;

type
  TRegraUsuario = class(TInterfacedObject, IRegra)
  private
    //
  public
    function ValidarDados(var ADtoUsuario: TDtoUsuario): TCamposUsuario;
  end;

implementation

{ TRegraUsuario }

function TRegraUsuario.ValidarDados(var ADtoUsuario: TDtoUsuario)
  : TCamposUsuario;
begin
  if ADtoUsuario.nome = EmptyStr then
  begin
    showMessage('Preencha o campo Nome.');
    Result := resultNome;
    exit;
  end;
  if ADtoUsuario.Senha = EmptyStr then
  begin
    showMessage('Preencha o campo Senha.');
    Result := resultSenha;
    exit;
  end;
  if ADtoUsuario.Senha.Length < 6 then
  begin
    showMessage('O campo senha deve conter no mínimo seis(6) caracteres.');
    Result := resultSenha;
    exit;
  end;
  if ADtoUsuario.ConfirmaSenha = EmptyStr then
  begin
    showMessage('Por favor, confirme sua senha.');
    Result := resultConfirmaSenha;
    exit;
  end;
  if ADtoUsuario.Senha <> ADtoUsuario.ConfirmaSenha then
  begin
    showMessage('As senhas informadas não são iguais. Por favor, ' +
      'verifique e tente novamente');
    Result := resultConfirmaSenha;
    exit;
  end;
  // caso não der erro nenhum retorna OK
  Result := resultOk;
end;

end.
