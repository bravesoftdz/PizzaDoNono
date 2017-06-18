unit uRegraCliente;

interface

uses
  System.SysUtils, Vcl.Dialogs,
  uEnumeradorCamposCliente, uDtoCliente, uModelCliente;

type
  TRegraCliente = class
  private
    //
  public
    function ValidarDados(var ADtoCliente: TDtoCliente): TCamposCliente;
    function VerificarClienteCadastrado(const AModelCliente: TModelCliente;
      var ADtoCliente: TDtoCliente): Boolean;
    function Inserir(const AModelCliente: TModelCliente; const ADtoCliente: TDtoCliente): Boolean;
    function Editar(const AModelCliente: TModelCliente; const ADtoCliente: TDtoCliente): Boolean;
    function BuscarEstado(const AModelCliente: TModelCliente; out ADtoCliente: TDtoCliente)
      : Boolean;
    function Excluir(const AModelCliente: TModelCliente; const ADtoCliente: TDtoCliente): Boolean;
    function CountRegistros(const AModel: TModelCliente): Boolean;
  end;

implementation

{ TRegraCliente }

function TRegraCliente.BuscarEstado(const AModelCliente: TModelCliente;
  out ADtoCliente: TDtoCliente): Boolean;
begin
  Result := False;
  if AModelCliente.BuscarEstado(ADtoCliente) then
    Result := true;
end;

function TRegraCliente.CountRegistros(const AModel: TModelCliente): Boolean;
begin
  Result := False;
  if AModel.CountRegistros > 0 then
    // se a quantidade de registros for maior que zero
    Result := true; // true, pois existem registros
end;

function TRegraCliente.Editar(const AModelCliente: TModelCliente;
  const ADtoCliente: TDtoCliente): Boolean;
begin
  Result := False;
  if AModelCliente.Editar(ADtoCliente) then
    Result := true;
end;

function TRegraCliente.Excluir(const AModelCliente: TModelCliente;
  const ADtoCliente: TDtoCliente): Boolean;
begin
  Result := False;
  if AModelCliente.Excluir(ADtoCliente) then
    Result := true;
end;

function TRegraCliente.Inserir(const AModelCliente: TModelCliente;
  const ADtoCliente: TDtoCliente): Boolean;
begin
  Result := False;
  if AModelCliente.Inserir(ADtoCliente) then
    Result := true;
end;

function TRegraCliente.ValidarDados(var ADtoCliente: TDtoCliente): TCamposCliente;
begin
  // testa se o campo nome foi informado
  if ADtoCliente.Nome = EmptyStr then
  begin
    // se for vazio
    Result := resultNome;
    exit;
  end;
  // testa se o estado foi selecionado
  if ADtoCliente.Estado = 0 then
  begin
    // se for vazio
    Result := resultEstado;
    exit;
  end;
  if ADtoCliente.Municipio = 0 then
  begin
    // se for vazio
    Result := resultMunicipio;
    exit;
  end;
  // caso não der erro nenhum retorna OK
  Result := resultOk;
end;

function TRegraCliente.VerificarClienteCadastrado(const AModelCliente: TModelCliente;
  var ADtoCliente: TDtoCliente): Boolean;
begin
  Result := False;
  // testa se o nome informado para o Cliente já está cadastrado naquele município
  if AModelCliente.VerificarClienteCadastrado(ADtoCliente) then
    Result := true;
end;

end.
