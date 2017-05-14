unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage,
  uViewCadastroUsuario, dataModuleFuncoesGlobais, uClassDBConnectionSingleton,
  uFrmBasePadrao;

type
  TfrmPrincipal = class(TfrmBasePadrao)
    Panel1: TPanel;
    bntBairros: TSpeedButton;
    btnClientes: TSpeedButton;
    btnEstados: TSpeedButton;
    btnIngredientes: TSpeedButton;
    btnMunicipios: TSpeedButton;
    btnPedidos: TSpeedButton;
    btnProdutos: TSpeedButton;
    btnRelatórios: TSpeedButton;
    btnSabores: TSpeedButton;
    btnSair: TSpeedButton;
    btnUsuarios: TSpeedButton;
    procedure btnUsuariosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.btnUsuariosClick(Sender: TObject);
begin
  inherited;
  dmFuncoesGlobais.CriarForm(TfrmUsuario, frmUsuario);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  inherited;
  ReportMemoryLeaksOnShutdown := True;

  // Cria a conexão com o banco de dados
  try
    TDBConnectionSingleton.GetInstancia;
  except
    ShowMessage
      ('Erro ao conectar com o banco de dados. O sistema não pode ser iniciado.');
    // Manda encerrar a aplicação
    Application.Terminate;
    exit;
  end;
end;

end.
