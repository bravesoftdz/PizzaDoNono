inherited frmListagemEstado: TfrmListagemEstado
  Caption = 'Pizza do Nono - Estados'
  ClientWidth = 498
  ExplicitWidth = 504
  PixelsPerInch = 96
  TextHeight = 15
  inherited BoxBotoes: TPanel
    Width = 492
    ExplicitWidth = 498
    inherited btnFechar: TSpeedButton
      Left = 387
      ExplicitLeft = 393
    end
  end
  inherited panelListagem: TPanel
    Top = 86
    Width = 488
    Height = 490
    ExplicitTop = 86
    ExplicitWidth = 464
    ExplicitHeight = 490
    inherited dbGridListagem: TDBGrid
      Width = 482
      Height = 484
      Columns = <
        item
          Expanded = False
          FieldName = 'idestado'
          Title.Caption = 'ID'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'uf'
          Title.Caption = 'UF'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nome'
          Title.Caption = 'Nome'
          Width = 300
          Visible = True
        end>
    end
  end
end
