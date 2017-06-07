unit uRegraBairro;

interface

uses
  System.SysUtils, Vcl.Dialogs,
  uEnumeradorCamposBairro, uDtoBairro, uModelBairro;

type
  TRegraBairro = class
  private
    //
  public
    function ValidarDados(var ADtoBairro: TDtoBairro): TCamposBairro;
    function VerificarBairroCadastrado(const AModelBairro: TModelBairro; var ADtoBairro: TDtoBairro): Boolean;
    function Inserir(const AModelBairro: TModelBairro; const ADtoBairro: TDtoBairro): Boolean;
    function Editar(const AModelBairro: TModelBairro; const ADtoBairro: TDtoBairro): Boolean;
    function BuscarEstado(const AModelBairro: TModelBairro; out ADtoBairro: TDtoBairro): Boolean;
    function Excluir(const AModelBairro: TModelBairro; const ADtoBairro: TDtoBairro): Boolean;
  end;

implementation

{ TRegraBairro }

function TRegraBairro.BuscarEstado(const AModelBairro: TModelBairro; out ADtoBairro: TDtoBairro): Boolean;
begin
  Result := False;
  if AModelBairro.BuscarEstado(ADtoBairro) then
    Result := true;
end;

function TRegraBairro.Editar(const AModelBairro: TModelBairro; const ADtoBairro: TDtoBairro): Boolean;
begin
  Result := False;
  if AModelBairro.Editar(ADtoBairro) then
    Result := true;
end;

function TRegraBairro.Excluir(const AModelBairro: TModelBairro; const ADtoBairro: TDtoBairro): Boolean;
begin
  Result := False;
  if AModelBairro.Excluir(ADtoBairro) then
    Result := true;
end;

function TRegraBairro.Inserir(const AModelBairro: TModelBairro; const ADtoBairro: TDtoBairro): Boolean;
begin
  Result := False;
  if AModelBairro.Inserir(ADtoBairro) then
    Result := true;
end;

function TRegraBairro.ValidarDados(var ADtoBairro: TDtoBairro): TCamposBairro;
begin
  // testa se o campo nome foi informado
  if ADtoBairro.Nome = EmptyStr then
  begin
    // se for vazio
    Result := resultNome;
    exit;
  end;
  // testa se o estado foi selecionado
  if ADtoBairro.Estado = 0 then
  begin
    // se for vazio
    Result := resultEstado;
    exit;
  end;
  if ADtoBairro.Municipio = 0 then
  begin
    // se for vazio
    Result := resultMunicipio;
    exit;
  end;
  // caso não der erro nenhum retorna OK
  Result := resultOk;
end;

function TRegraBairro.VerificarBairroCadastrado(const AModelBairro: TModelBairro; var ADtoBairro: TDtoBairro): Boolean;
begin
  Result := False;
  // testa se o nome informado para o bairro já está cadastrado naquele município
  if AModelBairro.VerificarBairroCadastrado(ADtoBairro) then
    Result := true;
end;

end.
