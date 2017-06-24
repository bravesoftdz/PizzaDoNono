unit uRegraTamanho;

interface

uses
  System.SysUtils, Vcl.Dialogs,
  uEnumeradorCamposTamanho, uDtoTamanho, uModelTamanho;

type
  TRegraTamanho = class
  private
    //
  public
    function ValidarDados(var ADtoTamanho: TDtoTamanho): TCamposTamanho;
    function VerificarTamanhoCadastrado(const AModelTamanho: TModelTamanho;
      var ADtoTamanho: TDtoTamanho): Boolean;
    function Inserir(const AModelTamanho: TModelTamanho;
      const ADtoTamanho: TDtoTamanho): Boolean;
    function Editar(const AModelTamanho: TModelTamanho;
      const ADtoTamanho: TDtoTamanho): Boolean;
    function Excluir(const AModelTamanho: TModelTamanho;
      const ADtoTamanho: TDtoTamanho): Boolean;
    function CountRegistros(const AModel: TModelTamanho): Boolean;
  end;

implementation

{ TRegraTamanho }

function TRegraTamanho.CountRegistros(const AModel: TModelTamanho): Boolean;
begin
  Result := False;
  if AModel.CountRegistros > 0 then
    // se a quantidade de registros for maior que zero
    Result := true; // true, pois existem registros
end;

function TRegraTamanho.Editar(const AModelTamanho: TModelTamanho;
  const ADtoTamanho: TDtoTamanho): Boolean;

begin
  Result := False;
  if AModelTamanho.Editar(ADtoTamanho) then
    Result := true;
end;

function TRegraTamanho.Excluir(const AModelTamanho: TModelTamanho;
  const ADtoTamanho: TDtoTamanho): Boolean;
begin
  Result := False;
  if AModelTamanho.Excluir(ADtoTamanho) then
    Result := true;
end;

function TRegraTamanho.Inserir(const AModelTamanho: TModelTamanho;
  const ADtoTamanho: TDtoTamanho): Boolean;
begin
  Result := False;
  if AModelTamanho.Inserir(ADtoTamanho) then
    Result := true;
end;

function TRegraTamanho.ValidarDados(var ADtoTamanho: TDtoTamanho)
  : TCamposTamanho;
begin
  // testa se o campo nome foi informado
  if ADtoTamanho.Nome = EmptyStr then
  begin
    // se for vazio
    Result := resultNome;

    exit;
  end;
    if ADtoTamanho.MaxSabores = EmptyStr then
  begin
    // se for vazio

    Result := resultMaxSabores;
    exit;
  end;
  // caso não der erro nenhum retorna OK
  Result := resultOk;
end;

function TRegraTamanho.VerificarTamanhoCadastrado(const AModelTamanho
  : TModelTamanho; var ADtoTamanho: TDtoTamanho): Boolean;
begin

  Result := False;
  // testa se o nome informado para o Tamanho já está
  if AModelTamanho.VerificarTamanhoCadastrado(ADtoTamanho) then
    Result := true;

end;

end.
