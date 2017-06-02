unit uDtoUsuario;

interface

uses
  System.SysUtils;

type
  TDtoUsuario = class
  private
    FIdUsuario: integer;
    FSenha: string;
    FNome: string;
    FConfirmaSenha: string;

    procedure SetIdUsuario(const Value: integer);
    procedure SetNome(const Value: string);
    procedure SetSenha(const Value: string);
    procedure SetConfirmaSenha(const Value: string);

  public
    property IdUsuario: integer read FIdUsuario write SetIdUsuario;
    property Nome: string read FNome write SetNome;
    property Senha: string read FSenha write SetSenha;
    property ConfirmaSenha: string read FConfirmaSenha write SetConfirmaSenha;
  end;

implementation

{ TDtoUsuarios }

procedure TDtoUsuario.SetConfirmaSenha(const Value: string);
begin
  FConfirmaSenha := Value;
end;

procedure TDtoUsuario.SetIdUsuario(const Value: integer);
begin
  FIdUsuario := Value;
end;

procedure TDtoUsuario.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TDtoUsuario.SetSenha(const Value: string);
begin
  FSenha := Value;
end;

end.
