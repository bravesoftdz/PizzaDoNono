unit uDtoEstado;

interface

uses
  System.SysUtils;

type
  TDtoEstado = class
  private
    FUF: string;
    FIdEstado: integer;
    FNome: string;
    procedure SetIdEstado(const Value: integer);
    procedure SetNome(const Value: string);
    procedure SetUF(const Value: string);

  public
    property IdEstado: integer read FIdEstado write SetIdEstado;
    property Nome: string read FNome write SetNome;
    property UF: string read FUF write SetUF;
  end;

implementation

{ TDtoEstado }

procedure TDtoEstado.SetIdEstado(const Value: integer);
begin
  FIdEstado := Value;
end;

procedure TDtoEstado.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TDtoEstado.SetUF(const Value: string);
begin
  FUF := Value;
end;

end.
