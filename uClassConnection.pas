unit uClassConnection;

interface

uses
  FireDAC.Comp.Client, FireDAC.Phys.MySQL, FireDAC.Comp.UI, System.SysUtils,
  System.Classes, FireDAC.Stan.Def;

type
  TConnection = class(TFDConnection)

  private
    oWaitCursor: TFDGUIxWaitCursor;
    oLink: TFDPhysMySQLDriverLink;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  end;

implementation

{ TConnection }

constructor TConnection.Create(AOwner: TComponent);
begin
  inherited;

  if (not(Assigned(oWaitCursor))) then
    oWaitCursor := TFDGUIxWaitCursor.Create(nil);

  if (not(Assigned(oLink))) then
    oLink := TFDPhysMySQLDriverLink.Create(nil);
  LoginPrompt := false;
  DriverName := 'Mysql';
  Params.Values['Database'] := 'pizzaNono';
  Params.Values['Password'] := '';
  Params.Values['User_Name'] := 'root';
  Connected := true;

end;

destructor TConnection.Destroy;
begin
  if (Assigned(oWaitCursor)) then
    FreeAndNil(oWaitCursor);

  if (Assigned(oLink)) then
    FreeAndNil(oLink);
  inherited;
end;

end.
