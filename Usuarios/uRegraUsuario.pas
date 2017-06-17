unit uRegraUsuario;

interface

uses
  System.SysUtils, Vcl.Dialogs,
  uDtoUsuario, uEnumeradorCamposUsuario, uModelUsuario;

type
  TRegraUsuario = class
  private
    //
  public
    function ValidarDados(var ADtoUsuario: TDtoUsuario): TCamposUsuario;
    function VerificarUsuario(const AModelUsuario: TModelUsuario;
      var ADtoUsuario: TDtoUsuario): Boolean;
    function Inserir(const AModelUsuario: TModelUsuario;
      const ADtoUsuario: TDtoUsuario): Boolean;
    function Editar(const AModelUsuario: TModelUsuario;
      const ADtoUsuario: TDtoUsuario): Boolean;
    function Excluir(const AModelUsuario: TModelUsuario;
      const ADtoUsuario: TDtoUsuario): Boolean;
  end;

implementation

{ TRegraUsuario }

function TRegraUsuario.Editar(const AModelUsuario: TModelUsuario;
  const ADtoUsuario: TDtoUsuario): Boolean;
begin
  Result := False;
  if AModelUsuario.Editar(ADtoUsuario) then
    Result := true;
end;

function TRegraUsuario.Excluir(const AModelUsuario: TModelUsuario;
  const ADtoUsuario: TDtoUsuario): Boolean;
begin
  Result := False;
  if AModelUsuario.Excluir(ADtoUsuario) then
    Result := true;
end;

function TRegraUsuario.Inserir(const AModelUsuario: TModelUsuario;
  const ADtoUsuario: TDtoUsuario): Boolean;
begin
  Result := False;
  if AModelUsuario.Inserir(ADtoUsuario) then
    Result := true;
end;

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

function TRegraUsuario.VerificarUsuario(const AModelUsuario: TModelUsuario;
  var ADtoUsuario: TDtoUsuario): Boolean;
begin
  Result := False;
  // testa se o nome informado para o usuario já está
  if AModelUsuario.VerificarUsuarioCadastrado(ADtoUsuario) then
    Result := true;
end;

end.
