unit dataModuleFuncoesGlobais;

interface

uses
  System.SysUtils, System.Classes, Vcl.Forms, Vcl.ExtCtrls, Vcl.Graphics;

type
  TdmFuncoesGlobais = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CriarForm(ClassName: TFormClass; FormName: TForm);
    procedure DestruirForm(FormName: TForm);

  end;

var
  dmFuncoesGlobais: TdmFuncoesGlobais;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TdmFuncoesGerais }

procedure TdmFuncoesGlobais.CriarForm(ClassName: TFormClass; FormName: TForm);
begin
  if not(assigned(FormName)) then
    Application.CreateForm(ClassName, FormName);
  FormName.Show;
end;

procedure TdmFuncoesGlobais.DestruirForm(FormName: TForm);
begin
  if assigned(FormName) then
  begin
    FormName := nil;
    FormName.Free;
  end;
end;

end.
