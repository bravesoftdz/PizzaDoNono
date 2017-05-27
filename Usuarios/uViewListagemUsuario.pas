unit uViewListagemUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Datasnap.DBClient, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons,
  Vcl.Imaging.pngimage, System.Generics.Collections, Vcl.ExtCtrls,
  Vcl.WinXCtrls,
  uListagemBase;

type
  TfrmListagemUsuario = class(TfrmListagemBase)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    //oControllerUsuario: TControllerUsuario;

  public
    { Public declarations }
  end;

var
  frmListagemUsuario: TfrmListagemUsuario;

implementation

{$R *.dfm}

procedure TfrmListagemUsuario.FormCreate(Sender: TObject);
begin
//  inherited;
//  if not(assigned(oControllerUsuario)) then
//    oControllerUsuario := TControllerUsuario.Create();
//
//   //oControllerUsuario.NovaColuna(dbGridListagem, 'IDUsuario', 'IDUsuario', 0);
//   //oControllerUsuario.NovaColuna(dbGridListagem, 'Nome', 'Nome', 1, 200);
//   //oControllerUsuario.NovaColuna(dbGridListagem, 'Senha', 'Senha', 2, 100);
//
//  oControllerUsuario.Listar(dbGridListagem);
end;

end.
