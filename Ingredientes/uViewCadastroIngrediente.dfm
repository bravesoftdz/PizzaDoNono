inherited frmCadastroIngrediente: TfrmCadastroIngrediente
  Caption = 'Pizza do Nono - Ingredientes'
  ClientHeight = 340
  ExplicitHeight = 369
  PixelsPerInch = 96
  TextHeight = 15
  inherited panelFormulario: TPanel
    Height = 225
    ExplicitWidth = 631
    ExplicitHeight = 225
    inherited labelTitulo: TLabel
      Width = 195
      Caption = 'Ingredientes'
      ExplicitWidth = 195
    end
    inherited panelSeparador: TPanel
      TabOrder = 2
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
      TabOrder = 1
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
      TabOrder = 0
    end
  end
end
