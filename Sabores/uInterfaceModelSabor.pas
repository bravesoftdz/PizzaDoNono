unit uInterfaceModelSabor;

interface

uses
  FireDAC.Comp.Client,
  uDtoSabor;

type
  IModelSabor = interface
    function Inserir(const oDtoSabor: TDtoSabor): Boolean;
    function Listar: Boolean;
    function Editar(const oDtoTSabor: TDtoSabor): Boolean;
    function VerificarSaborCadastrado(var ADtoSabor: TDtoSabor): Boolean;
    function Excluir(const ADtoSabor: TDtoSabor): Boolean;
  end;

implementation

end.
