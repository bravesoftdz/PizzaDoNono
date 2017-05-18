unit uCadastroBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmBasePadrao, Vcl.Buttons,
  Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  dataModuleFuncoesGlobais;

type
  TfrmCadastroBase = class(TfrmBasePadrao)
    btnNovo: TSpeedButton;
    btnLocalizar: TSpeedButton;
    btnFechar: TSpeedButton;
    panelFormulario: TPanel;
    btnCancelar: TSpeedButton;
    btnSalvar: TSpeedButton;
    labelTitulo: TLabel;
    panelSeparador: TPanel;
    Panel1: TPanel;

    procedure btnFecharClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroBase: TfrmCadastroBase;

implementation

{$R *.dfm}

procedure TfrmCadastroBase.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
