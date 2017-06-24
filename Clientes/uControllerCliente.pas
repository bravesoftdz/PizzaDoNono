unit uControllerCliente;

interface

uses
  System.Classes, System.SysUtils, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Dialogs, MaskUtils,
  Vcl.Forms, Vcl.Buttons, Vcl.DBGrids, Data.DB, System.Generics.Collections, System.UITypes,
  uInterfaceCRUD, uInterfaceRegra, uControllerCRUD, uDtoCliente, uModelCliente, uRegraCliente,
  uViewCadastroCliente, uViewListagemCliente, uEnumeradorCamposCliente, uDtoMunicipio,
  uModelMunicipio, uListaMunicipio, uDtoEstado, uDtoBairro, uModelBairro, uListaBairro,
  uRegraBairro, uEnumeradorTipoPessoa;

type
  TControllerCliente = class(TControllerCRUD)
  private
    oRegraCliente: TRegraCliente;
    oModelCliente: TModelCliente;
    oDtoCliente: TDtoCliente;
    procedure PreencherDTO;
    procedure LimparDto;
    procedure PreencherGrid(var DbGrid: TDBGrid);
    procedure AtualizarComboBoxMunicipio(Sender: TOBject);
    procedure AtualizarComboBoxBairro(Sender: TOBject);
  public
    constructor Create; override;
    destructor Destroy; override;

    procedure Salvar(ASender: TOBject); override;
    procedure Cancelar(ASender: TOBject); override;
    procedure Localizar(aOwner: TComponent); override;
    procedure Novo(ASender: TOBject); override;
    procedure Editar(Sender: TOBject); override;
    procedure Excluir; override;
    procedure CriarFormCadastro(aOwner: TComponent); override;
    procedure FecharFormCadastro(ASender: TOBject); override;
    procedure FecharFormListagem(ASender: TOBject); override;
    procedure AjustarModoInsercao(AStatusBtnSalvar: Boolean); override;
    procedure AjustarListagem; override;
  end;

var
  oControllerCliente: TControllerCliente;

implementation

{ TControllerUsuario }

procedure TControllerCliente.Cancelar(ASender: TOBject);
begin
  inherited;
end;

constructor TControllerCliente.Create;
begin
  inherited;

  if not(Assigned(oDtoCliente)) then
    oDtoCliente := TDtoCliente.Create;

  if not(Assigned(oRegraCliente)) then
    oRegraCliente := TRegraCliente.Create;

  if not(Assigned(oModelCliente)) then
    oModelCliente := TModelCliente.Create;
end;

procedure TControllerCliente.CriarFormCadastro(aOwner: TComponent);
begin
  if not(Assigned(oFormularioCadastro)) then
    oFormularioCadastro := TfrmCadastroCliente.Create(aOwner);

  oFormularioCadastro.iInterfaceCrud := oControllerCliente;

  ListarEstados(TfrmCadastroCliente(oFormularioCadastro).cmbEstado);

  TfrmCadastroCliente(oFormularioCadastro).cmbEstado.OnChange := AtualizarComboBoxMunicipio;

  TfrmCadastroCliente(oFormularioCadastro).cmbMunicipio.OnChange := AtualizarComboBoxBairro;
  inherited;
end;

destructor TControllerCliente.Destroy;
begin
  if Assigned(oDtoCliente) then
    FreeAndNil(oDtoCliente);

  if Assigned(oRegraCliente) then
    FreeAndNil(oRegraCliente);

  if Assigned(oModelCliente) then
    FreeAndNil(oModelCliente);
  inherited;
end;

procedure TControllerCliente.Editar(Sender: TOBject);
begin
  inherited;
  // resgatando dados da linha selecionada no DBGrid
  oDtoCliente.idCliente := oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName
    ('ID').AsInteger;
  // resgatando IdCliente e setando no Edit
  TfrmCadastroCliente(oFormularioCadastro).edtIdCodigo.Text :=
    oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('ID').AsString;

  // resgatando Nome do Cliente e setando no Edit
  TfrmCadastroCliente(oFormularioCadastro).edtNome.Text :=
    oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('Nome').AsString;

  // resgatando celular do Cliente e setando no Edit
  TfrmCadastroCliente(oFormularioCadastro).edtCelular.Text :=
    oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('Celular').AsString;

  // resgatando Telefone do Cliente e setando no Edit
  TfrmCadastroCliente(oFormularioCadastro).edtTelefone.Text :=
    oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('Telefone').AsString;

  // resgatando Data de Nascimento do Cliente e setando no Edit
  TfrmCadastroCliente(oFormularioCadastro).edtDataNascimento.Text :=
    oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName
    ('Data de Nascimento').AsString;

  oDtoCliente.CpfCnpj := oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName
    ('CPF/CNPJ').AsString;
  if oDtoCliente.CpfCnpj <> '' then
  begin
    if oRegraCliente.VerificarTipoPessoa(oModelCliente, oDtoCliente) then
    begin
      TfrmCadastroCliente(oFormularioCadastro).edtCpfCnpj.Text := oDtoCliente.CpfCnpj;
      if oDtoCliente.TipoPessoa = resultPessoaFisica then
      begin
        TfrmCadastroCliente(oFormularioCadastro).labelCpfCnpj.Caption := 'CPF:';
        TfrmCadastroCliente(oFormularioCadastro).edtCpfCnpj.EditMask := '999.999.999-99;1;_';
      end
      else if oDtoCliente.TipoPessoa = resultPessoaJuridica then
      begin
        TfrmCadastroCliente(oFormularioCadastro).labelCpfCnpj.Caption := 'CNPJ:';
        TfrmCadastroCliente(oFormularioCadastro).edtCpfCnpj.EditMask := '99.999.999/9999-99;1;_';
      end;
    end;
  end;

  FecharFormListagem(oFormularioListagem);

  if oRegraCliente.BuscarEnderecoCliente(oModelCliente, oDtoCliente) then
  begin
    TfrmCadastroCliente(oFormularioCadastro).edtRua.Text := oDtoCliente.Rua;
    TfrmCadastroCliente(oFormularioCadastro).edtNumero.Text := oDtoCliente.Numero;
    TfrmCadastroCliente(oFormularioCadastro).edtComplemento.Text := oDtoCliente.Complemento;
  end;

  { para listar o municipio no ComboBox, é necessário ter o estado selecoinado
    no ComboBox do estado }
  // buscando estado do municipio do Cliente
  if oRegraCliente.BuscarBairro(oModelCliente, oDtoCliente) then
  begin
    TfrmCadastroCliente(oFormularioCadastro).cmbEstado.ItemIndex :=
      TfrmCadastroCliente(oFormularioCadastro).cmbEstado.Items.IndexOfObject
      (TOBject(oDtoCliente.Estado));

    AtualizarComboBoxMunicipio(nil);

    TfrmCadastroCliente(oFormularioCadastro).cmbMunicipio.ItemIndex :=
      TfrmCadastroCliente(oFormularioCadastro).cmbMunicipio.Items.IndexOfObject
      (TOBject(oDtoCliente.Municipio));

    AtualizarComboBoxBairro(nil);

    TfrmCadastroCliente(oFormularioCadastro).cmbBairro.ItemIndex :=
      TfrmCadastroCliente(oFormularioCadastro).cmbBairro.Items.IndexOfObject
      (TOBject(oDtoCliente.Bairro));
  end;


  AjustarModoInsercao(true);
end;

procedure TControllerCliente.Excluir;
begin
  inherited;
  // resgatando idCliente do DBGrid e setando no DTO
  oDtoCliente.idCliente := oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName
    ('ID').AsInteger;

  if MessageDlg('Deseja realmente excluir?', mtConfirmation, mbYesNo, 0) = mrYes then
  begin
    if oRegraCliente.Excluir(oModelCliente, oDtoCliente) then
    begin
      PreencherGrid(oFormularioListagem.dbGridListagem);
      ShowMessage('Registro excluído com sucesso.');
    end
    else
    begin
      PreencherGrid(oFormularioListagem.dbGridListagem);
      ShowMessage('Não foi possível excluir.');
    end;
  end

end;

procedure TControllerCliente.FecharFormCadastro(ASender: TOBject);
begin
  inherited;
end;

procedure TControllerCliente.FecharFormListagem(ASender: TOBject);
begin
  inherited;
end;

procedure TControllerCliente.AjustarListagem;
begin
  if not(oRegraCliente.CountRegistros(oModelCliente)) then
    inherited;
end;

procedure TControllerCliente.AjustarModoInsercao(AStatusBtnSalvar: Boolean);
begin
  inherited;
  if AStatusBtnSalvar then
    TfrmCadastroCliente(oFormularioCadastro).edtNome.SetFocus;
  if not(AStatusBtnSalvar) then
  begin
    TfrmCadastroCliente(oFormularioCadastro).edtCpfCnpj.EditMask := '99999999999999;0; ';
    TfrmCadastroCliente(oFormularioCadastro).labelCpfCnpj.Caption := 'CPF/CNPJ:';
  end;
end;

procedure TControllerCliente.AtualizarComboBoxBairro(Sender: TOBject);
var
  oListaBairro: TListaBairro;
  oModelBairro: TModelBairro;
  oRegraBairro: TRegraBairro;
  oDtoBairro: TDtoBairro;
begin
  TfrmCadastroCliente(oFormularioCadastro).cmbBairro.ItemIndex := -1;
  TfrmCadastroCliente(oFormularioCadastro).cmbBairro.Items.Clear;
  TfrmCadastroCliente(oFormularioCadastro).cmbBairro.Text := '';
  PreencherDTO;
  oModelBairro := TModelBairro.Create;
  try
    oListaBairro := TListaBairro.Create([doOwnsValues]);
    oRegraBairro := TRegraBairro.Create;
    if oRegraBairro.ListarBairros(oModelBairro, oDtoCliente, oListaBairro) then
    begin
      for oDtoBairro in oListaBairro.Values do
        TfrmCadastroCliente(oFormularioCadastro).cmbBairro.Items.AddObject(oDtoBairro.Nome,
          TOBject(oDtoBairro.idBairro));
    end;
  finally

    if Assigned(oListaBairro) then
      FreeAndNil(oListaBairro);

    if Assigned(oModelBairro) then
      FreeAndNil(oModelBairro);

    if Assigned(oRegraBairro) then
      FreeAndNil(oRegraBairro);

  end;
end;

procedure TControllerCliente.AtualizarComboBoxMunicipio(Sender: TOBject);
var
  oListaMunicipio: TListaMunicipio;
  oModelMunicipio: TModelMunicipio;
  oDtoMunicipio: TDtoMunicipio;
  oDtoBairro: TDtoBairro;
begin
  // zerando combobox de bairros
  TfrmCadastroCliente(oFormularioCadastro).cmbBairro.ItemIndex := -1;
  TfrmCadastroCliente(oFormularioCadastro).cmbBairro.Items.Clear;
  TfrmCadastroCliente(oFormularioCadastro).cmbBairro.Text := '';

  // zerando combobox de municipios
  TfrmCadastroCliente(oFormularioCadastro).cmbMunicipio.ItemIndex := -1;
  TfrmCadastroCliente(oFormularioCadastro).cmbMunicipio.Items.Clear;
  TfrmCadastroCliente(oFormularioCadastro).cmbMunicipio.Text := '';
  PreencherDTO;
  // ID Estado
  if TfrmCadastroCliente(oFormularioCadastro).cmbEstado.ItemIndex > -1 then
  begin
    oDtoCliente.Estado := Integer(TfrmCadastroCliente(oFormularioCadastro).cmbEstado.Items.Objects
      [TfrmCadastroCliente(oFormularioCadastro).cmbEstado.ItemIndex]);
  end;
  oModelMunicipio := TModelMunicipio.Create;
  try
    oListaMunicipio := TListaMunicipio.Create([doOwnsValues]);
    oDtoBairro := TDtoBairro.Create;
    oDtoBairro.Estado := oDtoCliente.Estado;
    if oModelMunicipio.ListarMunicipios(oListaMunicipio, oDtoBairro) then
    begin
      for oDtoMunicipio in oListaMunicipio.Values do
        TfrmCadastroCliente(oFormularioCadastro).cmbMunicipio.Items.AddObject(oDtoMunicipio.Nome,
          TOBject(oDtoMunicipio.IdMunicipio));
    end
  finally
    if Assigned(oDtoBairro) then
      FreeAndNil(oDtoBairro);

    if Assigned(oModelMunicipio) then
      oModelMunicipio.Free;

    if Assigned(oListaMunicipio) then
      FreeAndNil(oListaMunicipio);


  end;
end;

procedure TControllerCliente.LimparDto();
begin
  oDtoCliente.idCliente := 0;
  oDtoCliente.Nome := EmptyStr;
  oDtoCliente.CpfCnpj := EmptyStr;
  oDtoCliente.Telefone := EmptyStr;
  oDtoCliente.Celular := EmptyStr;
  oDtoCliente.DataNascimento := EmptyStr;
  oDtoCliente.IdEndereço := 0;
  oDtoCliente.Bairro := 0;
  oDtoCliente.Rua := EmptyStr;
  oDtoCliente.Numero := EmptyStr;
  oDtoCliente.Complemento := EmptyStr;
  oDtoCliente.Estado := 0;
  oDtoCliente.Municipio := 0;
  oDtoCliente.TipoPessoa := resultVazio;

end;

procedure TControllerCliente.Localizar(aOwner: TComponent);
begin
  if not(Assigned(TfrmListagemCliente(oFormularioListagem))) then
    TfrmListagemCliente(oFormularioListagem) := TfrmListagemCliente.Create(aOwner);

  TfrmListagemCliente(oFormularioListagem).iInterfaceCrud := oControllerCliente;

  PreencherGrid(TfrmListagemCliente(oFormularioListagem).dbGridListagem);
  inherited;
end;

procedure TControllerCliente.Novo(ASender: TOBject);
begin
  inherited;
end;

procedure TControllerCliente.Salvar(ASender: TOBject);
begin
  PreencherDTO;

  case oRegraCliente.ValidarDados(oDtoCliente) of
    resultNome:
      begin
        ShowMessage('Informe o nome do Cliente.');
        TfrmCadastroCliente(oFormularioCadastro).edtNome.SetFocus;
      end;
    resultCelularTelefone:
      begin
        ShowMessage('Preencha pelo menos um dos campos de Telefone ou Celular.');
        TfrmCadastroCliente(oFormularioCadastro).edtTelefone.SetFocus;
      end;
    resultCelular:
      begin
        ShowMessage('O número de celular informado é invalido.');
        TfrmCadastroCliente(oFormularioCadastro).edtCelular.SetFocus;
      end;
    resultTelefone:
      begin
        ShowMessage('O número de telefone informado é invalido.');
        TfrmCadastroCliente(oFormularioCadastro).edtTelefone.SetFocus;
      end;
    resultCpfCnpj:
      begin
        ShowMessage('CPF ou CNPJ inválido. Verifique e tente novamente.');
        TfrmCadastroCliente(oFormularioCadastro).edtCpfCnpj.SetFocus;
      end;
    resultDataNascimento:
      begin
        ShowMessage('A data de nascimento informada é inválida. ' + #13 +
          'Obs.: O ano deve conter quatro(4) caracteres. Ex.: 2017');
        TfrmCadastroCliente(oFormularioCadastro).edtCpfCnpj.SetFocus;
      end;
    resultRua:
      begin
        ShowMessage('Informe o nome da Rua.');
        TfrmCadastroCliente(oFormularioCadastro).edtRua.SetFocus;
      end;
    resultNumero:
      begin
        ShowMessage('Informe o numero do endereço de entrega.');
        TfrmCadastroCliente(oFormularioCadastro).edtNumero.SetFocus;
      end;
    resultEstado:
      begin
        ShowMessage('Selecione o Estado.');
        TfrmCadastroCliente(oFormularioCadastro).cmbEstado.SetFocus;
      end;
    resultMunicipio:
      begin
        ShowMessage('Selecione o Município.');
        TfrmCadastroCliente(oFormularioCadastro).cmbMunicipio.SetFocus;
      end;
    resultBairro:
      begin
        ShowMessage('Selecione o Bairro.');
        TfrmCadastroCliente(oFormularioCadastro).cmbBairro.SetFocus;
      end;
    resultOk:
      begin
        // testa se o edit do ID está vazio
        if oDtoCliente.idCliente = 0 then
        begin
          // se o ID for vazio, testa se o nome informado ja esta cadastrado
          if oRegraCliente.VerificarTelefoneClienteCadastrado(oModelCliente, oDtoCliente) then
          begin
            ShowMessage('Já existe um Cliente cadastrado com o Telefone informado.');
            TfrmCadastroCliente(oFormularioCadastro).edtTelefone.SetFocus;
          end
          else if oRegraCliente.VerificarCelularClienteCadastrado(oModelCliente, oDtoCliente) then
          begin
            ShowMessage('Já existe um Cliente cadastrado com o Celular informado.');
            TfrmCadastroCliente(oFormularioCadastro).edtCelular.SetFocus;
          end
          else
          // se o celular ou telefone informado nao estiver cadastrado, realiza a inserção
          begin
            // testa se a inserção foi realizada
            if oRegraCliente.Inserir(oModelCliente, oDtoCliente) then
            begin
              // se a inserção for realizada
              AjustarModoInsercao(False);
              LimparFormulario;
              LimparDto;
            end;
          end;
        end
        else
        // se o edit de ID nao estiver vazio, fazer UPDATE
        begin
          if oRegraCliente.VerificarTelefoneClienteCadastrado(oModelCliente, oDtoCliente) then
          begin
            ShowMessage('Já existe um Cliente cadastrado com o Telefone informado.');
            TfrmCadastroCliente(oFormularioCadastro).edtTelefone.SetFocus;
          end
          else if oRegraCliente.VerificarCelularClienteCadastrado(oModelCliente, oDtoCliente) then
          begin
            ShowMessage('Já existe um Cliente cadastrado com o Celular informado.');
            TfrmCadastroCliente(oFormularioCadastro).edtCelular.SetFocus;
          end
          else
          // se o nome informado nao estiver cadastrado, realiza a alteracao
          begin
            // testa se a alteração foi realizada
            if oRegraCliente.Editar(oModelCliente, oDtoCliente) then
            begin
              // se a alteração for ok
              AjustarModoInsercao(False);
              LimparFormulario;
              LimparDto;
            end;
          end;
        end;
      end;
  end;
end;

procedure TControllerCliente.PreencherDTO;
begin
  // ID
  if TfrmCadastroCliente(oFormularioCadastro).edtIdCodigo.Text <> '' then
    oDtoCliente.idCliente := StrToInt(TfrmCadastroCliente(oFormularioCadastro).edtIdCodigo.Text)
  else
    oDtoCliente.idCliente := 0;
  // Nome
  oDtoCliente.Nome := Trim(TfrmCadastroCliente(oFormularioCadastro).edtNome.Text);
  // Telefone
  oDtoCliente.Telefone := Trim(TfrmCadastroCliente(oFormularioCadastro).edtTelefone.Text);
  // Celular
  oDtoCliente.Celular := Trim(TfrmCadastroCliente(oFormularioCadastro).edtCelular.Text);
  // CPF/CNPJ
  oDtoCliente.CpfCnpj := Trim(TfrmCadastroCliente(oFormularioCadastro).edtCpfCnpj.Text);
  // Data de Nascimento
  oDtoCliente.DataNascimento := Trim(TfrmCadastroCliente(oFormularioCadastro)
    .edtDataNascimento.Text);
  // Rua
  oDtoCliente.Rua := Trim(TfrmCadastroCliente(oFormularioCadastro).edtRua.Text);
  // Número
  oDtoCliente.Numero := Trim(TfrmCadastroCliente(oFormularioCadastro).edtNumero.Text);
  // Complemento
  oDtoCliente.Complemento := Trim(TfrmCadastroCliente(oFormularioCadastro).edtComplemento.Text);
  // ID Estado
  if TfrmCadastroCliente(oFormularioCadastro).cmbEstado.ItemIndex > -1 then
  begin
    oDtoCliente.Estado := Integer(TfrmCadastroCliente(oFormularioCadastro).cmbEstado.Items.Objects
      [TfrmCadastroCliente(oFormularioCadastro).cmbEstado.ItemIndex]);
  end;
  // ID Município
  if (TfrmCadastroCliente(oFormularioCadastro).cmbMunicipio.ItemIndex > -1) and
    (TfrmCadastroCliente(oFormularioCadastro).cmbMunicipio.Text <> '') then
  begin
    oDtoCliente.Municipio := Integer(TfrmCadastroCliente(oFormularioCadastro)
      .cmbMunicipio.Items.Objects[TfrmCadastroCliente(oFormularioCadastro).cmbMunicipio.ItemIndex]);
  end;
  // ID Bairro
  if TfrmCadastroCliente(oFormularioCadastro).cmbBairro.ItemIndex > -1 then
  begin
    oDtoCliente.Bairro := Integer(TfrmCadastroCliente(oFormularioCadastro).cmbBairro.Items.Objects
      [TfrmCadastroCliente(oFormularioCadastro).cmbBairro.ItemIndex]);
  end;
  // tipo Pessoa (CPF ou CNPJ)
  if oDtoCliente.CpfCnpj <> EmptyStr then
  begin
    if Length(oDtoCliente.CpfCnpj) = 11 then
      oDtoCliente.TipoPessoa := resultPessoaFisica
    else if Length(oDtoCliente.CpfCnpj) = 14 then
      oDtoCliente.TipoPessoa := resultPessoaJuridica;
  end
  else
    oDtoCliente.TipoPessoa := resultVazio;

end;

procedure TControllerCliente.PreencherGrid(var DbGrid: TDBGrid);
begin

  if oRegraCliente.Listar(oModelCliente) then
  begin
    oDataSource.DataSet := oModelCliente.oQuery;
    TfrmListagemCliente(oFormularioListagem).dbGridListagem.DataSource := oDataSource;
  end;
  AjustarListagem;
end;

end.
