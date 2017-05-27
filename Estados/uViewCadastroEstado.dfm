inherited frmCadastroEstado: TfrmCadastroEstado
  Caption = 'frmCadastroEstado'
  ClientHeight = 631
  ExplicitHeight = 660
  PixelsPerInch = 96
  TextHeight = 15
  inherited panelFormulario: TPanel
    inherited labelTitulo: TLabel
      Width = 119
      Caption = 'Estados'
      ExplicitWidth = 119
    end
    object edtIdCodigo: TLabeledEdit
      Left = 16
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
      TabOrder = 1
    end
    object edtDescricao: TLabeledEdit
      Left = 15
      Top = 240
      Width = 410
      Height = 24
      EditLabel.Width = 40
      EditLabel.Height = 16
      EditLabel.Caption = 'Nome:'
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
      TabOrder = 2
      TextHint = 'Informe o nome do usu'#225'rio. Campo obrigat'#243'rio.'
    end
    object LabeledEdit1: TLabeledEdit
      Left = 16
      Top = 176
      Width = 137
      Height = 24
      EditLabel.Width = 19
      EditLabel.Height = 16
      EditLabel.Caption = 'UF:'
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
      TabOrder = 3
      TextHint = 'Informe o nome do usu'#225'rio. Campo obrigat'#243'rio.'
    end
  end
  inherited boxCancelar: TPanel
    Top = 15
  end
  inherited boxSalvar: TPanel
    Top = 15
  end
end
