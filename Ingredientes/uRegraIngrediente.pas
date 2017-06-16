unit uRegraIngrediente;

interface

uses
  System.SysUtils, Vcl.Dialogs,
  uEnumeradorCamposIngrediente, uDtoIngrediente, uModelIngrediente;

type
  TRegraIngrediente = class
  private
    //
  public
    function ValidarDados(var ADtoIngrediente: TDtoIngrediente): TCamposIngrediente;
    function VerificarIngredienteCadastrado(const AModelIngrediente: TModelIngrediente;
      var ADtoIngrediente: TDtoIngrediente): Boolean;
    function Inserir(const AModelIngrediente: TModelIngrediente;
      const ADtoIngrediente: TDtoIngrediente): Boolean;
    function Editar(const AModelIngrediente: TModelIngrediente;
      const ADtoIngrediente: TDtoIngrediente): Boolean;
    function Excluir(const AModelIngrediente: TModelIngrediente;
      const ADtoIngrediente: TDtoIngrediente): Boolean;
  end;

implementation

{ TRegraIngrediente }

function TRegraIngrediente.Editar(const AModelIngrediente: TModelIngrediente;
  const ADtoIngrediente: TDtoIngrediente): Boolean;

begin
  Result := False;
  if AModelIngrediente.Editar(ADtoIngrediente) then
    Result := true;
end;

function TRegraIngrediente.Excluir(const AModelIngrediente: TModelIngrediente;
  const ADtoIngrediente: TDtoIngrediente): Boolean;
begin
  Result := False;
  if AModelIngrediente.Excluir(ADtoIngrediente) then
    Result := true;
end;

function TRegraIngrediente.Inserir(const AModelIngrediente: TModelIngrediente;
  const ADtoIngrediente: TDtoIngrediente): Boolean;
begin
  Result := False;
  if AModelIngrediente.Inserir(ADtoIngrediente) then
    Result := true;
end;

function TRegraIngrediente.ValidarDados(var ADtoIngrediente: TDtoIngrediente): TCamposIngrediente;
begin
  // testa se o campo nome foi informado
  if ADtoIngrediente.Nome = EmptyStr then
  begin
    // se for vazio
    Result := resultNome;
    exit;
  end;
  // caso não der erro nenhum retorna OK
  Result := resultOk;
end;

function TRegraIngrediente.VerificarIngredienteCadastrado(const AModelIngrediente
  : TModelIngrediente; var ADtoIngrediente: TDtoIngrediente): Boolean;
begin

  Result := False;
  // testa se o nome informado para o ingrediente já está
  if AModelIngrediente.VerificarIngredienteCadastrado(ADtoIngrediente) then
    Result := true;

end;

end.
