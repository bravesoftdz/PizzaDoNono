unit uModelEstado;

interface

uses
  System.SysUtils, Vcl.Dialogs, FireDAC.Comp.Client, Data.DB, FireDAC.DApt,
  uClassDBConnectionSingleton, uDtoEstado, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Async, uInterfaceModelEstado, uListaEstado;

type
  TModelEstado = class(TInterfacedObject, IModelEstado)
  public
    oQuery: TFDQuery;
    function Inserir(var oDtoEstado: TDtoEstado): Boolean;
    function BuscarMaiorID(out ADtoEstado: TDtoEstado): Boolean;
    // listar os estados na Grid
    function Listar: Boolean;
    // listar os estados no combo box do cadastro de municipios
    function ListarEstados(var ALista: TListaEstado): Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TEstadoModel }

function TModelEstado.BuscarMaiorID(out ADtoEstado: TDtoEstado): Boolean;
begin
  Result := False;
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
  oQuery.Open('SELECT MAX(idEstado) as MaxID FROM estado');
  if not(oQuery.IsEmpty) then
  begin
    ADtoEstado.IdEstado := oQuery.FieldByName('MaxID').AsInteger;
    Result := True
  end;
end;

constructor TModelEstado.Create;
begin
  oQuery := TFDQuery.Create(nil);
end;

destructor TModelEstado.Destroy;
begin
  if assigned(oQuery) then
    FreeAndNil(oQuery);
  inherited;
end;

function TModelEstado.Inserir(var oDtoEstado: TDtoEstado): Boolean;
begin
  Result := False;
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
  oQuery.ExecSQL('INSERT INTO estado(idestado, nome, uf) VALUES(' +
    QuotedStr(IntToStr(oDtoEstado.IdEstado)) + ', ' + QuotedStr(oDtoEstado.Nome)
    + ', ' + QuotedStr(oDtoEstado.UF) + ');');
  Result := True;
end;

function TModelEstado.Listar: Boolean;
begin
  Result := False;
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
  oQuery.Open('SELECT idestado ID, UF, Nome FROM estado ORDER BY idestado ASC');
  if not(oQuery.IsEmpty) then
    Result := True;
end;

function TModelEstado.ListarEstados(var ALista: TListaEstado): Boolean;
var
  oDtoEstado: TDtoEstado;
begin
  Result := False;
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
  oQuery.Open('select IdEstado, Nome from Estado');
  if (not(oQuery.IsEmpty)) then
  begin
    oQuery.First;
    while (not(oQuery.Eof)) do
    begin
      oDtoEstado := TDtoEstado.Create;
      oDtoEstado.IdEstado := oQuery.FieldByName('IdEstado').AsInteger;
      oDtoEstado.Nome := oQuery.FieldByName('Nome').AsString;

      ALista.Add(oDtoEstado.Nome, oDtoEstado);

      oQuery.Next;
    end;
    Result := True;
  end;
end;

end.
