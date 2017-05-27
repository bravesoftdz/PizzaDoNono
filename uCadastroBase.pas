unit uCadastroBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Buttons, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  uFrmBasePadrao, uInterfaceCRUD;

type
  TfrmCadastroBase = class(TfrmBasePadrao)
    boxPedido: TPanel;
    Image1: TImage;
    Label1: TLabel;
    btnNovo: TSpeedButton;
    boxLocalizar: TPanel;
    Image2: TImage;
    Label2: TLabel;
    btnLocalizar: TSpeedButton;
    boxFechar: TPanel;
    Image4: TImage;
    Label4: TLabel;
    btnFechar: TSpeedButton;
    panelFormulario: TPanel;
    boxCancelar: TPanel;
    Image3: TImage;
    Label3: TLabel;
    btnCancelar: TSpeedButton;
    boxSalvar: TPanel;
    Label5: TLabel;
    btnSalvar: TSpeedButton;
    labelTitulo: TLabel;
    panelSeparador: TPanel;
    procedure btnFecharClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnLocalizarClick(Sender: TObject);
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

end.
