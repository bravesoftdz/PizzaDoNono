program PizzadoNono;

{$R *.res}

uses
  Vcl.Forms,
  System.SysUtils,
  Controls,
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
  uViewCadastroCliente in 'Clientes\uViewCadastroCliente.pas' {frmCadastroCliente},
  uControllerCliente in 'Clientes\uControllerCliente.pas',
  uDtoCliente in 'Clientes\uDtoCliente.pas',
  uEnumeradorCamposCliente in 'Clientes\uEnumeradorCamposCliente.pas',
  uInterfaceModelCliente in 'Clientes\uInterfaceModelCliente.pas',
  uModelCliente in 'Clientes\uModelCliente.pas',
  uRegraCliente in 'Clientes\uRegraCliente.pas',
  uViewListagemCliente in 'Clientes\uViewListagemCliente.pas' {frmListagemCliente},
  uListaBairro in 'Bairros\uListaBairro.pas',
  uControllerTamanho in 'Tamanhos\uControllerTamanho.pas',
  uDtoTamanho in 'Tamanhos\uDtoTamanho.pas',
  uEnumeradorCamposTamanho in 'Tamanhos\uEnumeradorCamposTamanho.pas',
  uInterfaceModelTamanho in 'Tamanhos\uInterfaceModelTamanho.pas',
  uModelTamanho in 'Tamanhos\uModelTamanho.pas',
  uRegraTamanho in 'Tamanhos\uRegraTamanho.pas',
  uViewCadastroTamanho in 'Tamanhos\uViewCadastroTamanho.pas' {frmCadastroTamanho},
  uViewListagemTamanho in 'Tamanhos\uViewListagemTamanho.pas' {frmListagemTamanho},
  uControllerSabor in 'Sabores\uControllerSabor.pas',
  uDtoSabor in 'Sabores\uDtoSabor.pas',
  uEnumeradorCamposSabor in 'Sabores\uEnumeradorCamposSabor.pas',
  uInterfaceModelSabor in 'Sabores\uInterfaceModelSabor.pas',
  uModelSabor in 'Sabores\uModelSabor.pas',
  uRegraSabor in 'Sabores\uRegraSabor.pas',
  uViewCadastroSabor in 'Sabores\uViewCadastroSabor.pas' {frmCadastroSabor},
  uViewListagemSabor in 'Sabores\uViewListagemSabor.pas' {frmListagemSabor},
  uListaIngrediente in 'Ingredientes\uListaIngrediente.pas',
  uListaTamanho in 'Tamanhos\uListaTamanho.pas',
  uEnumeradorTipoPessoa in 'Clientes\uEnumeradorTipoPessoa.pas',
  uControllerProduto in 'Produto\uControllerProduto.pas',
  uDtoProduto in 'Produto\uDtoProduto.pas',
  uEnumeradorCamposProduto in 'Produto\uEnumeradorCamposProduto.pas',
  uInterfaceModelProduto in 'Produto\uInterfaceModelProduto.pas',
  uModelProduto in 'Produto\uModelProduto.pas',
  uRegraProduto in 'Produto\uRegraProduto.pas',
  uViewCadastroProduto in 'Produto\uViewCadastroProduto.pas' {frmCadastroProduto},
  uViewListagemProduto in 'Produto\uViewListagemProduto.pas' {frmListagemProduto},
  Vcl.Themes,
  Vcl.Styles,
  uListaSabor in 'Sabores\uListaSabor.pas',
  uEnumeradorTemSabor in 'Produto\uEnumeradorTemSabor.pas',
  uListaSaboresDisponiveis in 'Sabores\uListaSaboresDisponiveis.pas',
  uViewLogin in 'Login\uViewLogin.pas' {frmViewLogin},
  uControllerLogin in 'Login\uControllerLogin.pas',
  uDtoLogin in 'Login\uDtoLogin.pas',
  uModelLogin in 'Login\uModelLogin.pas',
  uRegraLogin in 'Login\uRegraLogin.pas',
  uEnumeradorCamposLogin in 'Login\uEnumeradorCamposLogin.pas',
  uSingletonLogin in 'Login\uSingletonLogin.pas',
  uControllerPedido in 'Pedidos\uControllerPedido.pas',
  uDtoPedido in 'Pedidos\uDtoPedido.pas',
  uEnumeradorCamposPedido in 'Pedidos\uEnumeradorCamposPedido.pas',
  uModelPedido in 'Pedidos\uModelPedido.pas',
  uRegraPedido in 'Pedidos\uRegraPedido.pas',
  uViewProduto in 'Pedidos\uViewProduto.pas' {frmViewProduto},
  uViewPedido in 'Pedidos\uViewPedido.pas' {frmViewPedido},
  uViewQuantidade in 'Pedidos\uViewQuantidade.pas' {frmQuantidade},
  uViewFinal in 'Pedidos\uViewFinal.pas' {frmFinal},
  uInterfaceModelPedido in 'Pedidos\uInterfaceModelPedido.pas',
  uListagemPedido in 'Pedidos\uListagemPedido.pas' {frmListagemPedido},
  uControllerPedidoProduto in 'Pedidos\uControllerPedidoProduto.pas',
  uRegraPedidoProduto in 'Pedidos\uRegraPedidoProduto.pas',
  uModelPedidoProduto in 'Pedidos\uModelPedidoProduto.pas',
  uInterfaceModelPedidoProduto in 'Pedidos\uInterfaceModelPedidoProduto.pas',
  uDtoPedidoProduto in 'Pedidos\uDtoPedidoProduto.pas';

{$R *.res}

var
  oControllerLogin: TControllerLogin;

begin

  Application.Initialize;
  oControllerLogin := TControllerLogin.Create;
  // Cria o form de login
  if oControllerLogin.oFormLogin.ShowModal = mrOk then // Caso o retorno da tela seja Ok

  begin

    FreeAndNil(oControllerLogin); // Libera o form de Login da memória

    Application.CreateForm(TfrmPrincipal, frmPrincipal);
  // Cria o mainform

    Application.Run; // Roda a aplicação

  end

  else // Caso o retorno da tela de Login seja mrCancel então

    Application.Terminate; // Encerra a aplicaçã0

end.
