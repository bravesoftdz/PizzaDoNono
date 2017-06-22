unit uDtoSabor;

interface

uses
  System.SysUtils;

type
  TDtoSabor = class
  private
    FNome: string;
    FIdSabor: integer;
    procedure SetIdSabor(const Value: integer);
    procedure SetNome(const Value: string);

  public
    property IdSabor: integer read FIdSabor write SetIdSabor;
    property Nome: string read FNome write SetNome;
  end;

implementation

{ TDtoIngrediente }


{ TDtoTamanho }

procedure TDtoSabor.SetIdSabor(const Value: integer);
begin
      FIdSabor := Value;
end;

procedure TDtoSabor.SetNome(const Value: string);
begin
      FNome := Value;
end;

end.
