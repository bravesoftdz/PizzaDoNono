unit uModelBairro;

interface

uses
  System.SysUtils, Vcl.Dialogs, FireDAC.Comp.Client, Data.DB, FireDAC.DApt,
  uClassDBConnectionSingleton, FireDAC.VCLUI.Wait, FireDAC.Stan.Async,
  uDtoBairro, uInterfaceModelBairro;

type
  TModelBairro = class(TInterfacedObject, IModelBairro)
  public
    oQuery: TFDQuery;
    function Inserir(var oDtoBairro: TDtoBairro): Boolean;
    function BuscarMaiorID(out oDtoBairro: TDtoBairro): Boolean;
    function Listar: Boolean;
    function VerificarBairroCadastrado(var ADtoBairro
      : TDtoBairro): Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TEstadoModel }

function TModelBairro.BuscarMaiorID(out oDtoBairro
  : TDtoBairro): Boolean;
begin
  Result := False;
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
  oQuery.Open('SELECT MAX(idBairro) as MaxID FROM bairro');
  if not(oQuery.IsEmpty) then
  begin
    oDtoBairro.IdBairro := oQuery.FieldByName('MaxID').AsInteger;
    Result := True
  end;
end;

constructor TModelBairro.Create;
begin
  oQuery := TFDQuery.Create(nil);
end;

destructor TModelBairro.Destroy;
begin
  if assigned(oQuery) then
    FreeAndNil(oQuery);
  inherited;
end;

function TModelBairro.Inserir(var oDtoBairro: TDtoBairro): Boolean;
begin
  Result := False;
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
  oQuery.ExecSQL
    ('INSERT INTO Bairro(idBairro, nome, municipio_idmunicipio) VALUES(' +
    IntToStr(oDtoBairro.IdBairro) + ', ' + QuotedStr(oDtoBairro.Nome) +
    ', ' + IntToStr(oDtoBairro.Municipio) + ');');
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelBairro.Listar: Boolean;
begin
  Result := False;
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
  oQuery.Open('SELECT b.idBairro ID, b.Nome Nome, m.Nome Município FROM Bairro b ' +
    'LEFT JOIN municipio m ON b.municipio_idmunicipio = m.idmunicipio ORDER BY idBairro ASC');
  if not(oQuery.IsEmpty) then
    Result := True;
end;

function TModelBairro.VerificarBairroCadastrado(var ADtoBairro
  : TDtoBairro): Boolean;
begin
  Result := False;
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
  // seleciona no banco o nome
  oQuery.Open('SELECT Nome FROM Bairro WHERE municipio_idmunicipio = ' +
    IntToStr(ADtoBairro.Municipio) + ' AND Nome = ' +
    QuotedStr(ADtoBairro.Nome));
  // testa se o retorno do banco de dados é vazio
  if not(oQuery.IsEmpty) then
    // se nao for vazio, já existe Bairro cadastrado com este nome
    Result := True;
end;

end.
