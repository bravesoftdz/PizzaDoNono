unit uControllerUsuario;

interface

uses
  System.SysUtils, System.Generics.Collections, Vcl.StdCtrls, Dialogs,
  uDtoUsuario, uModelUsuario;

type
  TControllerUsuario = class
  private
    oModelUsuario: TModelUsuario;

  public
    function Salvar(var oDtoUsuario: TDtoUsuario): Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TControllerUsuario }

constructor TControllerUsuario.Create;
begin
  if not(Assigned(oModelUsuario)) then
    oModelUsuario := TModelUsuario.Create(nil);

end;

destructor TControllerUsuario.Destroy;
begin
  if Assigned(oModelUsuario) then
    FreeAndNil(oModelUsuario);
  inherited;
end;

function TControllerUsuario.Salvar(var oDtoUsuario: TDtoUsuario): Boolean;
begin
  oModelUsuario.Inserir(oDtoUsuario);
end;

end.
