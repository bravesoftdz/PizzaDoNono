unit uModelIngrediente;

interface

uses
  System.SysUtils, Vcl.Dialogs, FireDAC.Comp.Client, Data.DB, FireDAC.DApt,
  uClassDBConnectionSingleton, FireDAC.VCLUI.Wait, FireDAC.Stan.Async,
  uDtoIngrediente, uInterfaceModelIngrediente;

type
  TModelIngrediente = class(TInterfacedObject, IModelIngrediente)
  public
    oQuery: TFDQuery;
    function Inserir(var oDtoIngrediente: TDtoIngrediente): Boolean;
    function BuscarMaiorID(out oDtoIngrediente: TDtoIngrediente): Boolean;
    function Listar: Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TEstadoModel }

function TModelIngrediente.BuscarMaiorID(out oDtoIngrediente
  : TDtoIngrediente): Boolean;
begin
  Result := False;
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
  oQuery.Open('SELECT MAX(idIngrediente) as MaxID FROM ingrediente');
  if not(oQuery.IsEmpty) then
  begin
    oDtoIngrediente.IdIngrediente := oQuery.FieldByName('MaxID').AsInteger;
    Result := True
  end;
end;

constructor TModelIngrediente.Create;
begin
  oQuery := TFDQuery.Create(nil);
end;

destructor TModelIngrediente.Destroy;
begin
  if assigned(oQuery) then
    FreeAndNil(oQuery);
  inherited;
end;

function TModelIngrediente.Inserir(var oDtoIngrediente: TDtoIngrediente): Boolean;
begin
  Result := False;
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
  oQuery.ExecSQL('INSERT INTO ingrediente(idIngrediente, descricao) VALUES(' +
    QuotedStr(IntToStr(oDtoIngrediente.IdIngrediente)) + ', ' +
    QuotedStr(oDtoIngrediente.Descricao) + ');');
  Result := True;
end;

function TModelIngrediente.Listar: Boolean;
begin
  Result := False;
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
  oQuery.Open('SELECT idIngrediente ID, Descricao FROM ingrediente ORDER BY idIngrediente ASC');
  if not(oQuery.IsEmpty) then
    Result := True;
end;

end.
