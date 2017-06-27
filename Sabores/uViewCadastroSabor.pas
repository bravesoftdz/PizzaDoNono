unit uViewCadastroSabor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Vcl.Buttons,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.CheckLst, Vcl.Mask;

type
  TfrmCadastroSabor = class(TfrmCadastroBase)
    edtIdCodigo: TLabeledEdit;
    Ingredientes: TLabel;
    labelTamanho: TLabel;
    edtNome: TLabeledEdit;
    cmbTamanho: TComboBox;
    edtValor: TLabeledEdit;
    CheckListBoxIngredientes: TCheckListBox;
    MaskEdit1: TMaskEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroSabor: TfrmCadastroSabor;

implementation

{$R *.dfm}

end.
