inherited frmListagemTamanho: TfrmListagemTamanho
  Caption = 'Pizza do Nono - Tamanhos'
  ClientWidth = 517
  ExplicitWidth = 523
  PixelsPerInch = 96
  TextHeight = 15
  inherited BoxBotoes: TPanel
    Width = 511
    ExplicitWidth = 507
    inherited btnFechar: TSpeedButton
      Left = 406
      ExplicitLeft = 402
    end
  end
  inherited panelListagem: TPanel
    Width = 507
    ExplicitWidth = 503
    inherited dbGridListagem: TDBGrid
      Width = 501
      Columns = <
        item
          Expanded = False
          FieldName = 'idtamanho'
          Title.Caption = 'ID'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nome'
          Title.Caption = 'Nome'
          Width = 250
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'maxsabores'
          Title.Caption = 'N'#186' M'#225'ximo de Sabores'
          Width = 150
          Visible = True
        end>
    end
  end
end
