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
  uInterfaceModelUsuario in 'Usuarios\uInterfaceModelUsuario.pas',
  uViewCadastroIngrediente in 'Ingredientes\uViewCadastroIngrediente.pas' {frmCadastroIngrediente},
  uControllerIngrediente in 'Ingredientes\uControllerIngrediente.pas',
  uDtoIngrediente in 'Ingredientes\uDtoIngrediente.pas',
  uModelIngrediente in 'Ingredientes\uModelIngrediente.pas',
  uViewListagemIngrediente in 'Ingredientes\uViewListagemIngrediente.pas' {frmListagemIngrediente},
  uEnumeradorCamposIngrediente in 'Ingredientes\uEnumeradorCamposIngrediente.pas',
  uRegraIngrediente in 'Ingredientes\uRegraIngrediente.pas',
  uInterfaceModelIngrediente in 'Ingredientes\uInterfaceModelIngrediente.pas',
  uViewCadastroEstado in 'Estados\uViewCadastroEstado.pas' {frmCadastroEstado},
  uControllerEstado in 'Estados\uControllerEstado.pas',
  uDtoEstado in 'Estados\uDtoEstado.pas',
  uEnumeradorCamposEstado in 'Estados\uEnumeradorCamposEstado.pas',
  uInterfaceModelEstado in 'Estados\uInterfaceModelEstado.pas',
  uModelEstado in 'Estados\uModelEstado.pas',
  uRegraEstado in 'Estados\uRegraEstado.pas',
  uViewListagemEstado in 'Estados\uViewListagemEstado.pas' {frmListagemEstado},
  uViewCadastroMunicipio in 'Municipios\uViewCadastroMunicipio.pas' {frmCadastroMunicipio},
  uViewListagemMunicipio in 'Municipios\uViewListagemMunicipio.pas' {frmListagemMunicipio},
  uControllerMunicipio in 'Municipios\uControllerMunicipio.pas',
  uDtoMunicipio in 'Municipios\uDtoMunicipio.pas',
  uEnumeradorCamposMunicipio in 'Municipios\uEnumeradorCamposMunicipio.pas',
  uInterfaceModelMunicipio in 'Municipios\uInterfaceModelMunicipio.pas',
  uModelMunicipio in 'Municipios\uModelMunicipio.pas',
  uRegraMunicipio in 'Municipios\uRegraMunicipio.pas',
  uListaEstado in 'Estados\uListaEstado.pas',
  uViewCadastroBairro in 'Bairros\uViewCadastroBairro.pas' {frmCadastroBairro},
  uControllerBairro in 'Bairros\uControllerBairro.pas',
  uDtoBairro in 'Bairros\uDtoBairro.pas',
  uEnumeradorCamposBairro in 'Bairros\uEnumeradorCamposBairro.pas',
  uInterfaceModelBairro in 'Bairros\uInterfaceModelBairro.pas',
  uModelBairro in 'Bairros\uModelBairro.pas',
  uRegraBairro in 'Bairros\uRegraBairro.pas',
  uViewListagemBairro in 'Bairros\uViewListagemBairro.pas' {frmListagemBairro},
  uListaMunicipio in 'Municipios\uListaMunicipio.pas',
  uViewCadastroCliente in 'Clientes\uViewCadastroCliente.pas' {frmCadastroBase1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
