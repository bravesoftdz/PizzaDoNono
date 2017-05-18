unit uSingletonListaUsuarios;

interface

uses
  System.SysUtils, System.Generics.Collections, uListaHashUsuario;

type
  TSingletonListaUsuario = class
  private
    class var oListaUsuario: TListaUsuario;
  public
    class function getListaUsuario: TListaUsuario;
    class procedure DestruirLista;
  end;

implementation

{ TSingletonListaUsuario }

class procedure TSingletonListaUsuario.DestruirLista;
begin
  if (Assigned(oListaUsuario)) then
    freeAndNil(oListaUsuario);
end;

class function TSingletonListaUsuario.getListaUsuario: TListaUsuario;
begin
  if (not(Assigned(oListaUsuario))) then
    oListaUsuario := TListaUsuario.Create([doOwnsValues]);
  result := oListaUsuario;
end;

end.
