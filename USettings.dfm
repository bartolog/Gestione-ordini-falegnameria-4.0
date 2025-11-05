object dlgSettings: TdlgSettings
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Settings'
  ClientHeight = 246
  ClientWidth = 562
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Label1: TLabel
    Left = 40
    Top = 43
    Width = 86
    Height = 15
    Caption = 'Pantografo path'
  end
  object Label2: TLabel
    Left = 40
    Top = 110
    Width = 81
    Height = 15
    Caption = 'Bordatrice path'
  end
  object edtPathPantografo: TcxButtonEdit
    Left = 40
    Top = 64
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.OnButtonClick = edtPathPantografoPropertiesButtonClick
    TabOrder = 0
    Width = 497
  end
  object edtPathBordatrice: TcxButtonEdit
    Left = 40
    Top = 131
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.OnButtonClick = edtPathPantografoPropertiesButtonClick
    TabOrder = 1
    Width = 497
  end
  object cxPropertiesStore1: TcxPropertiesStore
    Components = <
      item
        Component = edtPathBordatrice
        Properties.Strings = (
          'Text')
      end
      item
        Component = edtPathPantografo
        Properties.Strings = (
          'Text')
      end>
    StorageName = 'cxPropertiesStore1'
    Left = 312
    Top = 176
  end
  object FileOpenDialog1: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoPickFolders]
    Left = 160
    Top = 176
  end
end
