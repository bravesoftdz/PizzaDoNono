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
    function VerificarClienteCadastrado(var ADtoCliente: TDtoCliente): Boolean;
    function Excluir(const ADtoCliente: TDtoCliente): Boolean;
  end;

implementation

end.
