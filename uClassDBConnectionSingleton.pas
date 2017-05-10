unit uClassDBConnectionSingleton;

interface

uses
  uClassConnection, System.SysUtils;

type
  TDBConnectionSingleton = class
  private
    class var oConnection: TConnection;
  public
    class function getInstancia: TConnection;
  end;

implementation

{ TSingleton }

class function TDBConnectionSingleton.getInstancia: TConnection;
begin
  if (not(Assigned(oConnection))) then
    oConnection := TConnection.Create(nil);
  result := oConnection;
end;

Initialization

{
  posso só ter INICIALIZATION,
  mas nao posso ter FINALIZATION sem INITIALIZATION
}
// END INITIALIZATION

// FINALIZATION - executado quando clica pra FECHAR o aplicativo
Finalization

if (Assigned(TDBConnectionSingleton.oConnection)) then
  freeAndNil(TDBConnectionSingleton.oConnection);

// End Finalization
end.
