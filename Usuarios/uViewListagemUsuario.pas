unit uViewListagemUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uListagemBase, Data.DB, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.WinXCtrls, dataModuleFuncoesGlobais, Datasnap.DBClient;

type
  TfrmListagemUsuario = class(TfrmListagemBase)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmListagemUsuario: TfrmListagemUsuario;

implementation

{$R *.dfm}

procedure TfrmListagemUsuario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  dmFuncoesGlobais.DestruirForm(frmListagemUsuario);
end;

end.
