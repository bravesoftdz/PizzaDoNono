unit uRegraMunicipio;

interface

uses
  System.SysUtils, Vcl.Dialogs,
  uEnumeradorCamposMunicipio, uDtoMunicipio, uModelMunicipio;

type
  TRegraMunicipio = class
  private
    //
  public
    function ValidarDados(var ADtoMunicipio: TDtoMunicipio): TCamposMunicipio;
    function VerificarMunicipioCadastrado(const AModelMunicipio: TModelMunicipio;
      var ADtoMunicipio: TDtoMunicipio): Boolean;
    function Inserir(const AModelMunicipio: TModelMunicipio;
      const ADtoMunicipio: TDtoMunicipio): Boolean;
    function Editar(const AModelMunicipio: TModelMunicipio;
      const ADtoMunicipio: TDtoMunicipio): Boolean;
    function Excluir(const AModelMunicipio: TModelMunicipio;
      const ADtoMunicipio: TDtoMunicipio): Boolean;
    function CountRegistros(const AModelMunicipio: TModelMunicipio): Boolean;
  end;

implementation

{ TRegraMunicipio }

function TRegraMunicipio.Editar(const AModelMunicipio: TModelMunicipio;
  const ADtoMunicipio: TDtoMunicipio): Boolean;
begin
  Result := False;
  if AModelMunicipio.Editar(ADtoMunicipio) then
    Result := true;
end;

function TRegraMunicipio.Excluir(const AModelMunicipio: TModelMunicipio;
  const ADtoMunicipio: TDtoMunicipio): Boolean;
begin
  Result := False;
  if AModelMunicipio.Excluir(ADtoMunicipio) then
    Result := true;
end;

function TRegraMunicipio.Inserir(const AModelMunicipio: TModelMunicipio;
  const ADtoMunicipio: TDtoMunicipio): Boolean;
begin
  Result := False;
  if AModelMunicipio.Inserir(ADtoMunicipio) then
    Result := true;
end;

function TRegraMunicipio.ValidarDados(var ADtoMunicipio: TDtoMunicipio): TCamposMunicipio;
begin
  // testa se o campo nome foi informado
  if ADtoMunicipio.Nome = EmptyStr then
  begin
    // se for vazio
    Result := resultNome;
    exit;
  end;
  // testa se o estado foi selecionado
  if ADtoMunicipio.Estado = 0 then
  begin
    // se for vazio
    Result := resultUF;
    exit;
  end;
  // caso não der erro nenhum retorna OK
  Result := resultOk;
end;

function TRegraMunicipio.VerificarMunicipioCadastrado(const AModelMunicipio: TModelMunicipio;
  var ADtoMunicipio: TDtoMunicipio): Boolean;
begin
  Result := False;
  // testa se o nome informado para o bairro já está cadastrado naquele município
  if AModelMunicipio.VerificarMunicipioCadastrado(ADtoMunicipio) then
    Result := true;

end;

function TRegraMunicipio.CountRegistros(const AModelMunicipio: TModelMunicipio): Boolean;
begin
  Result := False;
  if AModelMunicipio.CountRegistros > 0 then
    // se a quantidade de registros for maior que zero
    Result := true; // true, pois existem registros
end;

end.
