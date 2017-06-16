unit uDtoIngrediente;

interface

uses
  System.SysUtils;

type
  TDtoIngrediente = class
  private
    FNome: string;
    FIdIngrediente: integer;
    procedure SetNome(const Value: string);
    procedure SetIdIngrediente(const Value: integer);

  public
    property IdIngrediente: integer read FIdIngrediente write SetIdIngrediente;
    property Nome: string read FNome write SetNome;
  end;

implementation

{ TDtoIngrediente }

procedure TDtoIngrediente.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TDtoIngrediente.SetIdIngrediente(const Value: integer);
begin
  FIdIngrediente := Value;
end;

end.
