unit uInterfaceCRUD;

interface

uses
  System.Classes, Vcl.Forms,
  uDtoUsuario;

type
  ICrud = interface
    procedure Salvar(ASender: TObject);
    procedure Cancelar(ASender: TObject);
    procedure Localizar(aOwner: TComponent);
    procedure Novo(ASender: TObject);
    procedure Editar(Sender: TObject = nil);
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
