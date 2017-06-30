unit uModelProduto;

interface

uses
  System.SysUtils, Vcl.Dialogs, FireDAC.Comp.Client, Data.DB, FireDAC.DApt,
  uClassDBConnectionSingleton, FireDAC.VCLUI.Wait, FireDAC.Stan.Async,
  uDtoProduto, uInterfaceModelProduto, uListaSabor, uDtoSabor, uEnumeradorTemSabor;

type
  TModelProduto = class(TInterfacedObject, IModelProduto)
  public
    oQuery: TFDQuery;
    function Inserir(const oDtoProduto: TDtoProduto): Boolean;
    function Listar: Boolean;
    function Editar(const oDtoProduto: TDtoProduto): Boolean;
    function VerificarProdutoCadastrado(var ADtoProduto: TDtoProduto): Boolean;
    function Excluir(const ADtoProduto: TDtoProduto): Boolean;
    function CountRegistros: integer;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TModelProduto }

function TModelProduto.CountRegistros: integer;
var
  newQuery: TFDQuery;
begin
  newQuery := TFDQuery.Create(nil);
  try
    newQuery.Connection := oQuery.Connection;
    newQuery.Open('SELECT COUNT(idproduto) quantidade FROM produto');
    Result := newQuery.FieldByName('quantidade').AsInteger;
  finally
    FreeAndNil(newQuery);
  end;
end;

constructor TModelProduto.Create;
begin
  oQuery := TFDQuery.Create(nil);
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
end;

destructor TModelProduto.Destroy;
begin
  if assigned(oQuery) then
    FreeAndNil(oQuery);
  inherited;
end;

function TModelProduto.Editar(const oDtoProduto: TDtoProduto): Boolean;
var
  oDtoSabor: TDtoSabor;
begin
  Result := False;
  if oDtoProduto.TemSabor = resultNao then
  begin
    oQuery.ExecSQL('UPDATE produto SET nome = ' + QuotedStr(oDtoProduto.Nome) + ', Valor = ' +
      QuotedStr(oDtoProduto.Valor) + ', temSabor = 1 WHERE idproduto = ' +
      IntToStr(oDtoProduto.IdProduto));
    if oQuery.RowsAffected > 0 then
      Result := True;
  end
  else if oDtoProduto.TemSabor = resultSim then
  begin
    oQuery.ExecSQL('DELETE FROM saboresDisponiveis WHERE produto_idproduto = ' +
      IntToStr(oDtoProduto.IdProduto));
    try
      for oDtoSabor in oDtoProduto.Sabor.Values do
      begin
        oQuery.ExecSQL('INSERT INTO saboresDisponiveis(produto_idproduto, sabor_idSabor) VALUES(' +
          IntToStr(oDtoProduto.IdProduto) + ', ' + IntToStr(oDtoSabor.idSabor) + ');');
      end;
    finally
      oDtoProduto.Sabor.Free;
    end;
    if oQuery.RowsAffected > 0 then
    begin
      oQuery.ExecSQL('UPDATE produto SET nome = ' + QuotedStr(oDtoProduto.Nome) + ', Valor = ' +
        QuotedStr(oDtoProduto.Valor) + ', temSabor = 1 WHERE idproduto = ' +
        IntToStr(oDtoProduto.IdProduto));
      if oQuery.RowsAffected > 0 then
        Result := True;
    end;
  end;

end;

function TModelProduto.Excluir(const ADtoProduto: TDtoProduto): Boolean;
begin
  Result := False;
  oQuery.ExecSQL('DELETE FROM saboresDisponiveis WHERE produto_idproduto = ' +
    IntToStr(ADtoProduto.IdProduto));
  if oQuery.RowsAffected > 0 then
  begin
    oQuery.ExecSQL('DELETE FROM produto WHERE idproduto = ' + IntToStr(ADtoProduto.IdProduto));
    if oQuery.RowsAffected > 0 then
      Result := True;
  end;
end;

function TModelProduto.Inserir(const oDtoProduto: TDtoProduto): Boolean;
var
  oDtoSabor: TDtoSabor;
begin
  Result := False;
  if oDtoProduto.TemSabor = resultNao then
  begin
    oQuery.ExecSQL('INSERT INTO produto(nome, valor, temSabor) VALUES(' +
      QuotedStr(oDtoProduto.Nome) + ', ' + QuotedStr(oDtoProduto.Valor) + ', 0);');
    if oQuery.RowsAffected > 0 then
      Result := True;
  end
  else if oDtoProduto.TemSabor = resultSim then
  begin
    oQuery.ExecSQL('INSERT INTO produto(nome, temSabor) VALUES(' + QuotedStr(oDtoProduto.Nome)
      + ', 1);');
    if oQuery.RowsAffected > 0 then
    begin
      oQuery.Open('SELECT LAST_INSERT_ID() idproduto');
      if not(oQuery.IsEmpty) then
      begin
        oDtoProduto.IdProduto := oQuery.FieldByName('idproduto').AsInteger;
        try
          for oDtoSabor in oDtoProduto.Sabor.Values do
          begin
            oQuery.ExecSQL
              ('INSERT INTO saboresDisponiveis(produto_idproduto, sabor_idSabor) VALUES(' +
              IntToStr(oDtoProduto.IdProduto) + ', ' + IntToStr(oDtoSabor.idSabor) + ');');
            if oQuery.RowsAffected > 0 then
              Result := True;
          end;
        finally
          oDtoProduto.Sabor.Free;
        end;
      end;
    end;
  end;

end;

function TModelProduto.Listar: Boolean;
begin
  Result := False;
  oQuery.Open('SELECT idproduto, nome, valor, temSabor FROM produto ORDER BY nome ASC');
  if not(oQuery.IsEmpty) then
    Result := True;
end;

function TModelProduto.VerificarProdutoCadastrado(var ADtoProduto: TDtoProduto): Boolean;
begin
  Result := False;

  // testa se nao recebe id
  if ADtoProduto.IdProduto = 0 then
  begin
    // se idProduto = 0 verifica somente nome do Produto
    // seleciona no banco o nome
    oQuery.Open('SELECT nome FROM Produto WHERE nome = ' + QuotedStr(ADtoProduto.Nome));
    // testa se o retorno do banco de dados é vazio
    if not(oQuery.IsEmpty) then
      // se nao for vazio, já existe Tamanho cadastrado com este nome
      Result := True;
  end
  else if ADtoProduto.IdProduto <> 0 then
  begin
    oQuery.Open('SELECT nome FROM Produto WHERE nome = ' + QuotedStr(ADtoProduto.Nome) +
      ' AND idproduto <> ' + IntToStr(ADtoProduto.IdProduto));
    // testa se o retorno do banco de dados é vazio
    if not(oQuery.IsEmpty) then
      // se nao for vazio, já existe Produto cadastrado com este nome
      Result := True;
  end;

end;

end.
