program PizzadoNono;

uses
  Vcl.Forms,
  uFrmBasePadrao in 'uFrmBasePadrao.pas' {frmBasePadrao},
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uFrameBotao in 'uFrameBotao.pas' {FrameBotao: TFrame},
  uListagemBase in 'uListagemBase.pas' {frmListagemBase};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmListagemBase, frmListagemBase);
  Application.Run;
end.
