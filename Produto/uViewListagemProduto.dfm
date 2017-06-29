inherited frmListagemProduto: TfrmListagemProduto
  Caption = 'Pizza do Nono - Produtos'
  ClientWidth = 537
  ExplicitWidth = 543
  PixelsPerInch = 96
  TextHeight = 15
  inherited BoxBotoes: TPanel
    Width = 531
    ExplicitWidth = 526
    inherited btnFechar: TSpeedButton
      Left = 428
      Top = 5
      ExplicitLeft = 423
      ExplicitTop = 5
    end
  end
  inherited panelListagem: TPanel
    Top = 89
    Width = 527
    Height = 487
    ExplicitTop = 98
    ExplicitWidth = 524
    ExplicitHeight = 487
    inherited dbGridListagem: TDBGrid
      Width = 521
      Height = 481
      Columns = <
        item
          Expanded = False
          FieldName = 'idproduto'
          Title.Caption = 'ID'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nome'
          Title.Caption = 'Nome'
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'valor'
          Title.Caption = 'Valor Unit'#225'rio'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'temSabor'
          Visible = False
        end>
    end
  end
end
