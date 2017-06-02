unit uDtoMunicipio;

interface

uses
  System.SysUtils;

type
  TDtoMunicipio = class
  private
    FNome: string;
    FEstado: integer;
    FIdMunicipio: integer;
    procedure SetEstado(const Value: integer);
    procedure SetNome(const Value: string);
    procedure SetIdMunicipio(const Value: integer);

  public
    property IdMunicipio: integer read FIdMunicipio write SetIdMunicipio;
    property Nome: string read FNome write SetNome;
    property Estado: integer read FEstado write SetEstado;
  end;

implementation

{ TDtoMunicipio }

procedure TDtoMunicipio.SetEstado(const Value: integer);
begin
  FEstado := Value;
end;

procedure TDtoMunicipio.SetIdMunicipio(const Value: integer);
begin
  FIdMunicipio := Value;
end;

procedure TDtoMunicipio.SetNome(const Value: string);
begin
  FNome := Value;
end;

end.
