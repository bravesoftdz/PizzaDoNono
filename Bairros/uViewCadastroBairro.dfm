inherited frmCadastroBairro: TfrmCadastroBairro
  Caption = 'frmCadastroBairro'
  ClientHeight = 515
  ClientWidth = 641
  ExplicitWidth = 647
  ExplicitHeight = 544
  PixelsPerInch = 96
  TextHeight = 15
  inherited panelFormulario: TPanel
    Width = 625
    Height = 401
    ExplicitWidth = 625
    ExplicitHeight = 401
    inherited labelTitulo: TLabel
      Width = 110
      Caption = 'Bairros'
      ExplicitWidth = 110
    end
    object labelMunicipio: TLabel [1]
      Left = 14
      Top = 286
      Width = 57
      Height = 15
      Caption = 'Munic'#237'pio:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object labelEstado: TLabel [2]
      Left = 15
      Top = 222
      Width = 40
      Height = 15
      Caption = 'Estado:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtIdCodigo: TLabeledEdit
      Left = 16
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
      Left = 16
      Top = 176
      Width = 410
      Height = 24
      EditLabel.Width = 37
      EditLabel.Height = 15
      EditLabel.Caption = 'Bairro:'
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
    object cmbEstado: TComboBox
      Left = 16
      Top = 240
      Width = 410
      Height = 23
      AutoDropDown = True
      Ctl3D = True
      ParentCtl3D = False
      Sorted = True
      TabOrder = 3
    end
    object cmbMunicipio: TComboBox
      Tag = 1
      Left = 16
      Top = 304
      Width = 410
      Height = 23
      AutoDropDown = True
      Ctl3D = True
      ParentCtl3D = False
      Sorted = True
      TabOrder = 4
    end
  end
  inherited boxBotoes: TPanel
    Width = 635
    ExplicitWidth = 635
    inherited btnFechar: TSpeedButton
      Left = 535
      ExplicitLeft = 535
    end
    inherited btnExcluir: TSpeedButton
      OnClick = nil
    end
  end
end
