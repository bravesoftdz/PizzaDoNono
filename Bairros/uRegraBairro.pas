unit uRegraBairro;

interface

uses
  System.SysUtils, Vcl.Dialogs,
  uEnumeradorCamposBairro, uDtoBairro;

type
  TRegraBairro = class
  private
    //
  public
    function ValidarDados(var ADtoBairro: TDtoBairro): TCamposBairro;
  end;

implementation

{ TRegraBairro }

function TRegraBairro.ValidarDados(var ADtoBairro: TDtoBairro)
  : TCamposBairro;
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

end.
