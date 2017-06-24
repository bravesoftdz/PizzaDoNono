unit uViewCadastroSabor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Vcl.Buttons,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.CheckLst;

type
  TfrmCadastroSabor = class(TfrmCadastroBase)
    edtIdCodigo: TLabeledEdit;
    edtNome: TLabeledEdit;
    Ingredientes: TLabel;
    CheckListBoxIngredientes: TCheckListBox;
    edtValor: TLabeledEdit;
    cmbTamanho: TComboBox;
    labelTamanho: TLabel;
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
