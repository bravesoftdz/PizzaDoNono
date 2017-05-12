program PizzadoNono;

uses
  Vcl.Forms,
  uFrmBasePadrao in 'uFrmBasePadrao.pas' {frmBasePadrao},
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uListagemBase in 'uListagemBase.pas' {frmListagemBase},
  uCadastroBase in 'uCadastroBase.pas' {frmCadastroBase},
  uClassConnection in 'uClassConnection.pas',
  uClassDBConnectionSingleton in 'uClassDBConnectionSingleton.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmListagemBase, frmListagemBase);
  Application.CreateForm(TfrmCadastroBase, frmCadastroBase);
  Application.Run;
end.
