unit uCadastroBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmBasePadrao, Vcl.Buttons,
  Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

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
    Image5: TImage;
    Label5: TLabel;
    btnSalvar: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroBase: TfrmCadastroBase;

implementation

{$R *.dfm}

end.
