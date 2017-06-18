unit uRegraEstado;

interface

uses
  System.SysUtils, Vcl.Dialogs,
  uDtoEstado, uEnumeradorCamposEstado, uModelEstado;

type
  TRegraEstado = class
  private
    //
  public
    function ValidarDados(var ADtoEstado: TDtoEstado): TCamposEstado;
    function VerificarEstadoCadastrado(const AModelEstado: TModelEstado;
      const ADtoEstado: TDtoEstado): TCamposEstado;
    function Inserir(const AModelEstado: TModelEstado; const ADtoEstado: TDtoEstado): Boolean;
    function Editar(const AModelEstado: TModelEstado; const ADtoEstado: TDtoEstado): Boolean;
    function Excluir(const AModelEstado: TModelEstado; const ADtoEstado: TDtoEstado): Boolean;
    function CountRegistros(const AModel: TModelEstado): Boolean;
  end;

implementation

{ TRegraEstado }

function TRegraEstado.CountRegistros(const AModel: TModelEstado): Boolean;
begin
  Result := False;
  if AModel.CountRegistros > 0 then
    // se a quantidade de registros for maior que zero
    Result := true; // true, pois existem registros
end;

function TRegraEstado.Editar(const AModelEstado: TModelEstado;
  const ADtoEstado: TDtoEstado): Boolean;
begin
  Result := False;
  if AModelEstado.Editar(ADtoEstado) then
    Result := true;
end;

function TRegraEstado.Excluir(const AModelEstado: TModelEstado;
  const ADtoEstado: TDtoEstado): Boolean;
begin
  Result := False;
  if AModelEstado.Excluir(ADtoEstado) then
    Result := true;
end;

function TRegraEstado.Inserir(const AModelEstado: TModelEstado;
  const ADtoEstado: TDtoEstado): Boolean;
begin
  Result := False;
  if AModelEstado.Inserir(ADtoEstado) then
    Result := true;
end;

function TRegraEstado.ValidarDados(var ADtoEstado: TDtoEstado): TCamposEstado;
begin
  if ADtoEstado.nome = EmptyStr then
  begin
    Result := resultNome;
    exit;
  end;
  if ADtoEstado.UF = EmptyStr then
  begin
    Result := resultUF;
    exit;
  end;
  // caso não der erro nenhum retorna OK
  Result := resultOk;
end;

function TRegraEstado.VerificarEstadoCadastrado(const AModelEstado: TModelEstado;
  const ADtoEstado: TDtoEstado): TCamposEstado;
begin
  // testa se o nome informado para o ingrediente já está
  Result := AModelEstado.VerificarEstadoCadastrado(ADtoEstado);

end;

end.
