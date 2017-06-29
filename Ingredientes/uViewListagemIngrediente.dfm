inherited frmListagemIngrediente: TfrmListagemIngrediente
  Caption = 'Pizza do Nono - Ingredientes'
  ClientWidth = 476
  ExplicitWidth = 482
  PixelsPerInch = 96
  TextHeight = 15
  inherited BoxBotoes: TPanel
    Width = 470
    ExplicitWidth = 468
    inherited btnFechar: TSpeedButton
      Left = 365
      ExplicitLeft = 363
    end
  end
  inherited panelListagem: TPanel
    Width = 466
    ExplicitTop = 87
    ExplicitWidth = 464
    inherited dbGridListagem: TDBGrid
      Width = 460
      Columns = <
        item
          Expanded = False
          FieldName = 'idingrediente'
          Title.Caption = 'ID'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nome'
          Title.Caption = 'Nome'
          Width = 360
          Visible = True
        end>
    end
  end
end
