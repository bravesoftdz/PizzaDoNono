inherited frmCadastroCliente: TfrmCadastroCliente
  ActiveControl = edtNome
  Caption = 'Pizza do Nono - Clientes'
  ClientHeight = 557
  ClientWidth = 647
  Position = poDesigned
  ExplicitTop = -152
  ExplicitWidth = 653
  ExplicitHeight = 586
  PixelsPerInch = 96
  TextHeight = 15
  inherited panelFormulario: TPanel
    Top = 94
    Width = 637
    Height = 458
    ExplicitTop = 128
    ExplicitWidth = 637
    ExplicitHeight = 458
    inherited labelTitulo: TLabel
      Left = 26
      Top = 4
      Width = 125
      Caption = 'Clientes'
      ExplicitLeft = 26
      ExplicitTop = 4
      ExplicitWidth = 125
    end
    inherited panelSeparador: TPanel
      Left = 26
      Top = 55
      ExplicitLeft = 26
      ExplicitTop = 55
    end
    object edtIdCodigo: TLabeledEdit
      Tag = 1
      Left = 26
      Top = 85
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
    object GroupBoxDadosPessoais: TGroupBox
      Left = 26
      Top = 115
      Width = 578
      Height = 138
      Caption = 'Dados Pessoais'
      TabOrder = 2
      object labelTelefone: TLabel
        Left = 16
        Top = 80
        Width = 114
        Height = 15
        Caption = 'Telefone Residencial:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object labelCelular: TLabel
        Left = 144
        Top = 80
        Width = 88
        Height = 15
        Caption = 'Telefone Celular'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object labelDataNascimento: TLabel
        Left = 439
        Top = 80
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
        Left = 264
        Top = 80
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
        Top = 48
        Width = 543
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
        Top = 101
        Width = 122
        Height = 23
        EditMask = '(99)9999-9999;1;_'
        MaxLength = 13
        TabOrder = 1
        Text = '(  )    -    '
      end
      object edtCelular: TMaskEdit
        Left = 144
        Top = 101
        Width = 114
        Height = 23
        EditMask = '(99)99999-9999;1;_'
        MaxLength = 14
        TabOrder = 2
        Text = '(  )     -    '
      end
      object edtCpfCnpj: TMaskEdit
        Left = 264
        Top = 101
        Width = 167
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
        Left = 439
        Top = 101
        Width = 120
        Height = 23
        EditMask = '99/99/9999;1;_'
        MaxLength = 10
        TabOrder = 4
        Text = '  /  /    '
      end
    end
    object GroupBoxEndereco: TGroupBox
      Left = 26
      Top = 259
      Width = 577
      Height = 194
      Caption = 'Endere'#231'o Principal'
      TabOrder = 3
      object labelMunicipio: TLabel
        Left = 15
        Top = 132
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
        Left = 289
        Top = 74
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
        Left = 289
        Top = 132
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
        Left = 15
        Top = 44
        Width = 469
        Height = 24
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
        Left = 490
        Top = 44
        Width = 68
        Height = 24
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
        Left = 15
        Top = 96
        Width = 268
        Height = 24
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
        LabelSpacing = 5
        MaxLength = 255
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 2
      end
      object cmbEstado: TComboBox
        Left = 289
        Top = 95
        Width = 268
        Height = 23
        AutoDropDown = True
        AutoCloseUp = True
        Ctl3D = True
        ParentCtl3D = False
        Sorted = True
        TabOrder = 3
      end
      object cmbMunicipio: TComboBox
        Left = 15
        Top = 153
        Width = 268
        Height = 23
        AutoDropDown = True
        AutoCloseUp = True
        Ctl3D = True
        ParentCtl3D = False
        Sorted = True
        TabOrder = 4
      end
      object cmbBairro: TComboBox
        Left = 289
        Top = 153
        Width = 268
        Height = 23
        AutoDropDown = True
        AutoCloseUp = True
        Ctl3D = True
        ParentCtl3D = False
        Sorted = True
        TabOrder = 5
      end
    end
  end
  inherited boxBotoes: TPanel
    Width = 641
    ExplicitWidth = 641
    inherited btnFechar: TSpeedButton
      Left = 533
      ExplicitLeft = 819
    end
  end
end
