inherited frmListagemPedido: TfrmListagemPedido
  Caption = 'Pizza do Nono - Pedidos'
  ClientWidth = 501
  ExplicitWidth = 507
  PixelsPerInch = 96
  TextHeight = 15
  inherited BoxBotoes: TPanel
    Width = 495
    inherited LabelFiltro: TLabel
      Left = 5
      Top = 32
      Width = 158
      Caption = 'Filtrar pelo nome do Ciente: '
      ExplicitLeft = 5
      ExplicitTop = 32
      ExplicitWidth = 158
    end
    inherited btnFechar: TSpeedButton
      Left = 390
    end
    inherited SearchBoxListagem: TSearchBox
      Left = 5
      Width = 352
      ExplicitLeft = 5
      ExplicitWidth = 352
    end
  end
  inherited panelListagem: TPanel
    Width = 491
    inherited dbGridListagem: TDBGrid
      Width = 485
      Columns = <
        item
          Expanded = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Calibri'
          Font.Style = []
          Title.Caption = 'ID'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          Title.Caption = 'Cliente'
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          Title.Caption = 'Data'
          Width = 80
          Visible = True
        end>
    end
  end
end
