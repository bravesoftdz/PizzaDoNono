unit uInterfaceModelIngrediente;

interface

uses
  FireDAC.Comp.Client,
  uDtoIngrediente;

type
  IModelIngrediente = interface
    function Inserir(var oDtoIngrediente: TDtoIngrediente): Boolean;
    function BuscarMaiorID(out oDtoIngrediente: TDtoIngrediente): Boolean;
    function Listar: Boolean;
  end;

implementation

end.
