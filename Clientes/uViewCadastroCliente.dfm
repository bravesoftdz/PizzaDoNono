inherited frmCadastroCliente: TfrmCadastroCliente
  Caption = 'Pizza do Nono - Clientes'
  ClientHeight = 634
  ClientWidth = 930
  ExplicitTop = -203
  ExplicitWidth = 936
  ExplicitHeight = 663
  PixelsPerInch = 96
  TextHeight = 15
  inherited panelFormulario: TPanel
    Top = 105
    Width = 913
    Height = 521
    ExplicitTop = 105
    ExplicitWidth = 913
    ExplicitHeight = 521
    inherited labelTitulo: TLabel
      Top = 16
      Width = 125
      Caption = 'Clientes'
      ExplicitTop = 16
      ExplicitWidth = 125
    end
    inherited panelSeparador: TPanel
      Top = 67
      ExplicitTop = 67
    end
    object edtIdCodigo: TLabeledEdit
      Left = 16
      Top = 97
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
    object GroupBoxDadosPessoais: TGroupBox
      Left = 15
      Top = 143
      Width = 433
      Height = 362
      Caption = 'Dados Pessoais'
      TabOrder = 2
      object labelTelefone: TLabel
        Left = 14
        Top = 83
        Width = 51
        Height = 15
        Caption = 'Telefone:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object labelCelular: TLabel
        Left = 14
        Top = 139
        Width = 42
        Height = 15
        Caption = 'Celular:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object labelDataNascimento: TLabel
        Left = 16
        Top = 251
        Width = 114
        Height = 15
        Caption = 'Data de Nascimento:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object labelCpfCnpj: TLabel
        Left = 16
        Top = 194
        Width = 56
        Height = 15
        Caption = 'CPF/CNPJ:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtNome: TLabeledEdit
        Left = 16
        Top = 46
        Width = 372
        Height = 24
        EditLabel.Width = 38
        EditLabel.Height = 15
        EditLabel.Caption = 'Nome:'
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
        TabOrder = 0
      end
      object edtTelefone: TMaskEdit
        Left = 16
        Top = 104
        Width = 372
        Height = 23
        EditMask = '(99)9999-9999;1;_'
        MaxLength = 13
        TabOrder = 1
        Text = '(  )    -    '
      end
      object edtCelular: TMaskEdit
        Left = 16
        Top = 160
        Width = 372
        Height = 23
        EditMask = '(99)99999-9999;1;_'
        MaxLength = 14
        TabOrder = 2
        Text = '(  )     -    '
      end
      object edtCpfCnpj: TMaskEdit
        Left = 16
        Top = 215
        Width = 372
        Height = 23
        Hint = 
          'Informe somente os n'#250'meros CPF ou CNPJ. N'#227'o digite pontos, tra'#231'o' +
          's ou barras.'
        EditMask = '99999999999999;0; '
        MaxLength = 14
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        Text = ''
      end
      object edtDataNascimento: TMaskEdit
        Left = 16
        Top = 272
        Width = 372
        Height = 23
        EditMask = '99/99/9999;1;_'
        MaxLength = 10
        TabOrder = 4
        Text = '  /  /    '
      end
    end
    object GroupBoxEndereco: TGroupBox
      Left = 454
      Top = 143
      Width = 433
      Height = 362
      Caption = 'Endere'#231'o Principal'
      TabOrder = 3
      object labelMunicipio: TLabel
        Left = 13
        Top = 252
        Width = 57
        Height = 15
        Caption = 'Munic'#237'pio:'
        FocusControl = cmbMunicipio
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object labelEstado: TLabel
        Left = 13
        Top = 194
        Width = 40
        Height = 15
        Caption = 'Estado:'
        FocusControl = cmbEstado
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object labelBairro: TLabel
        Left = 13
        Top = 307
        Width = 37
        Height = 15
        Caption = 'Bairro:'
        FocusControl = cmbBairro
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtRua: TLabeledEdit
        Left = 13
        Top = 46
        Width = 404
        Height = 23
        EditLabel.Width = 24
        EditLabel.Height = 15
        EditLabel.Caption = 'Rua:'
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
        MaxLength = 255
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
      end
      object edtNumero: TLabeledEdit
        Left = 13
        Top = 104
        Width = 404
        Height = 23
        EditLabel.Width = 50
        EditLabel.Height = 15
        EditLabel.Caption = 'N'#250'mero:'
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
        ParentShowHint = False
        ShowHint = False
        TabOrder = 1
      end
      object edtComplemento: TLabeledEdit
        Left = 13
        Top = 160
        Width = 404
        Height = 23
        EditLabel.Width = 83
        EditLabel.Height = 15
        EditLabel.Caption = 'Complemento:'
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
        MaxLength = 255
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 2
      end
      object cmbEstado: TComboBox
        Left = 13
        Top = 215
        Width = 404
        Height = 23
        AutoDropDown = True
        Ctl3D = True
        ParentCtl3D = False
        Sorted = True
        TabOrder = 3
      end
      object cmbMunicipio: TComboBox
        Left = 13
        Top = 273
        Width = 404
        Height = 23
        AutoDropDown = True
        Ctl3D = True
        ParentCtl3D = False
        Sorted = True
        TabOrder = 4
      end
      object cmbBairro: TComboBox
        Left = 13
        Top = 325
        Width = 404
        Height = 23
        AutoDropDown = True
        Ctl3D = True
        ParentCtl3D = False
        Sorted = True
        TabOrder = 5
      end
    end
  end
  inherited boxBotoes: TPanel
    Width = 924
    ExplicitWidth = 924
    inherited btnFechar: TSpeedButton
      Left = 819
      ExplicitLeft = 819
    end
  end
end
