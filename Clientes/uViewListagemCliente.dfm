inherited frmListagemCliente: TfrmListagemCliente
  Caption = 'Pizza do Nono - Clientes'
  ClientWidth = 938
  ExplicitWidth = 944
  PixelsPerInch = 96
  TextHeight = 15
  inherited BoxBotoes: TPanel
    Width = 932
    ExplicitWidth = 932
    inherited btnFechar: TSpeedButton
      Left = 827
      ExplicitLeft = 984
    end
  end
  inherited panelListagem: TPanel
    Width = 928
    Anchors = [akLeft, akTop, akRight, akBottom]
    ExplicitTop = 87
    ExplicitWidth = 594
    inherited dbGridListagem: TDBGrid
      Width = 922
      Columns = <
        item
          Expanded = False
          FieldName = 'idcliente'
          Title.Caption = 'ID'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nome'
          Title.Caption = 'Nome'
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'telefone'
          Title.Caption = 'Telefone'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'celular'
          Title.Caption = 'Celular'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cpfcnpj'
          Title.Caption = 'CPF/CNPJ'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'datanascimento'
          Title.Caption = 'Data de Nascimento'
          Width = 130
          Visible = True
        end>
    end
  end
end
