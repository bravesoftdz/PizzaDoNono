unit uInterfaceModelUsuario;

interface

uses
  FireDAC.Comp.Client,
  uDtoUsuario;

type
  IModelUsuario = interface
    function Inserir(const oDtoUsuario: TDtoUsuario): Boolean;
    function Listar: Boolean;
    function Editar(const oDtoUsuario: TDtoUsuario): Boolean;
    function VerificarUsuarioCadastrado(var ADtoUsuario: TDtoUsuario): Boolean;
    function Excluir(const ADtoUsuario: TDtoUsuario): Boolean;



  end;

implementation

end.
