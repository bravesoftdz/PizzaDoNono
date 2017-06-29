unit uModelTamanho;

interface

uses
  System.SysUtils, Vcl.Dialogs, FireDAC.Comp.Client, Data.DB, FireDAC.DApt,
  uClassDBConnectionSingleton, FireDAC.VCLUI.Wait, FireDAC.Stan.Async,
  uDtoTamanho, uInterfaceModelTamanho, uListaTamanho;

type
  TModelTamanho = class(TInterfacedObject, IModelTamanho)
  public
    oQuery: TFDQuery;
    function Inserir(const oDtoTamanho: TDtoTamanho): Boolean;
    function Listar: Boolean;
    function Editar(const oDtoTamanho: TDtoTamanho): Boolean;
    function VerificarTamanhoCadastrado(var ADtoTamanho: TDtoTamanho): Boolean;
    function Excluir(const ADtoTamanho: TDtoTamanho): Boolean;
    function CountRegistros: integer;
       // listar os tamanhos no combobox dos sabores
    function ListarTamanhos(var ALista: TListaTamanho): Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TModelTamanho }

function TModelTamanho.CountRegistros: integer;
var
  newQuery: TFDQuery;
begin
  newQuery := TFDQuery.Create(nil);
  try
    newQuery.Connection := oQuery.Connection;
    newQuery.Open('SELECT COUNT(idtamanho) quantidade FROM tamanho');
    Result := newQuery.FieldByName('quantidade').AsInteger;
  finally
    FreeAndNil(newQuery);
  end;
end;


constructor TModelTamanho.Create;
begin
  oQuery := TFDQuery.Create(nil);
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
end;

destructor TModelTamanho.Destroy;
begin
  if assigned(oQuery) then
    FreeAndNil(oQuery);
  inherited;
end;

function TModelTamanho.Editar(const oDtoTamanho: TDtoTamanho): Boolean;
begin
  Result := False;
  oQuery.ExecSQL('UPDATE tamanho SET nome = ' + QuotedStr(oDtoTamanho.Nome) +
  ', MaxSabores = ' + IntToStr(oDtoTamanho.MaxSabores) +
   ' WHERE idtamanho = ' + IntToStr(oDtoTamanho.IdTamanho));
 if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelTamanho.Excluir(const ADtoTamanho: TDtoTamanho): Boolean;
begin
  Result := False;
  oQuery.ExecSQL('DELETE FROM tamanho WHERE idtamanho = ' +
    IntToStr(ADtoTamanho.IdTamanho));
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelTamanho.Inserir(const oDtoTamanho: TDtoTamanho): Boolean;
begin
  Result := False;
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
  oQuery.ExecSQL('INSERT INTO tamanho(nome, MaxSabores) VALUES(' + QuotedStr(oDtoTamanho.Nome)+ ', '
  + IntToStr(oDtoTamanho.MaxSabores) + ');');
  Result := True;
end;

function TModelTamanho.Listar: Boolean;
begin
  Result := False;

  oQuery.Open('SELECT idtamanho, nome, maxsabores FROM tamanho ORDER BY nome ASC');
  if not(oQuery.IsEmpty) then
    Result := True;
end;

function TModelTamanho.ListarTamanhos(var ALista: TListaTamanho): Boolean;
var
  oDtoTamanho: TDtoTamanho;
begin
  Result := False;

  oQuery.Open('select IdTamanho, Nome from Tamanho');
  if (not(oQuery.IsEmpty)) then
  begin
    oQuery.First;
    while (not(oQuery.Eof)) do
    begin
      oDtoTamanho := TDtoTamanho.Create;
      oDtoTamanho.IdTamanho := oQuery.FieldByName('IdTamanho').AsInteger;
      oDtoTamanho.nome := oQuery.FieldByName('Nome').AsString;

      ALista.Add(oDtoTamanho.nome, oDtoTamanho);

      oQuery.Next;
    end;
    Result := True;
  end;
end;

function TModelTamanho.VerificarTamanhoCadastrado(var ADtoTamanho
  : TDtoTamanho): Boolean;
begin
  Result := False;

  // testa se nao recebe id
  if ADtoTamanho.IdTamanho = 0 then
  begin
    // se idTamanho = 0 verifica somente nome do tamanho
    // seleciona no banco o nome
    oQuery.Open('SELECT nome FROM Tamanho WHERE nome = ' + QuotedStr(ADtoTamanho.Nome));
    // testa se o retorno do banco de dados é vazio
    if not(oQuery.IsEmpty) then
      // se nao for vazio, já existe Tamanho cadastrado com este nome
      Result := True;
  end
  else if ADtoTamanho.IdTamanho <> 0 then
  begin
    oQuery.Open('SELECT nome FROM Tamanho ' + QuotedStr(ADtoTamanho.Nome) +
      ' AND idtamanho <> ' + IntToStr(ADtoTamanho.IdTamanho));
    // testa se o retorno do banco de dados é vazio
    if not(oQuery.IsEmpty) then
      // se nao for vazio, já existe Tamanho cadastrado com este nome
      Result := True;
  end;

end;

end.
