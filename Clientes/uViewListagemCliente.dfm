inherited frmListagemCliente: TfrmListagemCliente
  Caption = 'Pizza do Nono - Listagem de Clientes'
  ClientWidth = 964
  ExplicitWidth = 970
  PixelsPerInch = 96
  TextHeight = 15
  inherited BoxBotoes: TPanel
    Width = 958
    ExplicitWidth = 869
    inherited btnFechar: TSpeedButton
      Left = 853
      ExplicitLeft = 984
    end
    inherited btnEditar: TSpeedButton
      Left = 3
      Anchors = []
    end
  end
  inherited panelListagem: TPanel
    Width = 948
    Anchors = [akLeft, akTop, akRight, akBottom]
    ExplicitWidth = 859
    inherited dbGridListagem: TDBGrid
      Width = 942
    end
  end
end
