unit uRegraMunicipio;

interface

uses
  System.SysUtils, Vcl.Dialogs,
  uEnumeradorCamposMunicipio, uDtoMunicipio;

type
  TRegraMunicipio = class
  private
    //
  public
    function ValidarDados(var ADtoMunicipio: TDtoMunicipio): TCamposMunicipio;
  end;

implementation

{ TRegraMunicipio }

function TRegraMunicipio.ValidarDados(var ADtoMunicipio: TDtoMunicipio)
  : TCamposMunicipio;
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

end.
