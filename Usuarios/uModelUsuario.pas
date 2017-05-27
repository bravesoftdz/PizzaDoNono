unit uModelUsuario;

interface

uses
  System.SysUtils, Vcl.Dialogs, FireDAC.Comp.Client, Data.DB, FireDAC.DApt,
  uClassDBConnectionSingleton, uDtoUsuario, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Async, uInterfaceModelUsuario;

type
  TModelUsuario = class(TInterfacedObject, IModelUsuario)
  public
    oQuery: TFDQuery;
    function Inserir(var oDtoUsuario: TDtoUsuario): Boolean;
    function BuscarMaiorID(out ADtoUsuario: TDtoUsuario): Boolean;
    function Listar: Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TEstadoModel }

function TModelUsuario.BuscarMaiorID(out ADtoUsuario: TDtoUsuario): Boolean;
begin
  Result := False;
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
  oQuery.Open('SELECT MAX(idUsuario) as MaxID FROM usuario');
  if not(oQuery.IsEmpty) then
  begin
    ADtoUsuario.IdUsuario := oQuery.FieldByName('MaxID').AsInteger;
    Result := True
  end;
end;

constructor TModelUsuario.Create;
begin
  oQuery := TFDQuery.Create(nil);
end;

destructor TModelUsuario.Destroy;
begin
  if assigned(oQuery) then
    FreeAndNil(oQuery);
  inherited;
end;

function TModelUsuario.Inserir(var oDtoUsuario: TDtoUsuario): Boolean;
begin
  Result := False;
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
  oQuery.ExecSQL('INSERT INTO usuario(idusuario, nome, senha) VALUES(' +
    QuotedStr(IntToStr(oDtoUsuario.IdUsuario)) + ', ' +
    QuotedStr(oDtoUsuario.Nome) + ', ' + QuotedStr(oDtoUsuario.Senha) + ');');
  Result := True;
end;

function TModelUsuario.Listar: Boolean;
var
  oDtoUsuario: TDtoUsuario;
begin
  Result := False;
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
  oQuery.Open
    ('SELECT idusuario ID, Nome FROM usuario ORDER BY idusuario ASC');
  if not(oQuery.IsEmpty) then
    Result := True;
end;

end.
