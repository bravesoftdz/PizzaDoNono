unit uControllerIngrediente;

interface

uses
  System.Classes, System.SysUtils, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Dialogs,
  Vcl.Forms, Vcl.Buttons, Vcl.DBGrids, Data.DB,
  uInterfaceCRUD, uInterfaceRegra, uControllerCRUD, uDtoIngrediente,
  uModelIngrediente, uRegraIngrediente, uViewCadastroIngrediente,
  uViewListagemIngrediente, uEnumeradorCamposIngrediente;

type
  TControllerIngrediente = class(TControllerCRUD)
  private
    oRegraIngrediente: TRegraIngrediente;
    oModelIngrediente: TModelIngrediente;
    oDtoIngrediente: TDtoIngrediente;
    procedure BuscarMaiorID;
    procedure PreencherDTO;
    procedure LimparDto(var ADtoIngrediente: TDtoIngrediente);
    procedure PreencherGrid(var DbGrid: TDBGrid);
  public
    constructor Create; override;
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
  oControllerIngrediente: TControllerIngrediente;

implementation

{ TControllerUsuario }

procedure TControllerIngrediente.Cancelar(ASender: TObject);
begin
  inherited;
end;

constructor TControllerIngrediente.Create;
begin
  inherited;

  if not(Assigned(oDtoIngrediente)) then
    oDtoIngrediente := TDtoIngrediente.Create;

  if not(Assigned(oRegraIngrediente)) then
    oRegraIngrediente := TRegraIngrediente.Create;

  if not(Assigned(oModelIngrediente)) then
    oModelIngrediente := TModelIngrediente.Create;
end;

procedure TControllerIngrediente.CriarFormCadastro(aOwner: TComponent);
begin
  if not(Assigned(oFormularioCadastro)) then
    oFormularioCadastro := TfrmCadastroIngrediente.Create(aOwner);

  oFormularioCadastro.iInterfaceCrud := oControllerIngrediente;

  inherited;
end;

destructor TControllerIngrediente.Destroy;
begin
  if Assigned(oDtoIngrediente) then
    FreeAndNil(oDtoIngrediente);

  if Assigned(oRegraIngrediente) then
    FreeAndNil(oRegraIngrediente);

  if Assigned(oModelIngrediente) then
    FreeAndNil(oModelIngrediente);

  inherited;
end;

procedure TControllerIngrediente.Editar(ASender: TObject);
begin
  inherited;
  //
end;

procedure TControllerIngrediente.FecharFormCadastro(ASender: TObject);
begin
  inherited;
end;

procedure TControllerIngrediente.FecharFormListagem(ASender: TObject);
begin
  inherited;
end;

procedure TControllerIngrediente.BuscarMaiorID;
begin
  if oModelIngrediente.BuscarMaiorID(oDtoIngrediente) then
    TfrmCadastroIngrediente(oFormularioCadastro).edtIdCodigo.Text :=
      IntToStr(oDtoIngrediente.IdIngrediente + 1);
end;

procedure TControllerIngrediente.LimparDto(var ADtoIngrediente
  : TDtoIngrediente);
begin
  ADtoIngrediente.IdIngrediente := 0;
  ADtoIngrediente.Descricao := EmptyStr;
end;

procedure TControllerIngrediente.Localizar(aOwner: TComponent);
begin
  if not(Assigned(TfrmListagemIngrediente(oFormularioListagem))) then
    TfrmListagemIngrediente(oFormularioListagem) :=
      TfrmListagemIngrediente.Create(aOwner);

  TfrmListagemIngrediente(oFormularioListagem).iInterfaceCrud :=
    oControllerIngrediente;

  PreencherGrid(TfrmListagemIngrediente(oFormularioListagem).dbGridListagem);
  inherited;
end;

procedure TControllerIngrediente.Novo(ASender: TObject);
begin
  inherited;
  BuscarMaiorID;
  TfrmCadastroIngrediente(oFormularioCadastro).edtDescricao.SetFocus;
end;

procedure TControllerIngrediente.Salvar(ASender: TObject);
begin
  PreencherDTO;

  case oRegraIngrediente.ValidarDados(oDtoIngrediente) of
    resultDescricao:
      TfrmCadastroIngrediente(oFormularioCadastro).edtDescricao.SetFocus;
    resultOk:
      begin
        if oModelIngrediente.Inserir(oDtoIngrediente) then
        begin
          AjustarModoInsercao(False);
          LimparFormulario;
          LimparDto(oDtoIngrediente);
        end;
      end;
  end;
end;

procedure TControllerIngrediente.PreencherDTO;
begin
  oDtoIngrediente.IdIngrediente :=
    StrToInt(TfrmCadastroIngrediente(oFormularioCadastro).edtIdCodigo.Text);
  oDtoIngrediente.Descricao := Trim(TfrmCadastroIngrediente(oFormularioCadastro)
    .edtDescricao.Text);

end;

procedure TControllerIngrediente.PreencherGrid(var DbGrid: TDBGrid);
begin

  if oModelIngrediente.Listar then
  begin
    oDataSource.DataSet := oModelIngrediente.oQuery;
    TfrmListagemIngrediente(oFormularioListagem).dbGridListagem.DataSource :=
      oDataSource;
  end;
end;

end.
