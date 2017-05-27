unit uRegraIngrediente;

interface

uses
  System.SysUtils, Vcl.Dialogs,
  uEnumeradorCamposIngrediente, uDtoIngrediente;

type
  TRegraIngrediente = class
  private
    //
  public
    function ValidarDados(var ADtoIngrediente: TDtoIngrediente)
      : TCamposIngrediente;
  end;

implementation

{ TRegraIngrediente }

function TRegraIngrediente.ValidarDados(var ADtoIngrediente: TDtoIngrediente)
  : TCamposIngrediente;
begin
  if ADtoIngrediente.Descricao = EmptyStr then
  begin
    showMessage('Preencha o campo Descri��o.');
    Result := resultDescricao;
    exit;
  end;
  // caso n�o der erro nenhum retorna OK
  Result := resultOk;
end;

end.
