unit uModelMunicipio;

interface

uses
  System.SysUtils, Vcl.Dialogs, FireDAC.Comp.Client, Data.DB, FireDAC.DApt,
  uClassDBConnectionSingleton, FireDAC.VCLUI.Wait, FireDAC.Stan.Async,
  uDtoMunicipio, uInterfaceModelMunicipio;

type
  TModelMunicipio = class(TInterfacedObject, IModelMunicipio)
  public
    oQuery: TFDQuery;
    function Inserir(var oDtoMunicipio: TDtoMunicipio): Boolean;
    function BuscarMaiorID(out oDtoMunicipio: TDtoMunicipio): Boolean;
    function Listar: Boolean;
    function VerificarMunicipioCadastrado(var ADtoMunicipio
      : TDtoMunicipio): Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TEstadoModel }

function TModelMunicipio.BuscarMaiorID(out oDtoMunicipio
  : TDtoMunicipio): Boolean;
begin
  Result := False;
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
  oQuery.Open('SELECT MAX(idMunicipio) as MaxID FROM Municipio');
  if not(oQuery.IsEmpty) then
  begin
    oDtoMunicipio.IdMunicipio := oQuery.FieldByName('MaxID').AsInteger;
    Result := True
  end;
end;

constructor TModelMunicipio.Create;
begin
  oQuery := TFDQuery.Create(nil);
end;

destructor TModelMunicipio.Destroy;
begin
  if assigned(oQuery) then
    FreeAndNil(oQuery);
  inherited;
end;

function TModelMunicipio.Inserir(var oDtoMunicipio: TDtoMunicipio): Boolean;
begin
  Result := False;
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
  oQuery.ExecSQL
    ('INSERT INTO Municipio(idMunicipio, nome, estado_idestado) VALUES(' +
    IntToStr(oDtoMunicipio.IdMunicipio) + ', ' + QuotedStr(oDtoMunicipio.Nome) +
    ', ' + IntToStr(oDtoMunicipio.Estado) + ');');
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelMunicipio.Listar: Boolean;
begin
  Result := False;
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
  oQuery.Open('SELECT m.idMunicipio ID, m.Nome Nome, e.UF Estado FROM Municipio m ' +
    'LEFT JOIN Estado e ON m.estado_idestado = e.idestado ORDER BY idMunicipio ASC');
  if not(oQuery.IsEmpty) then
    Result := True;
end;

function TModelMunicipio.VerificarMunicipioCadastrado(var ADtoMunicipio
  : TDtoMunicipio): Boolean;
begin
  Result := False;
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
  // seleciona no banco o nome do
  oQuery.Open('SELECT Nome FROM Municipio WHERE estado_idestado = ' +
    IntToStr(ADtoMunicipio.Estado) + ' AND Nome = ' +
    QuotedStr(ADtoMunicipio.Nome));
  // testa se o retorno do banco de dados é vazio
  if not(oQuery.IsEmpty) then
    // se nao for vazio, já existe municipio cadastrado com este nome
    Result := True;
end;

end.
