unit uInterfaceModelBairro;

interface

uses
  FireDAC.Comp.Client,
  uDtoBairro;

type
  IModelBairro = interface
    function Inserir(const oDtoBairro: TDtoBairro): Boolean;
    function Listar: Boolean;
  end;

implementation

end.
