unit uInterfaceCRUD;

interface

uses
  System.Classes, Vcl.Forms,
  uDtoUsuario;

type
  ICrud = interface
    procedure Salvar;
    procedure Cancelar;
    procedure Localizar;
    procedure Novo;
    procedure Editar;
    procedure Excluir;
    procedure FecharFormCadastro(ASender: TObject);
    procedure FecharFormListagem(ASender: TObject);
    procedure CriarFormCadastro(aOwner: TComponent);
    procedure PreencherDTO;
    procedure AjustarModoInsercao(AStatusBtnSalvar: Boolean);
    procedure LimparFormulario;
  end;

implementation

end.
