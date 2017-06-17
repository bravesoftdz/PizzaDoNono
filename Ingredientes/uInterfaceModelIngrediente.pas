unit uInterfaceModelIngrediente;

interface

uses
  FireDAC.Comp.Client,
  uDtoIngrediente;

type
  IModelIngrediente = interface
    function Inserir(const oDtoIngrediente: TDtoIngrediente): Boolean;
    function Listar: Boolean;
    function Editar(const oDtoIngrediente: TDtoIngrediente): Boolean;
    function VerificarIngredienteCadastrado(var ADtoIngrediente: TDtoIngrediente): Boolean;
    function Excluir(const ADtoIngrediente: TDtoIngrediente): Boolean;
  end;

implementation

end.
