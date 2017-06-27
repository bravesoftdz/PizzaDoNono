unit uRegraCliente;

interface

uses
  System.SysUtils, Vcl.Dialogs, System.Math,
  uEnumeradorCamposCliente, uDtoCliente, uModelCliente;

type
  TRegraCliente = class
  private
    function ValidarCNPJ(var ADtoCliente: TDtoCliente): Boolean;
    function ValidarCPF(var ADtoCliente: TDtoCliente): Boolean;
  public
    function ValidarDados(var ADtoCliente: TDtoCliente): TCamposCliente;
    function VerificarCelularClienteCadastrado(const AModelCliente: TModelCliente;
      var ADtoCliente: TDtoCliente): Boolean;
    function VerificarTelefoneClienteCadastrado(const AModelCliente: TModelCliente;
      var ADtoCliente: TDtoCliente): Boolean;
    function Inserir(const AModelCliente: TModelCliente; const ADtoCliente: TDtoCliente): Boolean;
    function Editar(const AModelCliente: TModelCliente; const ADtoCliente: TDtoCliente): Boolean;
    function BuscarBairro(const AModelCliente: TModelCliente; out ADtoCliente: TDtoCliente)
      : Boolean;
    function Excluir(const AModelCliente: TModelCliente; const ADtoCliente: TDtoCliente): Boolean;
    function CountRegistros(const AModel: TModelCliente): Boolean;
    function Listar(const AModel: TModelCliente): Boolean;
    function VerificarTipoPessoa(const AModel: TModelCliente; var ADtoCliente: TDtoCliente)
      : Boolean;
    function BuscarEnderecoCliente(const AModel: TModelCliente;
      var ADtoCliente: TDtoCliente): Boolean;
  end;

implementation

{ TRegraCliente }

function TRegraCliente.BuscarEnderecoCliente(const AModel: TModelCliente;
  var ADtoCliente: TDtoCliente): Boolean;
begin
  Result := False;
  if AModel.BuscarEnderecoCliente(ADtoCliente) then
    Result := True;

end;

function TRegraCliente.BuscarBairro(const AModelCliente: TModelCliente;
  out ADtoCliente: TDtoCliente): Boolean;
begin
  Result := False;
  if AModelCliente.BuscarBairro(ADtoCliente) then
    Result := True;
end;

function TRegraCliente.CountRegistros(const AModel: TModelCliente): Boolean;
begin
  Result := False;
  if AModel.CountRegistros > 0 then
    // se a quantidade de registros for maior que zero
    Result := True; // true, pois existem registros
end;

function TRegraCliente.Editar(const AModelCliente: TModelCliente;
  const ADtoCliente: TDtoCliente): Boolean;
begin
  Result := False;
  if AModelCliente.Editar(ADtoCliente) then
    Result := True;
end;

function TRegraCliente.Excluir(const AModelCliente: TModelCliente;
  const ADtoCliente: TDtoCliente): Boolean;
begin
  Result := False;
  if AModelCliente.Excluir(ADtoCliente) then
    Result := True;
end;

function TRegraCliente.Inserir(const AModelCliente: TModelCliente;
  const ADtoCliente: TDtoCliente): Boolean;
begin
  Result := False;
  if AModelCliente.Inserir(ADtoCliente) then
    Result := True;
end;

function TRegraCliente.Listar(const AModel: TModelCliente): Boolean;
begin
  Result := False;
  if AModel.Listar then
    Result := True;
end;

function TRegraCliente.ValidarCNPJ(var ADtoCliente: TDtoCliente): Boolean;
var
  dig13, dig14: string;
  sm, i, r, peso: integer;
begin
  // length - retorna o tamanho da string do Cnpj (Cnpj é um número formado por 14 dígitos)
  if ((ADtoCliente.CpfCnpj = '00000000000000') or (ADtoCliente.CpfCnpj = '11111111111111') or
    (ADtoCliente.CpfCnpj = '22222222222222') or (ADtoCliente.CpfCnpj = '33333333333333') or
    (ADtoCliente.CpfCnpj = '44444444444444') or (ADtoCliente.CpfCnpj = '55555555555555') or
    (ADtoCliente.CpfCnpj = '66666666666666') or (ADtoCliente.CpfCnpj = '77777777777777') or
    (ADtoCliente.CpfCnpj = '88888888888888') or (ADtoCliente.CpfCnpj = '99999999999999') or
    (length(ADtoCliente.CpfCnpj) <> 14)) then
  begin
    Result := False;
    exit;
  end;

  // "try" - protege o código para eventuais erros de conversão de tipo através da função "StrToInt"
  try
    { *-- Cálculo do 1o. Digito Verificador --* }
    sm := 0;
    peso := 2;
    for i := 12 downto 1 do
    begin
      // StrToInt converte o i-ésimo caractere do ADtoCliente.CpfCnpj em um número
      sm := sm + (StrToInt(ADtoCliente.CpfCnpj[i]) * peso);
      peso := peso + 1;
      if (peso = 10) then
        peso := 2;
    end;
    r := sm mod 11;
    if ((r = 0) or (r = 1)) then
      dig13 := '0'
    else
      str((11 - r): 1, dig13); // converte um número no respectivo caractere numérico

    { *-- Cálculo do 2o. Digito Verificador --* }
    sm := 0;
    peso := 2;
    for i := 13 downto 1 do
    begin
      sm := sm + (StrToInt(ADtoCliente.CpfCnpj[i]) * peso);
      peso := peso + 1;
      if (peso = 10) then
        peso := 2;
    end;
    r := sm mod 11;
    if ((r = 0) or (r = 1)) then
      dig14 := '0'
    else
      str((11 - r): 1, dig14);

    { Verifica se os digitos calculados conferem com os digitos informados. }
    if ((dig13 = ADtoCliente.CpfCnpj[13]) and (dig14 = ADtoCliente.CpfCnpj[14])) then
      Result := True
    else
      Result := False;
  except
    Result := False
  end;
end;

function TRegraCliente.ValidarCPF(var ADtoCliente: TDtoCliente): Boolean;
var
  dig10, dig11: string;
  s, i, r, peso: integer;
begin
  // length - retorna o tamanho da string (ADtoCliente.CpfCnpj é um número formado por 11 dígitos)
  if ((ADtoCliente.CpfCnpj = '00000000000') or (ADtoCliente.CpfCnpj = '11111111111') or
    (ADtoCliente.CpfCnpj = '22222222222') or (ADtoCliente.CpfCnpj = '33333333333') or
    (ADtoCliente.CpfCnpj = '44444444444') or (ADtoCliente.CpfCnpj = '55555555555') or
    (ADtoCliente.CpfCnpj = '66666666666') or (ADtoCliente.CpfCnpj = '77777777777') or
    (ADtoCliente.CpfCnpj = '88888888888') or (ADtoCliente.CpfCnpj = '99999999999') or
    (length(ADtoCliente.CpfCnpj) <> 11)) then
  begin
    Result := False;
    exit;
  end;

  // try - protege o código para eventuais erros de conversão de tipo na função StrToInt
  try
    { *-- Cálculo do 1o. Digito Verificador --* }
    s := 0;
    peso := 10;
    for i := 1 to 9 do
    begin
      // StrToInt converte o i-ésimo caractere do ADtoCliente.CpfCnpj em um número
      s := s + (StrToInt(ADtoCliente.CpfCnpj[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11)) then
      dig10 := '0'
    else
      str(r: 1, dig10); // converte um número no respectivo caractere numérico

    { *-- Cálculo do 2o. Digito Verificador --* }
    s := 0;
    peso := 11;
    for i := 1 to 10 do
    begin
      s := s + (StrToInt(ADtoCliente.CpfCnpj[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11)) then
      dig11 := '0'
    else
      str(r: 1, dig11);

    { Verifica se os digitos calculados conferem com os digitos informados. }
    if ((dig10 = ADtoCliente.CpfCnpj[10]) and (dig11 = ADtoCliente.CpfCnpj[11])) then
      Result := True
    else
      Result := False;
  except
    Result := False
  end;
end;

function TRegraCliente.ValidarDados(var ADtoCliente: TDtoCliente): TCamposCliente;
begin
  // testa se o campo nome foi informado
  if ADtoCliente.Nome = EmptyStr then
  begin
    // se for vazio
    Result := resultNome;
    exit;
  end;
  // testa se, AO MENOS, telefone OU celular foi informado
  if (ADtoCliente.Celular = EmptyStr) and (ADtoCliente.Telefone = EmptyStr) then
  begin
    // se os dois estiverem vazios
    Result := resultCelularTelefone;
    exit;
  end;
  if ADtoCliente.Celular <> EmptyStr then
  begin
    if (length(ADtoCliente.Celular)) < 14 then
    begin
      // se celular tiver menos de 14 caracteres
      Result := resultCelular;
      exit;
    end;
  end;
  if ADtoCliente.Telefone <> EmptyStr then
  begin
    if length(ADtoCliente.Telefone) < 13 then
    begin
      // se celular tiver menos de 13 caracteres
      Result := resultTelefone;
      exit;
    end;
  end;
  // testa se CPF ou CNPJ foi informado
  if ADtoCliente.CpfCnpj <> EmptyStr then
  begin
    // se foi informado, realiza a validação
    if length(ADtoCliente.CpfCnpj) > 11 then
    begin
      if ValidarCNPJ(ADtoCliente) = False then
      begin
        Result := resultCpfCnpj;
        exit;
      end;
    end
    else
    begin
      if not(ValidarCPF(ADtoCliente)) then
      begin
        Result := resultCpfCnpj;
        exit;
      end;
    end;
  end;
  if ADtoCliente.DataNascimento <> EmptyStr then
  begin
    if length(ADtoCliente.DataNascimento) < 8 then
    begin
      // se data tiver menos de 8 caracteres
      Result := resultDataNascimento;
      exit;
    end;
  end;
  // testa se rua foi informada
  if (ADtoCliente.Rua = EmptyStr) then
  begin
    // se estiver vazio
    Result := resultRua;
    exit;
  end;
  // testa se número do endereço foi informado
  if (ADtoCliente.Numero = EmptyStr) then
  begin
    // se estiver vazios
    Result := resultNumero;
    exit;
  end;
  // testa se o estado foi selecionado
  if ADtoCliente.Estado = 0 then
  begin
    // se for vazio
    Result := resultEstado;
    exit;
  end;
  if ADtoCliente.Municipio = 0 then
  begin
    // se for vazio
    Result := resultMunicipio;
    exit;
  end;
  if ADtoCliente.Bairro = 0 then
  begin
    // se for vazio
    Result := resultBairro;
    exit;
  end;
  // caso não der erro nenhum retorna OK
  Result := resultOk;
end;

function TRegraCliente.VerificarCelularClienteCadastrado(const AModelCliente: TModelCliente;
  var ADtoCliente: TDtoCliente): Boolean;
begin
  Result := False;
  // testa se o nome informado para o Cliente já está cadastrado naquele município
  if AModelCliente.VerificarCelularClienteCadastrado(ADtoCliente) then
    Result := True;
end;

function TRegraCliente.VerificarTelefoneClienteCadastrado(const AModelCliente: TModelCliente;
  var ADtoCliente: TDtoCliente): Boolean;
begin
  Result := False;
  // testa se o nome informado para o Cliente já está cadastrado naquele município
  if AModelCliente.VerificarTelefoneClienteCadastrado(ADtoCliente) then
    Result := True;
end;

function TRegraCliente.VerificarTipoPessoa(const AModel: TModelCliente;
  var ADtoCliente: TDtoCliente): Boolean;
begin
  Result := False;
  if AModel.VerificarTipoPessoa(ADtoCliente) then
    Result := True;

end;

end.
