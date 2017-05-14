unit uViewUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Buttons, Vcl.Imaging.pngimage,
  uDtoUsuario, uControllerUsuario, dataModuleFuncoesGlobais;

type
  TfrmUsuario = class(TfrmCadastroBase)
    edtNome: TLabeledEdit;
    edtIdCodigo: TLabeledEdit;
    edtSenha: TLabeledEdit;
    edtConfirmaSenha: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSalvarClick(Sender: TObject);
  private
    { Private declarations }

    oControllerUsuario: TControllerUsuario;

    oDtoUsuario: TDtoUsuario;
  public
    { Public declarations }

  end;

var
  frmUsuario: TfrmUsuario;

implementation

{$R *.dfm}
{ TfrmUsuarios }

procedure TfrmUsuario.btnSalvarClick(Sender: TObject);
begin
  inherited;
  oDtoUsuario.IdUsuario := 2;
  oDtoUsuario.Nome := edtNome.Text;
  oDtoUsuario.Senha := edtSenha.Text;
  oDtoUsuario.ConfirmaSenha := edtSenha.Text;
  oControllerUsuario.Salvar(oDtoUsuario);
end;

procedure TfrmUsuario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  if Assigned(oControllerUsuario) then
    FreeAndNil(oControllerUsuario);

  if Assigned(oDtoUsuario) then
    FreeAndNil(oDtoUsuario);
end;

procedure TfrmUsuario.FormCreate(Sender: TObject);
begin
  inherited;
  if not(Assigned(oDtoUsuario)) then
    oDtoUsuario := TDtoUsuario.Create;

  if not(Assigned(oControllerUsuario)) then
    oControllerUsuario := TControllerUsuario.Create;
end;

end.
