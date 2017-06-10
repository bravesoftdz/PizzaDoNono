unit uInterfaceModelIngrediente;

interface

uses
  FireDAC.Comp.Client,
  uDtoIngrediente;

type
  IModelIngrediente = interface
    function Inserir(const oDtoIngrediente: TDtoIngrediente): Boolean;
    function Listar: Boolean;
  end;

implementation

end.
