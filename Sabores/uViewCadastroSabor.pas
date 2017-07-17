unit uViewCadastroSabor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Vcl.Buttons,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.CheckLst, Vcl.Mask, Vcl.ComCtrls, Vcl.WinXCtrls;

type
  TfrmCadastroSabor = class(TfrmCadastroBase)
    edtIdCodigo: TLabeledEdit;
    Ingredientes: TLabel;
    labelTamanho: TLabel;
    edtNome: TLabeledEdit;
    cmbTamanho: TComboBox;
    edtValor: TLabeledEdit;
    CheckListBoxIngredientes: TCheckListBox;
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
