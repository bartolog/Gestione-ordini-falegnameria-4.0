object frmProdotto: TfrmProdotto
  Left = 0
  Top = 0
  Caption = 'Prodotto'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  TextHeight = 15
  object btnLoadProduct: TButton
    Left = 0
    Top = 344
    Width = 137
    Height = 25
    Caption = 'Carica prodotto'
    TabOrder = 0
    OnClick = btnLoadProductClick
  end
  object cxGrid1: TcxGrid
    Left = 0
    Top = 0
    Width = 624
    Height = 329
    Align = alTop
    TabOrder = 1
    object ProdottoView: TcxGridTableView
      DataController.OnBeforeDelete = ProdottoViewDataControllerBeforeDelete
      object ProdottoViewId: TcxGridColumn
        Caption = 'ID'
      end
      object ProdottoViewNome: TcxGridColumn
        Caption = 'Nome'
        Width = 176
      end
      object ProdottoViewObject: TcxGridColumn
        Visible = False
      end
    end
    object PartiView: TcxGridTableView
      OptionsView.GroupByBox = False
      OptionsView.Header = False
      object PartiViewDescrizione: TcxGridColumn
        Width = 120
      end
      object PartiViewQta: TcxGridColumn
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = ProdottoView
      object cxGrid1Level2: TcxGridLevel
        GridView = PartiView
      end
    end
  end
  object btnSalva: TButton
    Left = 200
    Top = 344
    Width = 161
    Height = 25
    Caption = 'Salva'
    TabOrder = 2
    OnClick = btnSalvaClick
  end
end
