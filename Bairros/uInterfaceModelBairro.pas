unit uInterfaceModelBairro;

interface

uses
  FireDAC.Comp.Client,
  uDtoBairro;

type
  IModelBairro = interface
    function Inserir(var oDtoBairro: TDtoBairro): Boolean;
    function BuscarMaiorID(out oDtoBairro: TDtoBairro): Boolean;
    function Listar: Boolean;
  end;

implementation

end.
