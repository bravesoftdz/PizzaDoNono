unit uInterfaceModelCliente;

interface

uses
  FireDAC.Comp.Client,
  uDtoCliente;

type
  IModelCliente = interface
    function Inserir(const oDtoCliente: TDtoCliente): Boolean;
    function Editar(const oDtoCliente: TDtoCliente): Boolean;
    function Listar: Boolean;
    function VerificarCelularClienteCadastrado(var ADtoCliente: TDtoCliente): Boolean;
    function VerificarTelefoneClienteCadastrado(var ADtoCliente: TDtoCliente): Boolean;
    function BuscarBairro(var ADtoCliente: TDtoCliente): Boolean;
    function Excluir(const ADtoCliente: TDtoCliente): Boolean;
    function CountRegistros: integer;
    function VerificarTipoPessoa(var ADtoCliente: TDtoCliente): Boolean;
    function BuscarEnderecoCliente(var ADtoCliente: TDtoCliente): Boolean;
  end;

implementation

end.
