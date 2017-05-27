unit uInterfaceModelMunicipio;

interface

uses
  FireDAC.Comp.Client,
  uDtoMunicipio;

type
  IModelMunicipio = interface
    function Inserir(var oDtoMunicipio: TDtoMunicipio): Boolean;
    function BuscarMaiorID(out oDtoMunicipio: TDtoMunicipio): Boolean;
    function Listar: Boolean;
  end;

implementation

end.
