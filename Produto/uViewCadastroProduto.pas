unit uViewCadastroProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Vcl.Buttons,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmCadastroProduto = class(TfrmCadastroBase)
    edtIdCodigo: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtValor: TLabeledEdit;
    Label1: TLabel;
    RadioSaborSim: TRadioButton;
    RadioSaborNao: TRadioButton;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroProduto: TfrmCadastroProduto;

implementation

{$R *.dfm}

end.
