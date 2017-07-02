unit uViewQuantidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmBasePadrao, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.CheckLst,
  Vcl.Buttons, Vcl.CategoryButtons, Vcl.WinXCtrls;

type
  TfrmQuantidade = class(TfrmBasePadrao)
    panelSeparador: TPanel;
    labelTitulo: TLabel;
    labelTamanho: TLabel;
    GroupBox1: TGroupBox;
    edtValor: TLabeledEdit;
    Label1: TLabel;
    ListBox1: TListBox;
    panelFormulario: TPanel;
    boxBotoes: TPanel;
    btnCancelar: TSpeedButton;
    labelValorTotalPedido: TLabel;
    edtValorTotalPedido: TEdit;
    cmbTamanho: TComboBox;
    edtQuantidade: TLabeledEdit;
    CheckListBoxSabores: TCheckListBox;
    Memo1: TMemo;
    Label2: TLabel;
    Label3: TLabel;
    btnConcluir: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmQuantidade: TfrmQuantidade;

implementation

{$R *.dfm}

end.
