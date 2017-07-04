unit uViewQuantidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Vcl.StdCtrls, Vcl.CheckLst, Vcl.ExtCtrls,
  Vcl.Buttons;

type
  TfrmViewQuantidade = class(TfrmCadastroBase)
    labelTamanho: TLabel;
    labelValorTotalPedido: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edtValor: TLabeledEdit;
    ListBox1: TListBox;
    edtValorTotalPedido: TEdit;
    cmbTamanho: TComboBox;
    edtQuantidade: TLabeledEdit;
    CheckListBoxSabores: TCheckListBox;
    Memo1: TMemo;
    BtnConfirmar: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmViewQuantidade: TfrmViewQuantidade;

implementation

{$R *.dfm}

end.
