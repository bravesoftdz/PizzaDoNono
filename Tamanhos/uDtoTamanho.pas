unit uDtoTamanho;

interface

uses
  System.SysUtils;

type
  TDtoTamanho = class
  private
    FNome: string;
    FMaxSabores: string;
    FIdTamanho: integer;
    procedure SetIdTamanho(const Value: integer);
    procedure SetNome(const Value: string);
    procedure SetMaxSabores(const Value: string);

  public
    property IdTamanho: integer read FIdTamanho write SetIdTamanho;
    property Nome: string read FNome write SetNome;
    property MaxSabores: string read FMaxSabores write SetMaxSabores;
  end;

implementation

{ TDtoIngrediente }


{ TDtoTamanho }

procedure TDtoTamanho.SetIdTamanho(const Value: integer);
begin
      FIdTamanho := Value;
end;

procedure TDtoTamanho.SetMaxSabores(const Value: string);
begin
      FMaxSabores := Value;
end;

procedure TDtoTamanho.SetNome(const Value: string);
begin
      FNome := Value;
end;

end.
