unit uDtoPedido;

interface

uses
  System.SysUtils;

type
  TDtoPedido = class
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

{ TDtoPedido }

procedure TDtoPedido.SetidUsuario(const Value: integer);
begin
  FidUsuario := Value;
end;

procedure TDtoPedido.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TDtoPedido.SetSenha(const Value: string);
begin
  FSenha := Value;
end;

end.
