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
  if ADtoMunicipio.Nome = EmptyStr then
  begin
    showMessage('Preencha o campo Nome.');
    Result := resultNome;
    exit;
  end;
  // caso não der erro nenhum retorna OK
  Result := resultOk;
end;

end.
