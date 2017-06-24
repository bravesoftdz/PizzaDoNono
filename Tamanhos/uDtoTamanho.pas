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
    FTamanho: string;

    procedure SetIdTamanho(const Value: integer);
    procedure SetNome(const Value: string);
    procedure SetMaxSabores(const Value: string);
    procedure SetTamanho(const Value: string);

  public
    property IdTamanho: integer read FIdTamanho write SetIdTamanho;
    property Nome: string read FNome write SetNome;
    property MaxSabores: string read FMaxSabores write SetMaxSabores;
    property Tamanho: string read FTamanho write SetTamanho;

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


procedure TDtoTamanho.SetTamanho(const Value: string);
begin
      FTamanho := Value;
end;

end.
