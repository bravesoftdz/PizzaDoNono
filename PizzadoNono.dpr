program PizzadoNono;

uses
  Vcl.Forms,
  uFrmBasePadrao in 'uFrmBasePadrao.pas' {frmBasePadrao},
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uListagemBase in 'uListagemBase.pas' {frmListagemBase},
  uCadastroBase in 'uCadastroBase.pas' {frmBasePadrao1},
  uClassConnection in 'uClassConnection.pas',
  uClassDBConnectionSingleton in 'uClassDBConnectionSingleton.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  AApplication.CreateForm(TfrmPrincipal, frmPrincipal);
  AApplication.CreateForm(TfrmListagemBase, frmListagemBase);
  AApplication.CreateForm(TfrmBasePadrao1, frmBasePadrao1);
  lication.Run;
end.
