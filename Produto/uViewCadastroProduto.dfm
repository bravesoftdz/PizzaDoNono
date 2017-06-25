inherited frmCadastroProduto: TfrmCadastroProduto
  Caption = 'frmCadastroProduto'
  PixelsPerInch = 96
  TextHeight = 15
  inherited panelFormulario: TPanel
    inherited labelTitulo: TLabel
      Width = 126
      Caption = 'Produto'
      ExplicitWidth = 126
    end
    object Label1: TLabel [1]
      Left = 15
      Top = 216
      Width = 71
      Height = 15
      Caption = 'Possui sabor:'
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
    object edtValor: TLabeledEdit
      Left = 15
      Top = 293
      Width = 410
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
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 45
      ParentFont = False
      TabOrder = 3
    end
    object RadioSaborSim: TRadioButton
      Left = 24
      Top = 248
      Width = 113
      Height = 17
      Caption = 'Sim'
      TabOrder = 4
    end
    object RadioSaborNao: TRadioButton
      Left = 80
      Top = 248
      Width = 113
      Height = 17
      Caption = 'Nao'
      TabOrder = 5
    end
  end
end
