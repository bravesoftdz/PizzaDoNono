unit uSingletonLogin;

interface

uses
  uDtoLogin, System.SysUtils;

type
  TSingletonLogin = class
  private
    class var oDtologin: TDtoLogin;
  public
    class function getInstancia: TDtoLogin;
  end;

implementation

{ TSingletonLogin }

class function TSingletonLogin.getInstancia: TDtoLogin;
begin
  if (not(Assigned(oDtologin))) then
    oDtologin := TDtoLogin.Create;
  result := oDtologin;
end;

Initialization

{
  posso só ter INICIALIZATION,
  mas nao posso ter FINALIZATION sem INITIALIZATION
}
// END INITIALIZATION

// FINALIZATION - executado quando clica pra FECHAR o aplicativo
Finalization

if (Assigned(TSingletonLogin.oDtologin)) then
  freeAndNil(TSingletonLogin.oDtologin);

// End Finalization
end.
