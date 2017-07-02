unit uRegraPedido;

interface

uses
  System.SysUtils, Vcl.Dialogs,
  uDtoPedido, uModelPedido, uEnumeradorCamposPedido;

type
  TRegraPedido = class
  private
    //
  public
    function ValidarDados(var ADtoPedido: TDtoPedido): TCamposPedido;
    function VerificarPedido(const AModelPedido: TModelPedido; var ADtoPedido: TDtoPedido): Boolean;
  end;

implementation

{ TRegraPedido }

function TRegraPedido.ValidarDados(var ADtoPedido: TDtoPedido): TCamposPedido;
begin
  // testa se o campo nome foi informado
  if ADtoPedido.Nome = EmptyStr then
  begin
    // se for vazio
    Result := resultNome;
    exit;
  end;
  // testa se o campo senha foi informado
  if ADtoPedido.Senha = EmptyStr then
  begin
    // se for vazio
    Result := resultSenha;
    exit;
  end;
  // caso não der erro nenhum retorna OK
  Result := resultOk;
end;

function TRegraPedido.VerificarPedido(const AModelPedido: TModelPedido;
  var ADtoPedido: TDtoPedido): Boolean;
begin

  Result := False;
  // testa se o nome informado para o Pedido já está
  if AModelPedido.VerificarPedido(ADtoPedido) then
    Result := true;

end;

end.
