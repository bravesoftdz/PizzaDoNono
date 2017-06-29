inherited frmCadastroProduto: TfrmCadastroProduto
  Caption = 'Pizza do Nono - Produtos'
  ClientHeight = 546
  ClientWidth = 647
  Position = poDesigned
  ExplicitWidth = 653
  ExplicitHeight = 575
  PixelsPerInch = 96
  TextHeight = 15
  inherited panelFormulario: TPanel
    Top = 107
    Width = 637
    Height = 434
    Caption = 'S'
    ExplicitTop = 111
    ExplicitWidth = 637
    ExplicitHeight = 434
    inherited labelTitulo: TLabel
      Width = 126
      Caption = 'Produto'
      ExplicitWidth = 126
    end
    object labelSabores: TLabel [1]
      Left = 15
      Top = 210
      Width = 111
      Height = 15
      Caption = 'Sabores Dispon'#237'veis:'
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object labelTemSabor: TLabel [2]
      Left = 213
      Top = 153
      Width = 72
      Height = 15
      Caption = 'Possui Sabor:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
    end
    inherited panelSeparador: TPanel
      Width = 362
      ExplicitWidth = 362
    end
    object edtIdCodigo: TLabeledEdit
      Tag = 1
      Left = 15
      Top = 120
      Width = 137
      Height = 24
      TabStop = False
      EditLabel.Width = 15
      EditLabel.Height = 15
      EditLabel.Caption = 'ID:'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -13
      EditLabel.Font.Name = 'Calibri'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 11
      NumbersOnly = True
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object edtNome: TLabeledEdit
      Left = 15
      Top = 173
      Width = 192
      Height = 24
      EditLabel.Width = 55
      EditLabel.Height = 15
      EditLabel.Caption = 'Descri'#231#227'o:'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -13
      EditLabel.Font.Name = 'Calibri'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      LabelSpacing = 5
      MaxLength = 45
      ParentFont = False
      TabOrder = 2
    end
    object edtValor: TLabeledEdit
      Left = 332
      Top = 173
      Width = 137
      Height = 24
      EditLabel.Width = 32
      EditLabel.Height = 15
      EditLabel.Caption = 'Valor:'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -13
      EditLabel.Font.Name = 'Calibri'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      LabelSpacing = 5
      MaxLength = 45
      ParentFont = False
      TabOrder = 3
    end
    object CheckListBoxSabores: TCheckListBox
      Left = 15
      Top = 231
      Width = 454
      Height = 182
      Color = clWhite
      Columns = 2
      Enabled = False
      ItemHeight = 15
      Sorted = True
      TabOrder = 4
    end
    object cmbTemSabor: TComboBox
      Left = 213
      Top = 174
      Width = 113
      Height = 23
      Hint = 'Indique se o produto tem sabores. Ex.:  Cebola, Alho e Milho'
      AutoDropDown = True
      MaxLength = 3
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      Items.Strings = (
        'N'#227'o'
        'Sim')
    end
  end
  inherited boxBotoes: TPanel
    Width = 641
    Height = 95
    ExplicitWidth = 641
    ExplicitHeight = 95
    inherited btnFechar: TSpeedButton
      Left = 536
      ExplicitLeft = 536
    end
  end
end
