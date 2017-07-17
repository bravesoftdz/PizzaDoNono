unit uModelSabor;

interface

uses
  System.SysUtils, Vcl.Dialogs, FireDAC.Comp.Client, Data.DB, FireDAC.DApt,
  uClassDBConnectionSingleton, FireDAC.VCLUI.Wait, FireDAC.Stan.Async,
  uDtoSabor, uInterfaceModelSabor, uDtoIngrediente, uListaIngrediente,
  uListaSabor, uDtoProduto, uListaSaboresDisponiveis, uDtoTamanho,
  uDtoPedidoProduto;

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
    function BuscarSaboresPorTamanho(var AListaSabor: TListaSabor;
      const AID: integer): Boolean;
    function BuscarSaboresDisponiveis(var ALista: TListaSaboresDisponiveis;
      const ADtoProduto: TDtoProduto): Boolean;
    function BuscarValor(idsabor: integer): string;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TModelSabor }

function TModelSabor.BuscarSaboresDisponiveis
  (var ALista: TListaSaboresDisponiveis;
  const ADtoProduto: TDtoProduto): Boolean;
begin
  Result := False;

  oQuery.Open
    ('select sabor_idsabor FROM saboresDisponiveis WHERE produto_idproduto = ' +
    IntToStr(ADtoProduto.IdProduto));
  if (not(oQuery.IsEmpty)) then
  begin
    oQuery.First;
    while (not(oQuery.Eof)) do
    begin
      ALista.Add(oQuery.FieldByName('sabor_idsabor').AsInteger, '');
      oQuery.Next;
    end;
    Result := True;
  end;
end;

function TModelSabor.BuscarSaboresPorTamanho(var AListaSabor: TListaSabor;
  const AID: integer): Boolean;
var
  oDtoSabor: TDtoSabor;
begin
  Result := False;
  oQuery.Open('select idsabor, nome from sabor WHERE tamanho_idtamanho = ' +
    IntToStr(AID));
  if (not(oQuery.IsEmpty)) then
  begin
    oQuery.First;
    while (not(oQuery.Eof)) do
    begin
      oDtoSabor := TDtoSabor.Create;
      oDtoSabor.idsabor := oQuery.FieldByName('Idsabor').AsInteger;
      oDtoSabor.Nome := oQuery.FieldByName('Nome').AsString;

      AListaSabor.Add(oDtoSabor.Nome, oDtoSabor);

      oQuery.Next;
    end;
    Result := True;
  end;

end;

function TModelSabor.BuscarValor(idsabor: integer): string;
begin
  Result := '';
  oQuery.Open('select valor from sabor WHERE idsabor = ' + IntToStr(idsabor));
  if (not(oQuery.IsEmpty)) then
    Result := oQuery.FieldByName('valor').AsString;

end;

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
  oQuery.ExecSQL('UPDATE sabor SET nome = ' + QuotedStr(oDtoSabor.Nome) +
    ',  valor = ' + CurrToStr(oDtoSabor.Valor) + '  WHERE idsabor = ' +
    IntToStr(oDtoSabor.idsabor));
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelSabor.Excluir(const ADtoSabor: TDtoSabor): Boolean;
begin
  Result := False;
  oQuery.ExecSQL('DELETE FROM sabor WHERE idsabor = ' +
    IntToStr(ADtoSabor.idsabor));
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelSabor.Inserir(const oDtoSabor: TDtoSabor): Boolean;
var
  oDtoIngrediente: TDtoIngrediente;
begin
  Result := False;

  oQuery.ExecSQL('INSERT INTO sabor(nome, valor, tamanho_idtamanho) VALUES(' +
    QuotedStr(oDtoSabor.Nome) + ',' + CurrToStr(oDtoSabor.Valor) + ',' +
    CurrToStr(oDtoSabor.Tamanho) + ');');
  if oQuery.RowsAffected > 0 then
  begin
    oQuery.Open('SELECT LAST_INSERT_ID() idsabor');
    if not(oQuery.IsEmpty) then
    begin
      oDtoSabor.idsabor := oQuery.FieldByName('idsabor').AsInteger;
      try
        for oDtoIngrediente in oDtoSabor.Ingrediente.Values do
        begin
          oQuery.ExecSQL
            ('INSERT INTO sabor_ingrediente(sabor_idSabor, ingrediente_idingrediente) VALUES('
            + IntToStr(oDtoSabor.idsabor) + ', ' +
            IntToStr(oDtoIngrediente.IdIngrediente) + ');');
          if oQuery.RowsAffected > 0 then
            Result := True;
        end;
      finally
        oDtoSabor.Ingrediente.Free;
      end;
    end;
  end;

end;

function TModelSabor.Listar: Boolean;
begin
  Result := False;
  oQuery.Open('SELECT s.idsabor, s.nome, s.valor, t.nome tamanho FROM sabor s '
    + ' LEFT JOIN tamanho t ON s.tamanho_idtamanho = t.idtamanho ' +
    ' ORDER BY s.nome ASC');
  if not(oQuery.IsEmpty) then
    Result := True;
end;

function TModelSabor.BuscarSabores(var AListaSabor: TListaSabor): Boolean;
var
  oDtoSabor: TDtoSabor;
begin
  Result := False;
  oQuery.Open('select s.idsabor, s.nome FROM sabor s ' +
    ' LEFT JOIN tamanho t ON s.tamanho_idtamanho = t.idtamanho ' +
    ' ORDER BY s.nome ASC');
  if (not(oQuery.IsEmpty)) then
  begin
    oQuery.First;
    while (not(oQuery.Eof)) do
    begin
      oDtoSabor := TDtoSabor.Create;
      oDtoSabor.idsabor := oQuery.FieldByName('Idsabor').AsInteger;
      oDtoSabor.Nome := oQuery.FieldByName('Nome').AsString;

      AListaSabor.Add(oDtoSabor.Nome, oDtoSabor);

      oQuery.Next;
    end;
    Result := True;
  end;
end;

function TModelSabor.VerificarSaborCadastrado(var ADtoSabor: TDtoSabor)
  : Boolean;
begin
  Result := False;

  // testa se nao recebe id
  if ADtoSabor.idsabor = 0 then
  begin
    // se idSabor = 0 verifica somente nome do Sabor
    // seleciona no banco o nome
    oQuery.Open('SELECT nome FROM Sabor WHERE nome = ' +
      QuotedStr(ADtoSabor.Nome) + ' AND tamanho_idtamanho = ' +
      IntToStr(ADtoSabor.Tamanho));
    // testa se o retorno do banco de dados � vazio
    if not(oQuery.IsEmpty) then
      // se nao for vazio, j� existe Sabor cadastrado com este nome
      Result := True;
  end
  else if ADtoSabor.idsabor <> 0 then
  begin
    oQuery.Open('SELECT nome FROM Sabor WHERE nome = ' +
      QuotedStr(ADtoSabor.Nome) + ' AND tamanho_idtamanho = ' +
      IntToStr(ADtoSabor.Tamanho) + ' AND idsabor <> ' +
      IntToStr(ADtoSabor.idsabor));
    // testa se o retorno do banco de dados � vazio
    if not(oQuery.IsEmpty) then
      // se nao for vazio, j� existe Sabor cadastrado com este nome
      Result := True;
  end;

end;

end.
