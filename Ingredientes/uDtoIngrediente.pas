unit uDtoIngrediente;

interface

uses
  System.SysUtils;

type
  TDtoIngrediente = class
  private
    FDescricao: string;
    FIdIngrediente: integer;
    procedure SetDescricao(const Value: string);
    procedure SetIdIngrediente(const Value: integer);

  public
    property IdIngrediente: integer read FIdIngrediente write SetIdIngrediente;
    property Descricao: string read FDescricao write SetDescricao;
  end;

implementation

{ TDtoIngrediente }

procedure TDtoIngrediente.SetDescricao(const Value: string);
begin
  FDescricao := Value;
end;

procedure TDtoIngrediente.SetIdIngrediente(const Value: integer);
begin
  FIdIngrediente := Value;
end;

end.
