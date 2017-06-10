unit uModelMunicipio;

interface

uses
  System.SysUtils, Vcl.Dialogs, FireDAC.Comp.Client, Data.DB, FireDAC.DApt,
  uClassDBConnectionSingleton, FireDAC.VCLUI.Wait, FireDAC.Stan.Async, FireDAC.Phys.MySQLWrapper,
  uDtoMunicipio, uInterfaceModelMunicipio, uListaMunicipio, uDtoBairro;

type
  TModelMunicipio = class(TInterfacedObject, IModelMunicipio)
  public
    oQuery: TFDQuery;
    function Inserir(const oDtoMunicipio: TDtoMunicipio): Boolean;
    function Listar: Boolean;
    function Editar(const ADtoMunicipio: TDtoMunicipio): Boolean;
    function VerificarMunicipioCadastrado(var ADtoMunicipio: TDtoMunicipio): Boolean;
    function ListarMunicipios(var AListaMunicipio: TListaMunicipio;
      var ADtoBairro: TDtoBairro): Boolean;
    function Excluir(const ADtoMunicipio: TDtoMunicipio): Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TModelMuncipio }

constructor TModelMunicipio.Create;
begin
  oQuery := TFDQuery.Create(nil);
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
end;

destructor TModelMunicipio.Destroy;
begin
  if assigned(oQuery) then
    FreeAndNil(oQuery);
  inherited;
end;

function TModelMunicipio.Editar(const ADtoMunicipio: TDtoMunicipio): Boolean;
begin
  Result := False;
  oQuery.ExecSQL('UPDATE municipio SET nome = ' + QuotedStr(ADtoMunicipio.Nome) +
    ', estado_idestado = ' + IntToStr(ADtoMunicipio.Estado) + ' WHERE idmunicipio = ' +
    IntToStr(ADtoMunicipio.IdMunicipio));
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelMunicipio.Excluir(const ADtoMunicipio: TDtoMunicipio): Boolean;
begin
  Result := False;
  try
    oQuery.ExecSQL('DELETE FROM municipio WHERE idmunicipio = ' +
      IntToStr(ADtoMunicipio.IdMunicipio));
    if oQuery.RowsAffected > 0 then
      Result := True;
  except
    on E: EMySQLNativeException do
    begin
      if Pos('Cannot delete or update a parent row: a foreign key constraint fails', E.Message) > 0
      then
        ShowMessage('Existem bairros associados a este município');
    end;
  end;

end;

function TModelMunicipio.Inserir(const oDtoMunicipio: TDtoMunicipio): Boolean;
begin
  Result := False;
  oQuery.ExecSQL('INSERT INTO Municipio(idMunicipio, nome, estado_idestado) VALUES(' +
    IntToStr(oDtoMunicipio.IdMunicipio) + ', ' + QuotedStr(oDtoMunicipio.Nome) + ', ' +
    IntToStr(oDtoMunicipio.Estado) + ');');
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelMunicipio.Listar: Boolean;
begin
  Result := False;
  oQuery.Open('SELECT m.idMunicipio ID, m.Nome Nome, e.nome Estado FROM Municipio m ' +
    'LEFT JOIN Estado e ON m.estado_idestado = e.idestado ORDER BY idMunicipio ASC');
  if not(oQuery.IsEmpty) then
    Result := True;
end;

function TModelMunicipio.ListarMunicipios(var AListaMunicipio: TListaMunicipio;
  var ADtoBairro: TDtoBairro): Boolean;
var
  oDtoMunicipio: TDtoMunicipio;
begin
  Result := False;
  oQuery.Open('select IdMunicipio, Nome from municipio WHERE estado_idestado = ' +
    IntToStr(ADtoBairro.Estado) + ';');
  if (not(oQuery.IsEmpty)) then
  begin
    oQuery.First;
    while (not(oQuery.Eof)) do
    begin
      oDtoMunicipio := TDtoMunicipio.Create;
      oDtoMunicipio.IdMunicipio := oQuery.FieldByName('IdMunicipio').AsInteger;
      oDtoMunicipio.Nome := oQuery.FieldByName('Nome').AsString;

      AListaMunicipio.Add(oDtoMunicipio.Nome, oDtoMunicipio);

      oQuery.Next;
    end;
    Result := True;
  end;
end;

function TModelMunicipio.VerificarMunicipioCadastrado(var ADtoMunicipio: TDtoMunicipio): Boolean;
begin
  Result := False;
  // testa se nao recebe id
  if ADtoMunicipio.IdMunicipio = 0 then
  begin
    // se idmunicipio = 0 verifica somente nome do municipio
    // seleciona no banco o nome
    oQuery.Open('SELECT Nome FROM Municipio WHERE estado_idestado = ' +
      IntToStr(ADtoMunicipio.Estado) + ' AND Nome = ' + QuotedStr(ADtoMunicipio.Nome));
    // testa se o retorno do banco de dados é vazio
    if not(oQuery.IsEmpty) then
      // se nao for vazio, já existe Bairro cadastrado com este nome
      Result := True;
  end
  else if ADtoMunicipio.IdMunicipio <> 0 then
  begin
    // se idmunicipio <> 0 verifica nome do municipio que seja diferente do id que esta em edição
    oQuery.Open('SELECT Nome FROM Municipio WHERE estado_idestado = ' +
      IntToStr(ADtoMunicipio.Estado) + ' AND Nome = ' + QuotedStr(ADtoMunicipio.Nome) +
      ' AND idmunicipio <> ' + IntToStr(ADtoMunicipio.IdMunicipio));
    // testa se o retorno do banco de dados é vazio
    if not(oQuery.IsEmpty) then
      // se nao for vazio, já existe Bairro cadastrado com este nome
      Result := True;
  end;
end;

end.
