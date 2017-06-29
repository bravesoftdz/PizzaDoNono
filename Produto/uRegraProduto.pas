unit uRegraProduto;

interface

uses
  System.SysUtils, Vcl.Dialogs, Vcl.CheckLst,
  uEnumeradorCamposProduto, uDtoProduto, uModelProduto, uModelSabor;

type
  TRegraProduto = class
  private
    //
  public
    function ValidarDados(var ADtoProduto: TDtoProduto): TCamposProduto;
    function VerificarProdutoCadastrado(const AModelProduto: TModelProduto;
      var ADtoProduto: TDtoProduto): Boolean;
    function Inserir(const AModelProduto: TModelProduto; const ADtoProduto: TDtoProduto): Boolean;
    function Editar(const AModelProduto: TModelProduto; const ADtoProduto: TDtoProduto): Boolean;
    function Excluir(const AModelProduto: TModelProduto; const ADtoProduto: TDtoProduto): Boolean;
    function CountRegistros(const AModel: TModelProduto): Boolean;
  end;

implementation

{ TRegra Produto }

function TRegraProduto.CountRegistros(const AModel: TModelProduto): Boolean;
begin
  Result := False;
  if AModel.CountRegistros > 0 then
    // se a quantidade de registros for maior que zero
    Result := true; // true, pois existem registros
end;

function TRegraProduto.Editar(const AModelProduto: TModelProduto;
  const ADtoProduto: TDtoProduto): Boolean;
begin
  Result := False;
  if AModelProduto.Editar(ADtoProduto) then
    Result := true;
end;

function TRegraProduto.Excluir(const AModelProduto: TModelProduto;
  const ADtoProduto: TDtoProduto): Boolean;
begin
  Result := False;
  if AModelProduto.Excluir(ADtoProduto) then
    Result := true;
end;

function TRegraProduto.Inserir(const AModelProduto: TModelProduto;
  const ADtoProduto: TDtoProduto): Boolean;
begin
  Result := False;
  if AModelProduto.Inserir(ADtoProduto) then
    Result := true;
end;

function TRegraProduto.ValidarDados(var ADtoProduto: TDtoProduto): TCamposProduto;
begin
  // testa se o campo nome foi informado
  if ADtoProduto.Nome = EmptyStr then
  begin
    // se for vazio
    Result := resultNome;
    exit;
  end;
  if ADtoProduto.TemSabor = Boolean(nil) then
  begin
    Result := resultTemSabor;
    exit;
  end;
  if (ADtoProduto.TemSabor = false) and (ADtoProduto.Valor = 0) then
  begin
    Result := resultValor;
    exit;
  end;



  // caso não der erro nenhum retorna OK
  Result := resultOk;
end;

function TRegraProduto.VerificarProdutoCadastrado(const AModelProduto: TModelProduto;
  var ADtoProduto: TDtoProduto): Boolean;
begin

  Result := False;
  // testa se o nome informado para o Produto já está
  if AModelProduto.VerificarProdutoCadastrado(ADtoProduto) then
    Result := true;

end;

end.
