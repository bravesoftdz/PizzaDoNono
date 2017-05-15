unit uListagemBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmBasePadrao, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.WinXCtrls, dataModuleFuncoesGlobais;

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
    dbGridListagem: TDBGrid;
    SearchBox1: TSearchBox;
    Label1: TLabel;
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmListagemBase: TfrmListagemBase;

implementation

{$R *.dfm}

procedure TfrmListagemBase.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
