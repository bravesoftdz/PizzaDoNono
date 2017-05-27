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
  oQuery.ExecSQL('INSERT INTO Municipio(idMunicipio, descricao) VALUES(' +
    QuotedStr(IntToStr(oDtoMunicipio.IdMunicipio)) + ', ' +
    QuotedStr(oDtoMunicipio.Nome) + ');');
  Result := True;
end;

function TModelMunicipio.Listar: Boolean;
begin
  Result := False;
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
  oQuery.Open('SELECT idMunicipio ID, Descricao FROM Municipio ORDER BY idMunicipio ASC');
  if not(oQuery.IsEmpty) then
    Result := True;
end;

end.
