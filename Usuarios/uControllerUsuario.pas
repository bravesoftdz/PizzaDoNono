unit uControllerUsuario;

interface

uses
  System.Classes, System.SysUtils, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Dialogs,
  Vcl.Forms, Vcl.Buttons, Vcl.DBGrids, Data.DB,
  uInterfaceCRUD, uViewCadastroUsuario, uInterfaceRegra, uRegraUsuario,
  uModelUsuario, uDtoUsuario, uControllerCRUD, uEnumeradorCamposUsuario,
  uViewListagemUsuario;

type
  TControllerUsuario = class(TControllerCRUD)
  private
    oRegraUsuario: TRegraUsuario;
    oModelUsuario: TModelUsuario;
    oDtoUsuario: TDtoUsuario;
    oDataSource: TDataSource;
    procedure BuscarMaiorID;
    procedure PreencherDTO;
    procedure LimparDto(var ADtoUsuario: TDtoUsuario);
    procedure PreencherGrid(var DbGrid: TDBGrid);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Salvar(ASender: TObject); override;
    procedure Cancelar(ASender: TObject); override;
    procedure Localizar(aOwner: TComponent); override;
    procedure Novo(ASender: TObject); override;
    procedure Editar(ASender: TObject); override;
    procedure CriarFormCadastro(aOwner: TComponent); override;
    procedure FecharFormCadastro(ASender: TObject); override;
    procedure FecharFormListagem(ASender: TObject); override;
  end;

var
  oControllerUsuario: TControllerUsuario;

implementation

{ TControllerUsuario }

procedure TControllerUsuario.Cancelar(ASender: TObject);
begin
  inherited;
end;

constructor TControllerUsuario.Create;
begin
  if not(Assigned(oDtoUsuario)) then
    oDtoUsuario := TDtoUsuario.Create;

  if not(Assigned(oRegraUsuario)) then
    oRegraUsuario := TRegraUsuario.Create;

  if not(Assigned(oModelUsuario)) then
    oModelUsuario := TModelUsuario.Create;

  if not(Assigned(oDataSource)) then
    oDataSource := TDataSource.Create(nil);

end;

procedure TControllerUsuario.CriarFormCadastro(aOwner: TComponent);
begin
  if not(Assigned(oFormularioCadastro)) then
    oFormularioCadastro := TfrmUsuario.Create(aOwner);

  oFormularioCadastro.iInterfaceCrud := oControllerUsuario;
  inherited;
end;

destructor TControllerUsuario.Destroy;
begin
  if Assigned(oDtoUsuario) then
    FreeAndNil(oDtoUsuario);

  if Assigned(oRegraUsuario) then
    FreeAndNil(oRegraUsuario);

  if Assigned(oModelUsuario) then
    FreeAndNil(oModelUsuario);

  if Assigned(oDataSource) then
    FreeAndNil(oDataSource);

  inherited;
end;

procedure TControllerUsuario.Editar(ASender: TObject);
begin
  inherited;
  //
end;

procedure TControllerUsuario.FecharFormCadastro(ASender: TObject);
begin
  inherited;
end;

procedure TControllerUsuario.FecharFormListagem(ASender: TObject);
begin
  inherited;
end;

procedure TControllerUsuario.BuscarMaiorID;
begin
  if oModelUsuario.BuscarMaiorID(oDtoUsuario) then
    TfrmUsuario(oFormularioCadastro).edtIdCodigo.Text :=
      IntToStr(oDtoUsuario.IdUsuario + 1);
end;

procedure TControllerUsuario.LimparDto(var ADtoUsuario: TDtoUsuario);
begin
  ADtoUsuario.IdUsuario := 0;
  ADtoUsuario.Nome := EmptyStr;
  ADtoUsuario.Senha := EmptyStr;
  ADtoUsuario.ConfirmaSenha := EmptyStr;
end;

procedure TControllerUsuario.Localizar(aOwner: TComponent);
begin
  if not(Assigned(TfrmListagemUsuario(oFormularioListagem))) then
    TfrmListagemUsuario(oFormularioListagem) :=
      TfrmListagemUsuario.Create(aOwner);

  TfrmListagemUsuario(oFormularioListagem).iInterfaceCrud := oControllerUsuario;

  PreencherGrid(TfrmListagemUsuario(oFormularioListagem).dbGridListagem);
  inherited;
end;

procedure TControllerUsuario.Novo(ASender: TObject);
begin
  inherited;
  BuscarMaiorID;
  TfrmUsuario(oFormularioCadastro).edtNome.SetFocus;
end;

procedure TControllerUsuario.Salvar(ASender: TObject);
begin
  PreencherDTO;

  case oRegraUsuario.ValidarDados(oDtoUsuario) of
    resultNome:
      TfrmUsuario(oFormularioCadastro).edtNome.SetFocus;
    resultSenha:
      TfrmUsuario(oFormularioCadastro).edtSenha.SetFocus;
    resultConfirmaSenha:
      begin
        TfrmUsuario(oFormularioCadastro).edtConfirmaSenha.Text := EmptyStr;
        TfrmUsuario(oFormularioCadastro).edtConfirmaSenha.SetFocus;
      end;
    resultOk:
      begin
        if oModelUsuario.Inserir(oDtoUsuario) then
        begin
          AjustarModoInsercao(False);
          LimparFormulario;
          LimparDto(oDtoUsuario);
        end;
      end;
  end;
end;

procedure TControllerUsuario.PreencherDTO;
begin
  oDtoUsuario.IdUsuario := StrToInt(TfrmUsuario(oFormularioCadastro)
    .edtIdCodigo.Text);
  oDtoUsuario.Nome := Trim(TfrmUsuario(oFormularioCadastro).edtNome.Text);
  oDtoUsuario.Senha := Trim(TfrmUsuario(oFormularioCadastro).edtSenha.Text);
  oDtoUsuario.ConfirmaSenha :=
    Trim(TfrmUsuario(oFormularioCadastro).edtConfirmaSenha.Text);
end;

procedure TControllerUsuario.PreencherGrid(var DbGrid: TDBGrid);
begin

  if oModelUsuario.Listar then
  begin
    oDataSource.DataSet := oModelUsuario.oQuery;
    TfrmListagemUsuario(oFormularioListagem).dbGridListagem.DataSource :=
      oDataSource;
  end;
end;

end.
