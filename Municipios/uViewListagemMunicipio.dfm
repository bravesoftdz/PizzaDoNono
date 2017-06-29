inherited frmListagemMunicipio: TfrmListagemMunicipio
  Caption = 'Pizza do Nono - Munic'#237'pios'
  ClientWidth = 716
  ExplicitWidth = 722
  PixelsPerInch = 96
  TextHeight = 15
  inherited BoxBotoes: TPanel
    Width = 710
    ExplicitWidth = 705
    inherited btnFechar: TSpeedButton
      Left = 605
      ExplicitLeft = 600
    end
  end
  inherited panelListagem: TPanel
    Width = 706
    ExplicitTop = 87
    ExplicitWidth = 594
    inherited dbGridListagem: TDBGrid
      Width = 700
      Columns = <
        item
          Expanded = False
          FieldName = 'idmunicipio'
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
          FieldName = 'estado'
          Title.Caption = 'Estado'
          Width = 300
          Visible = True
        end>
    end
  end
end
