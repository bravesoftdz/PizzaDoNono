unit uInterfaceModelTamanho;

interface

uses
  FireDAC.Comp.Client,
  uDtoTamanho;

type
  IModelTamanho = interface
    function Inserir(const oDtoTamanho: TDtoTamanho): Boolean;
    function Listar: Boolean;
    function Editar(const oDtoTamanho: TDtoTamanho): Boolean;
    function VerificarTamanhoCadastrado(var ADtoTamanho: TDtoTamanho): Boolean;
    function Excluir(const ADtoTamanho: TDtoTamanho): Boolean;
  end;

implementation

end.
