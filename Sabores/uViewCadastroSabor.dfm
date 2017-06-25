inherited frmCadastroSabor: TfrmCadastroSabor
  Caption = 'frmCadastroSabor'
  ClientWidth = 987
  ExplicitWidth = 993
  PixelsPerInch = 96
  TextHeight = 15
  inherited panelFormulario: TPanel
    Width = 971
    ExplicitWidth = 971
    inherited labelTitulo: TLabel
      Width = 123
      Caption = 'Sabores'
      ExplicitWidth = 123
    end
    object Ingredientes: TLabel [1]
      Left = 481
      Top = 91
      Width = 73
      Height = 15
      Caption = 'Ingredientes:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object labelTamanho: TLabel [2]
      Left = 15
      Top = 216
      Width = 53
      Height = 15
      Caption = 'Tamanho:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtIdCodigo: TLabeledEdit
      Left = 15
      Top = 112
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
      Width = 410
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
      MaxLength = 45
      ParentFont = False
      TabOrder = 2
    end
    object cmbTamanho: TComboBox
      Left = 15
      Top = 237
      Width = 410
      Height = 23
      AutoDropDown = True
      Ctl3D = True
      ParentCtl3D = False
      Sorted = True
      TabOrder = 3
    end
    object edtValor: TLabeledEdit
      Left = 15
      Top = 299
      Width = 410
      Height = 24
      EditLabel.Width = 35
      EditLabel.Height = 15
      EditLabel.Caption = 'Pre'#231'o:'
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
      MaxLength = 45
      NumbersOnly = True
      ParentFont = False
      TabOrder = 4
    end
    object CheckListBoxIngredientes: TCheckListBox
      Left = 481
      Top = 112
      Width = 424
      Height = 257
      Columns = 2
      ItemHeight = 15
      TabOrder = 5
    end
  end
  inherited boxBotoes: TPanel
    Width = 981
    ExplicitWidth = 981
    inherited btnFechar: TSpeedButton
      Left = 876
      ExplicitLeft = 876
    end
  end
end
