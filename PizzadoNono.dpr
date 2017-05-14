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
  uViewUsuario in 'Usuarios\uViewUsuario.pas' {frmUsuario},
  dataModuleFuncoesGlobais in 'dataModuleFuncoesGlobais.pas' {dmFuncoesGlobais: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmFuncoesGlobais, dmFuncoesGlobais);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
