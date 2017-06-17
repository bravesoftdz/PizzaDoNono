unit uDtoCliente;

interface

uses
  System.SysUtils;

type
  TDtoCliente = class
  private
    FidCliente: integer;
    FNome: string;
    FCPF: string;
    FCNPJ: string;
    FTelefone: string;
    FCelular: string;

    FBairro: integer;
    FNumero: string;
    FMunicipio: integer;
    FIdEndereço: integer;
    FComplemento: string;
    FEstado: integer;
    FRua: string;

    procedure SetidCliente(const Value: integer);
    procedure SetNome(const Value: string);
    procedure SetCPF(const Value: string);
    procedure SetCelular(const Value: string);
    procedure SetCNPJ(const Value: string);
    procedure SetTelefone(const Value: string);

    procedure SetBairro(const Value: integer);
    procedure SetComplemento(const Value: string);
    procedure SetEstado(const Value: integer);
    procedure SetIdEndereço(const Value: integer);
    procedure SetMunicipio(const Value: integer);
    procedure SetNumero(const Value: string);
    procedure SetRua(const Value: string);

  public
    property idCliente: integer read FidCliente write SetidCliente;
    property Nome: string read FNome write SetNome;
    property CPF: string read FCPF write SetCPF;
    property CNPJ: string read FCNPJ write SetCNPJ;
    property Telefone: string read FTelefone write SetTelefone;
    property Celular: string read FCelular write SetCelular;

    property IdEndereço: integer read FIdEndereço write SetIdEndereço;
    property Municipio: integer read FMunicipio write SetMunicipio;
    property Estado: integer read FEstado write SetEstado;
    property Bairro: integer read FBairro write SetBairro;
    property Rua: string read FRua write SetRua;
    property Numero: string read FNumero write SetNumero;
    property Complemento: string read FComplemento write SetComplemento;
  end;

implementation

{ TDtoCliente }

procedure TDtoCliente.SetCelular(const Value: string);
begin
  FCelular := Value;
end;

procedure TDtoCliente.SetCNPJ(const Value: string);
begin
  FCNPJ := Value;
end;

procedure TDtoCliente.SetCPF(const Value: string);
begin
  FCPF := Value;
end;

procedure TDtoCliente.SetidCliente(const Value: integer);
begin
  FidCliente := Value;
end;

procedure TDtoCliente.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TDtoCliente.SetTelefone(const Value: string);
begin
  FTelefone := Value;
end;

procedure TDtoCliente.SetBairro(const Value: integer);
begin
  FBairro := Value;
end;

procedure TDtoCliente.SetComplemento(const Value: string);
begin
  FComplemento := Value;
end;

procedure TDtoCliente.SetEstado(const Value: integer);
begin
  FEstado := Value;
end;

procedure TDtoCliente.SetIdEndereço(const Value: integer);
begin
  FIdEndereço := Value;
end;

procedure TDtoCliente.SetMunicipio(const Value: integer);
begin
  FMunicipio := Value;
end;

procedure TDtoCliente.SetNumero(const Value: string);
begin
  FNumero := Value;
end;

procedure TDtoCliente.SetRua(const Value: string);
begin
  FRua := Value;
end;

end.
