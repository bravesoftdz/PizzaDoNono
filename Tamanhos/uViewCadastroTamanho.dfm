inherited frmCadastroTamanho: TfrmCadastroTamanho
  Width = 653
  Height = 415
  Caption = 'Pizza do Nono - Tamanhos'
  ExplicitWidth = 653
  ExplicitHeight = 415
  PixelsPerInch = 96
  TextHeight = 15
  inherited panelFormulario: TPanel
    Width = 637
    Height = 288
    ExplicitTop = 107
    ExplicitWidth = 637
    ExplicitHeight = 288
    inherited labelTitulo: TLabel
      Width = 142
      Caption = 'Tamanho'
      ExplicitWidth = 142
    end
    object edtIdCodigo: TLabeledEdit
      Tag = 1
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
    object edtMaxSabores: TLabeledEdit
      Left = 15
      Top = 237
      Width = 177
      Height = 24
      EditLabel.Width = 172
      EditLabel.Height = 15
      EditLabel.Caption = 'Quantidade m'#225'xima de sabores'
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
      TabOrder = 3
    end
  end
  inherited boxBotoes: TPanel
    Width = 641
    ExplicitWidth = 641
    inherited btnFechar: TSpeedButton
      Left = 536
      ExplicitLeft = 536
    end
  end
end
