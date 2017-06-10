unit uInterfaceModelMunicipio;

interface

uses
  FireDAC.Comp.Client,
  uDtoMunicipio;

type
  IModelMunicipio = interface
    function Inserir(const oDtoMunicipio: TDtoMunicipio): Boolean;
    function Listar: Boolean;
  end;

implementation

end.
