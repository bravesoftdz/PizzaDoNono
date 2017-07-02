unit uModelPedido;

interface

uses
  System.SysUtils, Vcl.Dialogs, FireDAC.Comp.Client, Data.DB, FireDAC.DApt,
  uClassDBConnectionSingleton, FireDAC.VCLUI.Wait, FireDAC.Stan.Async,
  uDtoPedido;

type
  TModelPedido = class
  public
    oQuery: TFDQuery;
    function VerificarPedido(var ADtoPedido: TDtoPedido): Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TModelPedido }

constructor TModelPedido.Create;
begin
  oQuery := TFDQuery.Create(nil);
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
end;

destructor TModelPedido.Destroy;
begin
  if assigned(oQuery) then
    FreeAndNil(oQuery);
  inherited;
end;

function TModelPedido.VerificarPedido(var ADtoPedido: TDtoPedido): Boolean;
begin
  Result := False;
  oQuery.Open('SELECT idusuario, nome FROM usuario WHERE nome = ' + QuotedStr(ADtoPedido.Nome) + ' AND senha = '
    + QuotedStr(ADtoPedido.Senha));
  // testa se o retorno do banco de dados é vazio
  if not(oQuery.IsEmpty) then
  begin
    // se nao for vazio, Pedido bem sucedido
    Result := True;
    ADtoPedido.idUsuario := oQuery.FieldByName('idusuario').AsInteger;
    ADtoPedido.Nome := oQuery.FieldByName('nome').AsString;
    ADtoPedido.Senha := EmptyStr;
  end;
end;

end.
