unit uListagemBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmBasePadrao, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids;

type
  TfrmListagemBase = class(TfrmBasePadrao)
    boxEditar: TPanel;
    imageEditar: TImage;
    labelEditar: TLabel;
    btnEditar: TSpeedButton;
    boxExcluir: TPanel;
    imageExcluir: TImage;
    labelExcluir: TLabel;
    btnExcluir: TSpeedButton;
    boxFechar: TPanel;
    imageFechar: TImage;
    labelFechar: TLabel;
    btnFechar: TSpeedButton;
    panelListagem: TPanel;
    Edit1: TEdit;
    DBGrid1: TDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmListagemBase: TfrmListagemBase;

implementation

{$R *.dfm}

end.
