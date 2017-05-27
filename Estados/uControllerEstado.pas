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
    procedure BuscarMaiorID;
    procedure PreencherDTO;
    procedure LimparDto(var ADtoEstado: TDtoEstado);
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
  oControllerEstado: TControllerEstado;

implementation

{ TControllerEstado }

procedure TControllerEstado.Cancelar(ASender: TObject);
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

procedure TControllerEstado.Editar(ASender: TObject);
begin
  inherited;
  //
end;

procedure TControllerEstado.FecharFormCadastro(ASender: TObject);
begin
  inherited;
end;

procedure TControllerEstado.FecharFormListagem(ASender: TObject);
begin
  inherited;
end;

procedure TControllerEstado.BuscarMaiorID;
begin
  if oModelEstado.BuscarMaiorID(oDtoEstado) then
    TfrmCadastroEstado(oFormularioCadastro).edtIdCodigo.Text :=
      IntToStr(oDtoEstado.IdEstado + 1);
end;

procedure TControllerEstado.LimparDto(var ADtoEstado: TDtoEstado);
begin
  ADtoEstado.IdEstado := 0;
  ADtoEstado.Nome := EmptyStr;
  ADtoEstado.UF := EmptyStr;
end;

procedure TControllerEstado.Localizar(aOwner: TComponent);
begin
  if not(Assigned(TfrmListagemEstado(oFormularioListagem))) then
    TfrmListagemEstado(oFormularioListagem) :=
      TfrmListagemEstado.Create(aOwner);

  TfrmListagemEstado(oFormularioListagem).iInterfaceCrud := oControllerEstado;

  PreencherGrid(TfrmListagemEstado(oFormularioListagem).dbGridListagem);
  inherited;
end;

procedure TControllerEstado.Novo(ASender: TObject);
begin
  inherited;
  BuscarMaiorID;
  TfrmCadastroEstado(oFormularioCadastro).edtUF.SetFocus;
end;

procedure TControllerEstado.Salvar(ASender: TObject);
begin
  PreencherDTO;

  case oRegraEstado.ValidarDados(oDtoEstado) of
    resultNome:
      TfrmCadastroEstado(oFormularioCadastro).edtNome.SetFocus;
    resultUF:
      TfrmCadastroEstado(oFormularioCadastro).edtUF.SetFocus;
    resultOk:
      begin
        if oModelEstado.Inserir(oDtoEstado) then
        begin
          AjustarModoInsercao(False);
          LimparFormulario;
          LimparDto(oDtoEstado);
        end;
      end;
  end;
end;

procedure TControllerEstado.PreencherDTO;
begin
  oDtoEstado.IdEstado := StrToInt(TfrmCadastroEstado(oFormularioCadastro)
    .edtIdCodigo.Text);
  oDtoEstado.Nome := Trim(TfrmCadastroEstado(oFormularioCadastro).edtNome.Text);
  oDtoEstado.UF := Trim(TfrmCadastroEstado(oFormularioCadastro).edtUF.Text);

end;

procedure TControllerEstado.PreencherGrid(var DbGrid: TDBGrid);
begin

  if oModelEstado.Listar then
  begin
    oDataSource.DataSet := oModelEstado.oQuery;
    TfrmListagemEstado(oFormularioListagem).dbGridListagem.DataSource :=
      oDataSource;
  end;
end;

end.
