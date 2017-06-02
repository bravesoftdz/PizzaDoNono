unit uInterfaceModelUsuario;

interface

uses
  FireDAC.Comp.Client,
  uDtoUsuario;

type
  IModelUsuario = interface
    function Inserir(var oDtoUsuario: TDtoUsuario): Boolean;
    function BuscarMaiorID(out ADtoUsuario: TDtoUsuario): Boolean;
    function Listar: Boolean;
  end;

implementation

end.
