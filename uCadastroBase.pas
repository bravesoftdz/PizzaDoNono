unit uCadastroBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Buttons, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  uFrmBasePadrao, uInterfaceCRUD, Vcl.CheckLst;

type
  TfrmCadastroBase = class(TfrmBasePadrao)
    btnNovo: TSpeedButton;
    btnLocalizar: TSpeedButton;
    btnFechar: TSpeedButton;
    panelFormulario: TPanel;
    boxBotoes: TPanel;
    btnCancelar: TSpeedButton;
    btnSalvar: TSpeedButton;
    labelTitulo: TLabel;
    panelSeparador: TPanel;
    procedure btnFecharClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnLocalizarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    iInterfaceCrud: ICrud;

  end;

var
  frmCadastroBase: TfrmCadastroBase;

implementation

{$R *.dfm}

procedure TfrmCadastroBase.btnCancelarClick(Sender: TObject);
begin
  inherited;
  iInterfaceCrud.Cancelar(Sender);
end;

procedure TfrmCadastroBase.btnFecharClick(Sender: TObject);
begin
  inherited;
  iInterfaceCrud.FecharFormCadastro(Sender);
end;

procedure TfrmCadastroBase.btnLocalizarClick(Sender: TObject);
begin
  inherited;
  iInterfaceCrud.Localizar(Self);
end;

procedure TfrmCadastroBase.btnNovoClick(Sender: TObject);
begin
  inherited;
  iInterfaceCrud.Novo(Sender);
end;

procedure TfrmCadastroBase.btnSalvarClick(Sender: TObject);
begin
  inherited;
  iInterfaceCrud.Salvar(Sender);
end;

procedure TfrmCadastroBase.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if btnSalvar.Tag = 1 then
  begin
    if Key = #10 then
    begin
      iInterfaceCrud.Salvar(Sender);
    end;
  end;
end;

end.
