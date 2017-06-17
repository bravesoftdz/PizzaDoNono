{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N-,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN SYMBOL_EXPERIMENTAL ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN UNIT_EXPERIMENTAL ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
{$WARN OPTION_TRUNCATED ON}
{$WARN WIDECHAR_REDUCED ON}
{$WARN DUPLICATES_IGNORED ON}
{$WARN UNIT_INIT_SEQ ON}
{$WARN LOCAL_PINVOKE ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN TYPEINFO_IMPLICITLY_ADDED ON}
{$WARN RLINK_WARNING ON}
{$WARN IMPLICIT_STRING_CAST ON}
{$WARN IMPLICIT_STRING_CAST_LOSS ON}
{$WARN EXPLICIT_STRING_CAST OFF}
{$WARN EXPLICIT_STRING_CAST_LOSS OFF}
{$WARN CVT_WCHAR_TO_ACHAR ON}
{$WARN CVT_NARROWING_STRING_LOST ON}
{$WARN CVT_ACHAR_TO_WCHAR ON}
{$WARN CVT_WIDENING_STRING_LOST ON}
{$WARN NON_PORTABLE_TYPECAST ON}
{$WARN XML_WHITESPACE_NOT_ALLOWED ON}
{$WARN XML_UNKNOWN_ENTITY ON}
{$WARN XML_INVALID_NAME_START ON}
{$WARN XML_INVALID_NAME ON}
{$WARN XML_EXPECTED_CHARACTER ON}
{$WARN XML_CREF_NO_RESOLVE ON}
{$WARN XML_NO_PARM ON}
{$WARN XML_NO_MATCHING_PARM ON}
{$WARN IMMUTABLE_STRINGS OFF}
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
    function CountRegistros: integer;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TModelMuncipio }

function TModelMunicipio.CountRegistros: integer;
var
  newQuery: TFDQuery;
begin
  newQuery := TFDQuery.Create(nil);
  try
    newQuery.Connection := oQuery.Connection;
    newQuery.Open('SELECT COUNT(idmunicipio) quantidade FROM municipio');
    Result := newQuery.FieldByName('quantidade').AsInteger;
  finally
    FreeAndNil(newQuery);
  end;
end;

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
    'LEFT JOIN Estado e ON m.estado_idestado = e.idestado ORDER BY m.estado_idestado, m.nome ASC');
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
