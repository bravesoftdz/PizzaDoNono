unit uControllerEstado;

interface

uses
  System.Classes, System.SysUtils, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Dialogs,
  Vcl.Forms, Vcl.Buttons, Vcl.DBGrids, Data.DB,
  uInterfaceCRUD, uViewCadastroEstado, uInterfaceRegra, uRegraEstado,
  uModelEstado, uDtoEstado, uControllerCRUD, uEnumeradorCamposEstado,
  uViewListagemEstado;

type
  TControllerEstado = class(TControllerCRUD)
  private
    oRegraEstado: TRegraEstado;
    oModelEstado: TModelEstado;
    oDtoEstado: TDtoEstado;
    procedure PreencherDTO;
    procedure LimparDto(var ADtoEstado: TDtoEstado);
    procedure PreencherGrid(var DbGrid: TDBGrid);
  public
    constructor Create; override;
    destructor Destroy; override;

    procedure Salvar(ASender: TObject); override;
    procedure Cancelar(ASender: TObject); override;
    procedure Localizar(aOwner: TComponent); override;
    procedure Novo(ASender: TObject); override;
    procedure Editar; override;
    procedure CriarFormCadastro(aOwner: TComponent); override;
    procedure FecharFormCadastro(ASender: TObject); override;
    procedure FecharFormListagem(ASender: TObject); override;
  end;

var
  oControllerEstado: TControllerEstado;

implementation

{ TControllerEstado }

procedure TControllerEstado.Cancelar;
begin
  inherited;
end;

constructor TControllerEstado.Create;
begin
  if not(Assigned(oDtoEstado)) then
    oDtoEstado := TDtoEstado.Create;

  if not(Assigned(oRegraEstado)) then
    oRegraEstado := TRegraEstado.Create;

  if not(Assigned(oModelEstado)) then
    oModelEstado := TModelEstado.Create;
  inherited;
end;

procedure TControllerEstado.CriarFormCadastro(aOwner: TComponent);
begin
  if not(Assigned(oFormularioCadastro)) then
    oFormularioCadastro := TfrmCadastroEstado.Create(aOwner);

  oFormularioCadastro.iInterfaceCrud := oControllerEstado;
  inherited;
end;

destructor TControllerEstado.Destroy;
begin
  if Assigned(oDtoEstado) then
    FreeAndNil(oDtoEstado);

  if Assigned(oRegraEstado) then
    FreeAndNil(oRegraEstado);

  if Assigned(oModelEstado) then
    FreeAndNil(oModelEstado);

  inherited;
end;

procedure TControllerEstado.Editar;
begin
  inherited;
  // resgatando dados da linha selecionada no DBGrid
  // resgatando IdEstado e setando no Edit
  TfrmCadastroEstado(oFormularioCadastro).edtIdCodigo.Text :=
    oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('ID').AsString;

  // resgatando Nome do estado e setando no Edit
  TfrmCadastroEstado(oFormularioCadastro).edtNome.Text :=
    oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('Nome').AsString;

  // resgatando UF do estado e setando no Edit
  TfrmCadastroEstado(oFormularioCadastro).edtUF.Text :=
    oFormularioListagem.dbGridListagem.SelectedField.DataSet.FieldByName('UF').AsString;

  FecharFormListagem(oFormularioListagem);

  AjustarModoInsercao(true);
end;

procedure TControllerEstado.FecharFormCadastro(ASender: TObject);
begin
  inherited;
end;

procedure TControllerEstado.FecharFormListagem(ASender: TObject);
begin
  inherited;
end;

procedure TControllerEstado.LimparDto(var ADtoEstado: TDtoEstado);
begin
  ADtoEstado.IdEstado := 0;
  ADtoEstado.Nome := EmptyStr;
  ADtoEstado.UF := EmptyStr;
end;

procedure TControllerEstado.Localizar;
begin
  if not(Assigned(TfrmListagemEstado(oFormularioListagem))) then
    TfrmListagemEstado(oFormularioListagem) := TfrmListagemEstado.Create(aOwner);

  TfrmListagemEstado(oFormularioListagem).iInterfaceCrud := oControllerEstado;

  PreencherGrid(TfrmListagemEstado(oFormularioListagem).dbGridListagem);
  inherited;
end;

procedure TControllerEstado.Novo;
begin
  inherited;
  TfrmCadastroEstado(oFormularioCadastro).edtUF.SetFocus;
end;

procedure TControllerEstado.Salvar;
begin
  PreencherDTO;

  case oRegraEstado.ValidarDados(oDtoEstado) of
    resultNome:
      begin
        showMessage('Preencha o campo Nome.');
        TfrmCadastroEstado(oFormularioCadastro).edtNome.SetFocus;
      end;
    resultUF:
      begin
        showMessage('Preencha o campo UF.');
        TfrmCadastroEstado(oFormularioCadastro).edtUF.SetFocus;
      end;
    resultOk:
      // se resultar ok, interage com Banco de Dados
      begin
        // testa se o nome ou UF informado ja esta cadastrado
        case oRegraEstado.VerificarEstadoCadastrado(oModelEstado, oDtoEstado) of
          resultNome:
            begin
              showMessage('J� existe um estado cadastrado com o nome "' +
                UpperCase(oDtoEstado.Nome) + '".');
              TfrmCadastroEstado(oFormularioCadastro).edtNome.SetFocus;
            end;
          resultUF:
            begin
              showMessage('J� existe um estado cadastrado com a UF "' +
                UpperCase(oDtoEstado.UF) + '".');
              TfrmCadastroEstado(oFormularioCadastro).edtUF.SetFocus;
            end;
          resultOk:
            // se o nome ou UF informado nao estiver cadastrado, realiza a inser��o
            begin
              // testa se o edit do ID est� vazio
              if oDtoEstado.IdEstado = 0 then
              begin
                // se o id for igual a 0, realiza inser��o
                // testa se a inser��o foi realizada
                if oRegraEstado.Inserir(oModelEstado, oDtoEstado) then
                begin
                  // se a inser��o for realizada
                  AjustarModoInsercao(False);
                  LimparFormulario;
                  LimparDto(oDtoEstado);
                end;
              end
              else if oDtoEstado.IdEstado > 0 then
              begin
                // se o nome informado nao estiver cadastrado, realiza a inser��o
                // testa se o Update foi realizado
                if oRegraEstado.Editar(oModelEstado, oDtoEstado) then
                begin
                  // se a altera��o for realizada
                  AjustarModoInsercao(False);
                  LimparFormulario;
                  LimparDto(oDtoEstado);
                end;
              end;
            end;
        end; // end case verificarEstadoCadastrado
      end;
  end; // end case validarDados
end;

procedure TControllerEstado.PreencherDTO;
begin
  if TfrmCadastroEstado(oFormularioCadastro).edtIdCodigo.Text <> '' then
    oDtoEstado.IdEstado := StrToInt(TfrmCadastroEstado(oFormularioCadastro).edtIdCodigo.Text)
  else
    oDtoEstado.IdEstado := 0;

  oDtoEstado.Nome := Trim(TfrmCadastroEstado(oFormularioCadastro).edtNome.Text);
  oDtoEstado.UF := Trim(TfrmCadastroEstado(oFormularioCadastro).edtUF.Text);

end;

procedure TControllerEstado.PreencherGrid(var DbGrid: TDBGrid);
begin

  if oModelEstado.Listar then
  begin
    oDataSource.DataSet := oModelEstado.oQuery;
    TfrmListagemEstado(oFormularioListagem).dbGridListagem.DataSource := oDataSource;
  end;
end;

end.
