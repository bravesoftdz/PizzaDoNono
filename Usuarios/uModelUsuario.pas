unit uModelUsuario;

interface

uses
  System.SysUtils, Vcl.Dialogs, FireDAC.Comp.Client, Data.DB, FireDAC.DApt,
  uClassDBConnectionSingleton, uDtoUsuario, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Async, uListaHashUsuario;

type
  TModelUsuario = class(TFDQuery)
  public
    function Inserir(var oDtoUsuario: TDtoUsuario): Boolean;
    function GetMaxID: integer;
    function Listar(oListaUsuarios: TListaUsuario): Boolean;
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

function TModelUsuario.Listar(oListaUsuarios: TListaUsuario): Boolean;
var
  oDtoUsuario: TDtoUsuario;
begin
  Result := False;
  Connection := TDBConnectionSingleton.GetInstancia;
  Open('SELECT idusuario, nome FROM usuario ORDER BY idusuario ASC');
  if not(IsEmpty) then
  begin
    First;
    while (not(Eof)) do
    begin
      // Instancia do objeto
      oDtoUsuario := TDtoUsuario.Create;

      // Atribui os valores
      oDtoUsuario.IdUsuario := FieldByName('idusuario').AsInteger;
      oDtoUsuario.Nome := FieldByName('nome').AsString;

      // Adiciona o objeto na lista hash
      oListaUsuarios.Add(oDtoUsuario.Nome, oDtoUsuario);

      // Vai para o próximo registro
      Next;
    end;
    oDtoUsuario := nil;
    Result := True;
  end;
end;

end.
