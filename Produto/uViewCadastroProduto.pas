unit uViewCadastroProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Vcl.Buttons,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.WinXCtrls, Vcl.CheckLst;

type
  TfrmCadastroProduto = class(TfrmCadastroBase)
    edtIdCodigo: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtValor: TLabeledEdit;
    CheckListBoxSabores: TCheckListBox;
    labelSabores: TLabel;
    labelTemSabor: TLabel;
    cmbTemSabor: TComboBox;

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
