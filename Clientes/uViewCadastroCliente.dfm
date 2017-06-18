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
    Width = 913
    Height = 521
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
        FocusControl = edtTelefone
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
        FocusControl = edtCelular
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object labelCNPJ: TLabel
        Left = 14
        Top = 306
        Width = 30
        Height = 15
        Caption = 'CNPJ:'
        Enabled = False
        FocusControl = edtCNPJ
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object labelCPF: TLabel
        Left = 14
        Top = 252
        Width = 24
        Height = 15
        Caption = 'CPF:'
        FocusControl = edtCPF
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtNome: TLabeledEdit
        Left = 16
        Top = 53
        Width = 382
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
        Left = 14
        Top = 104
        Width = 386
        Height = 23
        EditMask = '!\(99\)0000-0000;1;_'
        MaxLength = 13
        TabOrder = 1
        Text = '(  )    -    '
      end
      object edtCelular: TMaskEdit
        Left = 14
        Top = 160
        Width = 390
        Height = 23
        EditMask = '!\(99\)0000-0000;1;_'
        MaxLength = 13
        TabOrder = 2
        Text = '(  )    -    '
      end
      object radioCPF: TRadioButton
        Left = 14
        Top = 216
        Width = 111
        Height = 17
        Caption = 'Pessoa F'#237'sica'
        Checked = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        TabStop = True
      end
      object radioCNPJ: TRadioButton
        Left = 150
        Top = 216
        Width = 111
        Height = 17
        Caption = 'Pessoa Jur'#237'dica'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
      end
      object edtCPF: TMaskEdit
        Left = 14
        Top = 273
        Width = 392
        Height = 23
        EditMask = '999.999.999-99;1;_'
        MaxLength = 14
        TabOrder = 5
        Text = '   .   .   -  '
      end
      object edtCNPJ: TMaskEdit
        Left = 14
        Top = 325
        Width = 394
        Height = 23
        Enabled = False
        EditMask = '99.999.999/9999-99;1;_'
        MaxLength = 18
        TabOrder = 6
        Text = '  .   .   /    -  '
      end
    end
    object GroupBoxEndereco: TGroupBox
      Left = 463
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
        Top = 48
        Width = 404
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
        Left = 13
        Top = 104
        Width = 404
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
        Left = 13
        Top = 160
        Width = 404
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
        Tag = 1
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
