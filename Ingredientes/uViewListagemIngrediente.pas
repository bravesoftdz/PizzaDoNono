unit uViewListagemIngrediente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uListagemBase, Data.DB, Vcl.StdCtrls,
  Vcl.WinXCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;

type
  TfrmListagemIngrediente = class(TfrmListagemBase)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmListagemIngrediente: TfrmListagemIngrediente;

implementation

{$R *.dfm}

end.
