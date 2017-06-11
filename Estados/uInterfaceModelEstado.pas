unit uInterfaceModelEstado;

interface

uses
  FireDAC.Comp.Client,
  uDtoEstado;

type
  IModelEstado = interface
    function Inserir(const oDtoEstado: TDtoEstado): Boolean;
    function Listar: Boolean;
  end;

implementation

end.
