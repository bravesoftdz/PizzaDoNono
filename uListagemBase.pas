unit uListagemBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmBasePadrao, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.WinXCtrls, uInterfaceCRUD;

type
  TfrmListagemBase = class(TfrmBasePadrao)
    BoxBotoes: TPanel;
    btnEditar: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnFechar: TSpeedButton;
    panelListagem: TPanel;
    SearchBox1: TSearchBox;
    Label1: TLabel;
    dbGridListagem: TDBGrid;
    procedure btnFecharClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    iInterfaceCrud: ICrud;
  end;

var
  frmListagemBase: TfrmListagemBase;

implementation

{$R *.dfm}

procedure TfrmListagemBase.btnEditarClick(Sender: TObject);
begin
  inherited;
  iInterfaceCrud.Editar;
end;

procedure TfrmListagemBase.btnExcluirClick(Sender: TObject);
begin
  inherited;
  iInterfaceCrud.Excluir;
end;

procedure TfrmListagemBase.btnFecharClick(Sender: TObject);
begin
  inherited;
  iInterfaceCrud.FecharFormListagem(Sender);
end;

end.
