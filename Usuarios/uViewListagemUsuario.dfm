inherited frmListagemUsuario: TfrmListagemUsuario
  Caption = 'Pizza do Nono - Usuarios'
  ClientWidth = 482
  OnCreate = FormCreate
  ExplicitWidth = 488
  PixelsPerInch = 96
  TextHeight = 15
  inherited BoxBotoes: TPanel
    Width = 476
    ExplicitWidth = 470
    inherited btnFechar: TSpeedButton
      Left = 371
      ExplicitLeft = 365
    end
  end
  inherited panelListagem: TPanel
    Top = 86
    Width = 472
    Height = 490
    ExplicitTop = 86
    ExplicitWidth = 472
    ExplicitHeight = 490
    inherited dbGridListagem: TDBGrid
      Width = 466
      Height = 484
      Columns = <
        item
          Expanded = False
          FieldName = 'idusuario'
          Title.Caption = 'ID'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nome'
          Title.Caption = 'Nome'
          Width = 365
          Visible = True
        end>
    end
  end
end
