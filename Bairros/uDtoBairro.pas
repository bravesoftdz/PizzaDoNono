unit uDtoBairro;

interface

uses
  System.SysUtils;

type
  TDtoBairro = class
  private
    FidBairro: integer;
    FMunicipio: integer;
    FEstado: integer;
    FNome: string;
    procedure SetidBairro(const Value: integer);
    procedure SetEstado(const Value: integer);
    procedure SetMunicipio(const Value: integer);
    procedure SetNome(const Value: string);

  public
    property idBairro: integer read FidBairro write SetidBairro;
    property Nome: string read FNome write SetNome;
    property Municipio: integer read FMunicipio write SetMunicipio;
    property Estado: integer read FEstado write SetEstado;
  end;

implementation

{ TDtoBairro }

procedure TDtoBairro.SetEstado(const Value: integer);
begin
  FEstado := Value;
end;

procedure TDtoBairro.SetidBairro(const Value: integer);
begin
  FidBairro := Value;
end;

procedure TDtoBairro.SetMunicipio(const Value: integer);
begin
  FMunicipio := Value;
end;

procedure TDtoBairro.SetNome(const Value: string);
begin
  FNome := Value;
end;

end.
