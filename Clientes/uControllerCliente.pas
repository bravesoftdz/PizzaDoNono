unit uControllerCliente;

interface

uses
  System.Classes, System.SysUtils, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Dialogs,
  Vcl.Forms, Vcl.Buttons, Vcl.DBGrids, Data.DB, System.Generics.Collections, System.UITypes,
  uInterfaceCRUD, uInterfaceRegra, uControllerCRUD, uDtoCliente, uModelCliente, uRegraCliente,
  uViewCadastroCliente, uViewListagemCliente, uEnumeradorCamposCliente, uDtoMunicipio,
  uModelMunicipio, uListaMunicipio, uDtoEstado, uDtoBairro;

type
  TControllerCliente = class(TControllerCRUD)
  private
    oRegraCliente: TRegraCliente;
    oModelCliente: TModelCliente;
    oDtoCliente: TDtoCliente;
    procedure PreencherDTO;
    procedure LimparDto(var ADtoCliente: TDtoCliente);
    procedure PreencherGrid(var DbGrid: TDBGrid);

    procedure AjustarEditCpfCnpj(ASender: TOBject);
    procedure AtualizarComboBoxMunicipio(Sender: TOBject);

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

  TfrmCadastroCliente(oFormularioCadastro).radioCPF.OnClick := AjustarEditCpfCnpj;
  TfrmCadastroCliente(oFormularioCadastro).radioCPF.OnExit := AjustarEditCpfCnpj;
  TfrmCadastroCliente(oFormularioCadastro).radioCNPJ.OnClick := AjustarEditCpfCnpj;
  TfrmCadastroCliente(oFormularioCadastro).radioCNPJ.OnExit := AjustarEditCpfCnpj;
  TfrmCadastroCliente(oFormularioCadastro).cmbBairro.OnKeyPress := OnExitUltimoCampo;
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
var
  nomeMunicipio: string;
begin
  inherited;
  // resgatando dados da linha selecionada no DBGrid
  // resgatando IdCliente e setando no Edit
  TfrmCadastroCliente(oFormularioCadastro).edtIdCodigo.Text :=
    oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('ID').AsString;

  // resgatando Nome do Cliente e setando no Edit
  TfrmCadastroCliente(oFormularioCadastro).edtNome.Text :=
    oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('Nome').AsString;

  // resgatando nome do municipio - precisa ser feito antes de buscar o estado
  nomeMunicipio := oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName
    ('município').AsString;

  { para listar o municipio no ComboBox, é necessário ter o estado listado
    no ComboBox do estado }
  // buscando estado do municipio do Cliente
  PreencherDTO;
  if oRegraCliente.BuscarEstado(oModelCliente, oDtoCliente) then
  begin
    TfrmCadastroCliente(oFormularioCadastro).cmbEstado.ItemIndex :=
      TfrmCadastroCliente(oFormularioCadastro).cmbEstado.Items.IndexOfObject
      (TOBject(oDtoCliente.Estado));
  end;

  AtualizarComboBoxMunicipio(nil);
  // setando municicipio no ComboBox a partir do nome
  TfrmCadastroCliente(oFormularioCadastro).cmbMunicipio.ItemIndex :=
    TfrmCadastroCliente(oFormularioCadastro).cmbMunicipio.Items.IndexOf(nomeMunicipio);

  FecharFormListagem(oFormularioListagem);

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

procedure TControllerCliente.AjustarEditCpfCnpj(ASender: TOBject);
begin
  if TfrmCadastroCliente(oFormularioCadastro).radioCPF.Checked then
  begin
    TfrmCadastroCliente(oFormularioCadastro).labelCPF.Enabled := true;
    TfrmCadastroCliente(oFormularioCadastro).edtCPF.Enabled := true;

    TfrmCadastroCliente(oFormularioCadastro).labelCNPJ.Enabled := False;
    TfrmCadastroCliente(oFormularioCadastro).edtCNPJ.Enabled := False;
  end;
  if TfrmCadastroCliente(oFormularioCadastro).radioCNPJ.Checked then
  begin
    TfrmCadastroCliente(oFormularioCadastro).labelCPF.Enabled := False;
    TfrmCadastroCliente(oFormularioCadastro).edtCPF.Enabled := False;

    TfrmCadastroCliente(oFormularioCadastro).labelCNPJ.Enabled := True;
    TfrmCadastroCliente(oFormularioCadastro).edtCNPJ.Enabled := true;
  end;
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
  AjustarEditCpfCnpj(nil);
end;

procedure TControllerCliente.AtualizarComboBoxMunicipio(Sender: TOBject);
var
  oListaMunicipio: TListaMunicipio;
  oModelMunicipio: TModelMunicipio;
  oDtoMunicipio: TDtoMunicipio;
  oDtoBairro: TDtoBairro;
begin
  TfrmCadastroCliente(oFormularioCadastro).cmbMunicipio.ItemIndex := -1;
  TfrmCadastroCliente(oFormularioCadastro).cmbMunicipio.Items.Clear;
  TfrmCadastroCliente(oFormularioCadastro).cmbMunicipio.Text := '';
  PreencherDTO;
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

procedure TControllerCliente.LimparDto(var ADtoCliente: TDtoCliente);
begin
  ADtoCliente.idCliente := 0;
  ADtoCliente.Estado := 0;
  ADtoCliente.Municipio := 0;
  ADtoCliente.Nome := EmptyStr;
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
    resultOk:
      begin
        // testa se o edit do ID está vazio
        if oDtoCliente.idCliente = 0 then
        begin
          // se o ID for vazio, testa se o nome informado ja esta cadastrado
          if oRegraCliente.VerificarClienteCadastrado(oModelCliente, oDtoCliente) then
          begin
            ShowMessage('Já existe um Cliente com o nome "' + UpperCase(oDtoCliente.Nome) +
              '" associado ao estado selecionado.');
            TfrmCadastroCliente(oFormularioCadastro).edtNome.SetFocus;
          end
          else
          // se o nome informado nao estiver cadastrado, realiza a inserção
          begin
            // testa se a inserção foi realizada
            if oRegraCliente.Inserir(oModelCliente, oDtoCliente) then
            begin
              // se a inserção for realizada
              AjustarModoInsercao(False);
              LimparFormulario;
              LimparDto(oDtoCliente);
            end;
          end;
        end
        else
        // se o edit de ID nao estiver vazio, fazer UPDATE
        begin
          if oRegraCliente.VerificarClienteCadastrado(oModelCliente, oDtoCliente) then
          begin
            ShowMessage('Já existe um Cliente com o nome "' + UpperCase(oDtoCliente.Nome) +
              '" associado ao municipio selecionado.');
            TfrmCadastroCliente(oFormularioCadastro).edtNome.SetFocus;
          end
          else
          // se o nome informado nao estiver cadastrado, realiza a alteracao
          begin
            // testa se a inserção foi realizada
            if oRegraCliente.Editar(oModelCliente, oDtoCliente) then
            begin
              // se a alteração for realizada
              AjustarModoInsercao(False);
              LimparFormulario;
              LimparDto(oDtoCliente);
            end;
          end;
        end;
      end;
  end;
end;

procedure TControllerCliente.PreencherDTO;
begin
  if TfrmCadastroCliente(oFormularioCadastro).edtIdCodigo.Text <> '' then
    oDtoCliente.idCliente := StrToInt(TfrmCadastroCliente(oFormularioCadastro).edtIdCodigo.Text)
  else
    oDtoCliente.idCliente := 0;

  oDtoCliente.Nome := Trim(TfrmCadastroCliente(oFormularioCadastro).edtNome.Text);

  if TfrmCadastroCliente(oFormularioCadastro).cmbEstado.ItemIndex > -1 then
  begin
    oDtoCliente.Estado := Integer(TfrmCadastroCliente(oFormularioCadastro).cmbEstado.Items.Objects
      [TfrmCadastroCliente(oFormularioCadastro).cmbEstado.ItemIndex]);
  end;

  if TfrmCadastroCliente(oFormularioCadastro).cmbMunicipio.ItemIndex > -1 then
  begin
    oDtoCliente.Municipio := Integer(TfrmCadastroCliente(oFormularioCadastro)
      .cmbMunicipio.Items.Objects[TfrmCadastroCliente(oFormularioCadastro).cmbMunicipio.ItemIndex]);
  end;
end;

procedure TControllerCliente.PreencherGrid(var DbGrid: TDBGrid);
begin

  if oModelCliente.Listar then
  begin
    oDataSource.DataSet := oModelCliente.oQuery;
    TfrmListagemCliente(oFormularioListagem).dbGridListagem.DataSource := oDataSource;
  end;
  AjustarListagem;
end;

end.
