unit uModelUsuario;

interface

uses
  System.SysUtils, Vcl.Dialogs, FireDAC.Comp.Client, Data.DB, FireDAC.DApt,
  uClassDBConnectionSingleton, uDtoUsuario, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Async;

type
  TModelUsuario = class(TFDQuery)
  public
    function Inserir(var oDtoUsuario: TDtoUsuario): Boolean;
    function GetMaxID: integer;
  end;

implementation

{ TEstadoModel }

function TModelUsuario.GetMaxID: integer;
begin
  Connection := TDBConnectionSingleton.GetInstancia;
  Open('SELECT MAX(idUsuario) as MaxID FROM usuario');
  Result := FieldByName('MaxID').AsInteger;
end;

function TModelUsuario.Inserir(var oDtoUsuario: TDtoUsuario): Boolean;
begin
  Result := False;
  Connection := TDBConnectionSingleton.GetInstancia;
  ExecSQL('INSERT INTO usuario(idusuario, nome, senha) VALUES(' +
    QuotedStr(IntToStr(oDtoUsuario.IdUsuario)) + ', ' +
    QuotedStr(oDtoUsuario.Nome) + ', ' + QuotedStr(oDtoUsuario.Senha) + ');');
  Result := True;
end;

end.
