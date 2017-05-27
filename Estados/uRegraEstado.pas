unit uRegraEstado;

interface

uses
  System.SysUtils, Vcl.Dialogs,
  uDtoEstado, uEnumeradorCamposEstado;

type
  TRegraEstado = class
  private
    //
  public
    function ValidarDados(var ADtoEstado: TDtoEstado): TCamposEstado;
  end;

implementation

{ TRegraEstado }

function TRegraEstado.ValidarDados(var ADtoEstado: TDtoEstado)
  : TCamposEstado;
begin
  if ADtoEstado.nome = EmptyStr then
  begin
    showMessage('Preencha o campo Nome.');
    Result := resultNome;
    exit;
  end;
  if ADtoEstado.UF = EmptyStr then
  begin
    showMessage('Preencha o campo UF.');
    Result := resultUF;
    exit;
  end;
  // caso não der erro nenhum retorna OK
  Result := resultOk;
end;

end.
