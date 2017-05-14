inherited frmSabores: TfrmSabores
  ActiveControl = edtID
  Caption = 'frmSabores'
  PixelsPerInch = 96
  TextHeight = 15
  inherited panelFormulario: TPanel
    Left = 7
    Anchors = [akLeft, akTop, akBottom]
    ExplicitLeft = 7
    object edtDescricao: TLabeledEdit
      Left = 15
      Top = 104
      Width = 300
      Height = 23
      EditLabel.Width = 58
      EditLabel.Height = 15
      EditLabel.Caption = 'Descri'#231#227'o: '
      EditLabel.Font.Charset = ANSI_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -13
      EditLabel.Font.Name = 'Calibri'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      LabelSpacing = 5
      MaxLength = 45
      TabOrder = 0
      TextHint = 'Ex: Quatro Queijos'
    end
    object edtID: TLabeledEdit
      Left = 15
      Top = 40
      Width = 300
      Height = 23
      EditLabel.Width = 18
      EditLabel.Height = 15
      EditLabel.Caption = 'ID: '
      EditLabel.Font.Charset = ANSI_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -13
      EditLabel.Font.Name = 'Calibri'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      LabelSpacing = 5
      MaxLength = 11
      NumbersOnly = True
      ReadOnly = True
      TabOrder = 1
      TextHint = 'Ex: Quatro Queijos'
    end
  end
end
