unit uDtoSabor;

interface

uses
  System.SysUtils, uListaIngrediente;

type
  TDtoSabor = class

  private
    FNome: string;
    FIdSabor: integer;
    FValor: currency;
    FTamanho: integer;
    FIngrediente: TListaIngrediente;


    procedure SetIdSabor(const Value: integer);
    procedure SetNome(const Value: string);
    procedure SetValor(const Value: currency);
    procedure SetTamanho(const Value: integer);
    procedure SetIngrediente(const Value: TListaIngrediente);



  public
    property IdSabor: integer read FIdSabor write SetIdSabor;
    property Nome: string read FNome write SetNome;
    property Valor: currency read FValor write SetValor;
    property Tamanho: integer read FTamanho write SetTamanho;
    property Ingrediente : TListaIngrediente read FIngrediente write SetIngrediente;
  end;

implementation

{ TDtoSabor }

procedure TDtoSabor.SetIdSabor(const Value: integer);
begin
  FIdSabor := Value;
end;

procedure TDtoSabor.SetIngrediente(const Value: TListaIngrediente);
begin
  FIngrediente := Value;
end;

procedure TDtoSabor.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TDtoSabor.SetTamanho(const Value: integer);
begin
  FTamanho := Value;
end;

procedure TDtoSabor.SetValor(const Value: currency);
begin
  FValor := Value;
end;

end.
