program PizzadoNono;

uses
  Vcl.Forms,
  uFrmBasePadrao in 'uFrmBasePadrao.pas' {frmBasePadrao},
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uListagemBase in 'uListagemBase.pas' {frmListagemBase},
  uCadastroBase in 'uCadastroBase.pas' {frmCadastroBase},
  uClassConnection in 'uClassConnection.pas',
  uClassDBConnectionSingleton in 'uClassDBConnectionSingleton.pas',
  uControllerUsuario in 'Usuarios\uControllerUsuario.pas',
  uDtoUsuario in 'Usuarios\uDtoUsuario.pas',
  uModelUsuario in 'Usuarios\uModelUsuario.pas',
  uViewCadastroUsuario in 'Usuarios\uViewCadastroUsuario.pas' {frmUsuario},
  uViewListagemUsuario in 'Usuarios\uViewListagemUsuario.pas' {frmListagemUsuario},
  uInterfaceCRUD in 'uInterfaceCRUD.pas',
  uRegraUsuario in 'Usuarios\uRegraUsuario.pas',
  uControllerCRUD in 'uControllerCRUD.pas',
  uEnumeradorCamposUsuario in 'Usuarios\uEnumeradorCamposUsuario.pas',
  uInterfaceModelUsuario in 'Usuarios\uInterfaceModelUsuario.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
