inherited frmCadastroSabor: TfrmCadastroSabor
  Caption = 'frmCadastroSabor'
  ExplicitTop = -231
  PixelsPerInch = 96
  TextHeight = 15
  inherited panelFormulario: TPanel
    inherited labelTitulo: TLabel
      Width = 123
      Caption = 'Sabores'
      ExplicitWidth = 123
    end
    object Ingredientes: TLabel [1]
      Left = 17
      Top = 216
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
    object CheckListBox1: TCheckListBox
      Left = 17
      Top = 237
      Width = 424
      Height = 257
      Columns = 2
      ItemHeight = 15
      TabOrder = 3
    end
  end
end
