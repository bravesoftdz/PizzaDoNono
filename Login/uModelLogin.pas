unit uModelLogin;

interface

uses
  System.SysUtils, Vcl.Dialogs, FireDAC.Comp.Client, Data.DB, FireDAC.DApt,
  uClassDBConnectionSingleton, FireDAC.VCLUI.Wait, FireDAC.Stan.Async,
  uDtoLogin;

type
  TModelLogin = class
  public
    oQuery: TFDQuery;
    function VerificarLogin(var ADtoLogin: TDtoLogin): Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TModelLogin }

constructor TModelLogin.Create;
begin
  oQuery := TFDQuery.Create(nil);
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
end;

destructor TModelLogin.Destroy;
begin
  if assigned(oQuery) then
    FreeAndNil(oQuery);
  inherited;
end;

function TModelLogin.VerificarLogin(var ADtoLogin: TDtoLogin): Boolean;
begin
  Result := False;
  oQuery.Open('SELECT idusuario, nome FROM usuario WHERE nome = ' + QuotedStr(ADtoLogin.Nome) + ' AND senha = '
    + QuotedStr(ADtoLogin.Senha));
  // testa se o retorno do banco de dados é vazio
  if not(oQuery.IsEmpty) then
  begin
    // se nao for vazio, login bem sucedido
    Result := True;
    ADtoLogin.idUsuario := oQuery.FieldByName('idusuario').AsInteger;
    ADtoLogin.Nome := oQuery.FieldByName('nome').AsString;
    ADtoLogin.Senha := EmptyStr;
  end;
end;

end.
