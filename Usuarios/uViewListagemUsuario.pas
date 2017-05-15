unit uViewListagemUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Datasnap.DBClient, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons,
  Vcl.Imaging.pngimage, System.Generics.Collections, Vcl.ExtCtrls,
  Vcl.WinXCtrls,
  dataModuleFuncoesGlobais, uListagemBase, uControllerUsuario,
  uListaHashUsuario;

type
  TfrmListagemUsuario = class(TfrmListagemBase)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    oControllerUsuario: TControllerUsuario;

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
  if assigned(oControllerUsuario) then
    FreeAndNil(oControllerUsuario);


  dmFuncoesGlobais.DestruirForm(frmListagemUsuario);
end;

procedure TfrmListagemUsuario.FormCreate(Sender: TObject);
begin
  inherited;
  if not(assigned(oControllerUsuario)) then
    oControllerUsuario := TControllerUsuario.Create();


  oControllerUsuario.Listar(dbGridListagem);
end;

end.
