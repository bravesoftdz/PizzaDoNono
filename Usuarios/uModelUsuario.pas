unit uModelUsuario;

interface

uses
  System.SysUtils, Vcl.Dialogs, FireDAC.Comp.Client, Data.DB, FireDAC.DApt,
  uClassDBConnectionSingleton, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Async, uDtoUsuario, uInterfaceModelUsuario;

type
  TModelUsuario = class(TInterfacedObject, IModelUsuario)
  public
    oQuery: TFDQuery;
    function Inserir(const oDtoUsuario: TDtoUsuario): Boolean;
    function Listar: Boolean;
    function Editar(const oDtoUsuario: TDtoUsuario): Boolean;
    function VerificarUsuarioCadastrado(var ADtoUsuario: TDtoUsuario): Boolean;
    function Excluir(const ADtoUsuario: TDtoUsuario): Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TModelUsuario }


constructor TModelUsuario.Create;
begin
   oQuery := TFDQuery.Create(nil);
  oQuery.Connection := TDBConnectionSingleton.GetInstancia;
end;

destructor TModelUsuario.Destroy;
begin
  if assigned(oQuery) then
    FreeAndNil(oQuery);
  inherited;
end;

function TModelUsuario.Editar(const oDtoUsuario: TDtoUsuario): Boolean;
begin
 Result := False;
  oQuery.ExecSQL('UPDATE usuario SET nome = ' + QuotedStr(oDtoUsuario.Nome) +
    ' WHERE idusuario = ' + IntToStr(oDtoUsuario.IdUsuario));
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelUsuario.Excluir(const ADtoUsuario: TDtoUsuario): Boolean;
begin
  Result := False;
  oQuery.ExecSQL('DELETE FROM usuario WHERE idusuario = ' +
    IntToStr(ADtoUsuario.IdUsuario));
  if oQuery.RowsAffected > 0 then
    Result := True;
end;

function TModelUsuario.Inserir(const oDtoUsuario: TDtoUsuario): Boolean;
begin
  Result := False;
  oQuery.ExecSQL('INSERT INTO usuario(nome, senha) VALUES(' +
    QuotedStr(oDtoUsuario.Nome) + ', ' + QuotedStr(oDtoUsuario.Senha) + ');');
  Result := True;
end;

function TModelUsuario.Listar: Boolean;
begin
  Result := False;
  oQuery.Open
    ('SELECT idusuario ID, Nome FROM usuario ORDER BY idusuario ASC');
  if not(oQuery.IsEmpty) then
    Result := True;
end;

function TModelUsuario.VerificarUsuarioCadastrado(
  var ADtoUsuario: TDtoUsuario): Boolean;
begin
Result := False;

  // testa se nao recebe id
  if ADtoUsuario.IdUsuario = 0 then
  begin
    // se idUsuario = 0 verifica somente nome do usuario
    // seleciona no banco o nome
    oQuery.Open('SELECT nome FROM Usuario WHERE nome = ' + QuotedStr(ADtoUsuario.Nome));
    // testa se o retorno do banco de dados é vazio
    if not(oQuery.IsEmpty) then
      // se nao for vazio, já existe Usuario cadastrado com este nome
      Result := True;
  end
  else if ADtoUsuario.IdUsuario <> 0 then
  begin
    oQuery.Open('SELECT nome FROM Usuario ' + QuotedStr(ADtoUsuario.Nome) +
      ' AND idusuario <> ' + IntToStr(ADtoUsuario.IdUsuario));
    // testa se o retorno do banco de dados é vazio
    if not(oQuery.IsEmpty) then
      // se nao for vazio, já existe Usuario cadastrado com este nome
      Result := True;
  end;




end;

end.
