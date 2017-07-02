unit uViewProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmBasePadrao, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls,
  Data.DB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.WinXCtrls, uInterfaceCRUD;

type
  TfrmViewProduto = class(TfrmBasePadrao)
    panelListagem: TPanel;
    dbGridListagem: TDBGrid;
    BoxBotoes: TPanel;
    LabelFiltro: TLabel;
    btnFechar: TSpeedButton;
    Label1: TLabel;
    SearchBoxCodigo: TSearchBox;
    SearchBoxNome: TSearchBox;
    panelSeparador: TPanel;
    labelTitulo: TLabel;
    procedure btnFecharClick(Sender: TObject);
  private

    iIntefaceCrud: ICrud;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmViewProduto: TfrmViewProduto;

implementation

{$R *.dfm}

procedure TfrmViewProduto.btnFecharClick(Sender: TObject);
begin
  inherited;
  iIntefaceCrud.FecharFormCadastro(Sender);
end;

end.
