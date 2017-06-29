inherited frmListagemBairro: TfrmListagemBairro
  Caption = 'Pizza do Nono - Bairros'
  ClientWidth = 718
  ExplicitWidth = 724
  PixelsPerInch = 96
  TextHeight = 15
  inherited BoxBotoes: TPanel
    Width = 712
    ExplicitWidth = 716
    inherited btnFechar: TSpeedButton
      Left = 607
      ExplicitLeft = 611
    end
  end
  inherited panelListagem: TPanel
    Width = 708
    ExplicitWidth = 594
    inherited dbGridListagem: TDBGrid
      Width = 702
      Columns = <
        item
          Expanded = False
          FieldName = 'idBairro'
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
          FieldName = 'Municipio'
          Title.Caption = 'Munic'#237'pio'
          Width = 300
          Visible = True
        end>
    end
  end
end
