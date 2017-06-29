unit uModelSabor;

interface

uses
  System.SysUtils, Vcl.Dialogs, FireDAC.Comp.Client, Data.DB, FireDAC.DApt,
  uClassDBConnectionSingleton, FireDAC.VCLUI.Wait, FireDAC.Stan.Async,
  uDtoSabor, uInterfaceModelSabor, uDtoIngrediente, uListaIngrediente, uListaSabor;

type
  TModelSabor = class(TInterfacedObject, IModelSabor)
  public
    oQuery: TFDQuery;
    function Inserir(const oDtoSabor: TDtoSabor): Boolean;
    function Listar: Boolean;
    function Editar(const oDtoSabor: TDtoSabor): Boolean;
    function VerificarSaborCadastrado(var ADtoSabor: TDtoSabor): Boolean;
    function Excluir(const ADtoSabor: TDtoSabor): Boolean;
    function CountRegistros: integer;
    function BuscarSabores(var AListaSabor: TListaSabor): Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TEstadoModel }

function TModelSabor.CountRegistros: integer;
var
  newQuery: TFDQuery;
begin
  newQuery := TFDQuery.Create(nil);
  try
    newQuery.Connection := oQuery.Connection;
    newQuery.Open('SELECT COUNT(idsabor) quantidade FROM sabor');
    Result := newQuery.FieldByName('quantidade').AsInteger;
  finally
    FreeAndNil(newQuery);
  end;
end;

constructor TModelSabor.Create;
begin
  oQuery := TFDQuery.Create(nil);
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
end;

destructor TModelSabor.Destroy;
begin
  if assigned(oQuery) then
    FreeAndNil(oQuery);
  inherited;
end;

function TModelSabor.Editar(const oDtoSabor: TDtoSabor): Boolean;
begin
  Result := False;
  oQuery.ExecSQL('UPDATE sabor SET nome = ' + QuotedStr(oDtoSabor.Nome) + ',  valor = ' +
    CurrToStr(oDtoSabor.Valor) + '  WHERE idsabor = ' + IntToStr(oDtoSabor.IdSabor));
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelSabor.Excluir(const ADtoSabor: TDtoSabor): Boolean;
begin
  Result := False;
  oQuery.ExecSQL('DELETE FROM sabor WHERE idsabor = ' + IntToStr(ADtoSabor.IdSabor));
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelSabor.Inserir(const oDtoSabor: TDtoSabor): Boolean;
var
  oListaIngrediente: TListaIngrediente;
  oDtoIngrediente: TDtoIngrediente;
  IdSabor: integer;
begin
  Result := False;

  oQuery.ExecSQL('INSERT INTO sabor(nome, valor, tamanho_idtamanho) VALUES(' +
    QuotedStr(oDtoSabor.Nome) + ',' + CurrToStr(oDtoSabor.Valor) + ',' +
    CurrToStr(oDtoSabor.Tamanho) + ');');
  if oQuery.RowsAffected > 0 then
  begin
    oListaIngrediente := TListaIngrediente.Create;
    try
      oListaIngrediente := oDtoSabor.Ingrediente;
      oQuery.Open('SELECT LAST_INSERT_ID() idsabor');
      IdSabor := oQuery.FieldByName('idsabor').AsInteger;
      if oQuery.RowsAffected > 0 then
      begin
        for oDtoIngrediente in oListaIngrediente.Values do
        begin
          // oQuery.ExecSQL
          ShowMessage
            ('INSERT INTO sabor_ingrediente(sabor_idSabor, ingrediente_idingrediente) VALUES(' +
            IntToStr(IdSabor) + ', ' + IntToStr(oDtoIngrediente.IdIngrediente) + ');');
          if oQuery.RowsAffected > 0 then
            Result := True;
        end;
      end;
    finally
      FreeAndNil(oListaIngrediente);
    end;
  end;
end;

function TModelSabor.Listar: Boolean;
begin
  Result := False;
  oQuery.Open('SELECT s.idsabor, s.nome, s.valor, t.nome tamanho FROM sabor s ' +
    ' LEFT JOIN tamanho t ON s.tamanho_idtamanho = t.idtamanho ' + ' ORDER BY s.nome ASC');
  if not(oQuery.IsEmpty) then
    Result := True;
end;

function TModelSabor.BuscarSabores(var AListaSabor: TListaSabor): Boolean;
var
  oDtoSabor: TDtoSabor;
begin
  Result := False;

  oQuery.Open('select s.idsabor, s.nome, t.nome tamanho FROM sabor s ' +
    ' LEFT JOIN tamanho t ON s.tamanho_idtamanho = t.idtamanho ' + ' ORDER BY s.nome ASC');
  if (not(oQuery.IsEmpty)) then
  begin
    oQuery.First;
    while (not(oQuery.Eof)) do
    begin
      oDtoSabor := TDtoSabor.Create;
      oDtoSabor.IdSabor := oQuery.FieldByName('Idsabor').AsInteger;
      oDtoSabor.Nome := oQuery.FieldByName('Nome').AsString + ' - ' +
        oQuery.FieldByName('tamanho').AsString;

      AListaSabor.Add(oDtoSabor.Nome, oDtoSabor);

      oQuery.Next;
    end;
    Result := True;
  end;
end;

function TModelSabor.VerificarSaborCadastrado(var ADtoSabor: TDtoSabor): Boolean;
begin
  Result := False;

  // testa se nao recebe id
  if ADtoSabor.IdSabor = 0 then
  begin
    // se idSabor = 0 verifica somente nome do Sabor
    // seleciona no banco o nome
    oQuery.Open('SELECT nome FROM Sabor WHERE nome = ' + QuotedStr(ADtoSabor.Nome) +
      ' AND tamanho_idtamanho = ' + IntToStr(ADtoSabor.Tamanho));
    // testa se o retorno do banco de dados é vazio
    if not(oQuery.IsEmpty) then
      // se nao for vazio, já existe Sabor cadastrado com este nome
      Result := True;
  end
  else if ADtoSabor.IdSabor <> 0 then
  begin
    oQuery.Open('SELECT nome FROM Sabor WHERE nome = ' + QuotedStr(ADtoSabor.Nome) +
      ' AND tamanho_idtamanho = ' + IntToStr(ADtoSabor.Tamanho) + ' AND idsabor <> ' +
      IntToStr(ADtoSabor.IdSabor));
    // testa se o retorno do banco de dados é vazio
    if not(oQuery.IsEmpty) then
      // se nao for vazio, já existe Sabor cadastrado com este nome
      Result := True;
  end;

end;

end.
