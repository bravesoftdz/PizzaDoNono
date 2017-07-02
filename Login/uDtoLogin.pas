unit uDtoLogin;

interface

uses
  System.SysUtils;

type
  TDtoLogin = class
  private
    FNome: string;
    FSenha: string;
    FidUsuario: integer;
    procedure SetNome(const Value: string);
    procedure SetSenha(const Value: string);
    procedure SetidUsuario(const Value: integer);

  public
    property idUsuario: integer read FidUsuario write SetidUsuario;
    property Nome: string read FNome write SetNome;
    property Senha : string read FSenha write SetSenha;
  end;

implementation

{ TDtoLogin }

procedure TDtoLogin.SetidUsuario(const Value: integer);
begin
  FidUsuario := Value;
end;

procedure TDtoLogin.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TDtoLogin.SetSenha(const Value: string);
begin
  FSenha := Value;
end;

end.
