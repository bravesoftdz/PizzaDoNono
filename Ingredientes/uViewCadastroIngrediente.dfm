inherited frmCadastroIngrediente: TfrmCadastroIngrediente
  Caption = 'frmCadastroIngrediente'
  PixelsPerInch = 96
  TextHeight = 15
  inherited panelFormulario: TPanel
    Left = 8
    ExplicitLeft = 8
    inherited labelTitulo: TLabel
      Width = 195
      Caption = 'Ingredientes'
      ExplicitWidth = 195
    end
    object edtDescricao: TLabeledEdit
      Left = 15
      Top = 173
      Width = 410
      Height = 24
      EditLabel.Width = 68
      EditLabel.Height = 16
      EditLabel.Caption = 'Descri'#231#227'o:'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -13
      EditLabel.Font.Name = 'Tahoma'
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
      TextHint = 'Informe o nome do usu'#225'rio. Campo obrigat'#243'rio.'
    end
    object edtIdCodigo: TLabeledEdit
      Left = 15
      Top = 112
      Width = 137
      Height = 24
      EditLabel.Width = 19
      EditLabel.Height = 16
      EditLabel.Caption = 'ID:'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -13
      EditLabel.Font.Name = 'Tahoma'
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
      TabOrder = 2
    end
  end
end
