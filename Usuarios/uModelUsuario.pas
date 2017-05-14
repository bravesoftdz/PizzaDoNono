unit uModelUsuario;

interface

uses
  System.SysUtils, Vcl.Dialogs, FireDAC.Comp.Client, Data.DB, FireDAC.DApt,
  uClassDBConnectionSingleton, uDtoUsuario, FireDAC.VCLUI.Wait, FireDAC.Stan.Async;

type
  TModelUsuario = class(TFDQuery)
  public
    function Inserir(var oDtoUsuario: TDtoUsuario): Boolean;
  end;

implementation

{ TEstadoModel }

function TModelUsuario.Inserir(var oDtoUsuario: TDtoUsuario): Boolean;
begin
  Result := False;
  Connection := TDBConnectionSingleton.GetInstancia;
  // oQuery.Open('select idEstado, Nome from Estado where UF = '''+AEstado.UF+'''');
  // Open('SELECT MAX(idEstado) as MaxID FROM estado');
  ExecSQL('INSERT INTO usuario(idusuario, nome, senha) VALUES(' +
    QuotedStr(IntToStr(oDtoUsuario.IdUsuario)) + ', ' +
    QuotedStr(oDtoUsuario.Nome) + ', ' + QuotedStr(oDtoUsuario.Senha) + ');');
  Result := True;
end;

end.
