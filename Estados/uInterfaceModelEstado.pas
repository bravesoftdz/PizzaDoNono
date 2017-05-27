unit uInterfaceModelEstado;

interface

uses
  FireDAC.Comp.Client,
  uDtoEstado;

type
  IModelEstado = interface
    function Inserir(var oDtoEstado: TDtoEstado): Boolean;
    function BuscarMaiorID(out ADtoEstado: TDtoEstado): Boolean;
    function Listar: Boolean;
  end;

implementation

end.
