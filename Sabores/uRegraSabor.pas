unit uRegraSabor;

interface

uses
  System.SysUtils, Vcl.Dialogs,
  uEnumeradorCamposSabor, uDtoSabor, uModelSabor;

type
  TRegraSabor = class
  private
    //
  public
    function ValidarDados(var ADtoSabor: TDtoSabor): TCamposSabor;
    function VerificarSaborCadastrado(const AModelSabor: TModelSabor;
      var ADtoSabor: TDtoSabor): Boolean;
    function Inserir(const AModelSabor: TModelSabor;
      const ADtoSabor: TDtoSabor): Boolean;
    function Editar(const AModelSabor: TModelSabor;
      const ADtoSabor: TDtoSabor): Boolean;
    function Excluir(const AModelSabor: TModelSabor;
      const ADtoSabor: TDtoSabor): Boolean;
    function CountRegistros(const AModel: TModelSabor): Boolean;
  end;

implementation

{ TRegraSabor }

function TRegraSabor.CountRegistros(const AModel: TModelSabor): Boolean;
begin
  Result := False;
  if AModel.CountRegistros > 0 then
    // se a quantidade de registros for maior que zero
    Result := true; // true, pois existem registros
end;

function TRegraSabor.Editar(const AModelSabor: TModelSabor;
  const ADtoSabor: TDtoSabor): Boolean;

begin
  Result := False;
  if AModelSabor.Editar(ADtoSabor) then
    Result := true;
end;

function TRegraSabor.Excluir(const AModelSabor: TModelSabor;
  const ADtoSabor: TDtoSabor): Boolean;
begin
  Result := False;
  if AModelSabor.Excluir(ADtoSabor) then
    Result := true;
end;

function TRegraSabor.Inserir(const AModelSabor: TModelSabor;
  const ADtoSabor: TDtoSabor): Boolean;
begin
  Result := False;
  if AModelSabor.Inserir(ADtoSabor) then
    Result := true;
end;

function TRegraSabor.ValidarDados(var ADtoSabor: TDtoSabor): TCamposSabor;
begin
  // testa se o campo nome foi informado
  if ADtoSabor.Nome = EmptyStr then
  begin
    // se for vazio
    Result := resultNome;

    exit;
  end;
  if ADtoSabor.MaxSabores = 0 then
  begin
    // se for vazio

    Result := resultMaxSabores;
    exit;
  end;
  if ADtoSabor.Valor = 0 then
  begin
    // se for vazio

    Result := resultValor;
    exit;
  end;
  // caso não der erro nenhum retorna OK
  Result := resultOk;
end;

function TRegraSabor.VerificarSaborCadastrado(const AModelSabor: TModelSabor;
  var ADtoSabor: TDtoSabor): Boolean;
begin

  Result := False;
  // testa se o nome informado para o Sabor já está
  if AModelSabor.VerificarSaborCadastrado(ADtoSabor) then
    Result := true;

end;

end.
