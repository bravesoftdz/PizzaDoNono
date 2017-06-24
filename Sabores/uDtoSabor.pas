unit uDtoSabor;

interface

uses
  System.SysUtils;

type
  TDtoSabor = class

  private
    FNome: string;
    FIdSabor: integer;
    FIngrediente: string;
    FValor: integer;
    FMaxSabores: integer;
    FTamanho: string;

    procedure SetIdSabor(const Value: integer);
    procedure SetNome(const Value: string);
    procedure SetIngrediente(const Value: string);
    procedure SetValor(const Value: integer);
    procedure SetMaxSabores(const Value: integer);
    procedure SetTamanho(const Value: string);

  public
    property IdSabor: integer read FIdSabor write SetIdSabor;
    property Nome: string read FNome write SetNome;
    property Ingrediente: string read FIngrediente write SetIngrediente;
    property Valor: integer read FValor write SetValor;
    property MaxSabores: integer read FMaxSabores write SetValor;
    property Tamanho: string read FTamanho write SetTamanho;

  end;

implementation

{ TDtoIngrediente }

{ TDtoTamanho }

procedure TDtoSabor.SetIdSabor(const Value: integer);
begin
  FIdSabor := Value;
end;

procedure TDtoSabor.SetIngrediente(const Value: string);
begin
  FIngrediente := Value;
end;

procedure TDtoSabor.SetMaxSabores(const Value: integer);
begin
  FMaxSabores := Value;
end;

procedure TDtoSabor.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TDtoSabor.SetTamanho(const Value: string);
begin
  FTamanho := Value;
end;

procedure TDtoSabor.SetValor(const Value: integer);
begin
  FValor := Value;
end;

end.
