inherited frmListagemSabor: TfrmListagemSabor
  Caption = 'Pizza do Nono - Sabores'
  ClientWidth = 619
  ExplicitWidth = 625
  PixelsPerInch = 96
  TextHeight = 15
  inherited BoxBotoes: TPanel
    Width = 613
    ExplicitWidth = 607
    inherited btnFechar: TSpeedButton
      Left = 508
      ExplicitLeft = 502
    end
  end
  inherited panelListagem: TPanel
    Width = 609
    ExplicitTop = 87
    ExplicitWidth = 594
    inherited dbGridListagem: TDBGrid
      Width = 603
      Columns = <
        item
          Expanded = False
          FieldName = 'idsabor'
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
          FieldName = 'tamanho'
          Title.Caption = 'Tamanho'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'valor'
          Title.Caption = 'Valor Unit'#225'rio'
          Width = 100
          Visible = True
        end>
    end
  end
end
