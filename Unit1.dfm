object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 360
  ClientWidth = 575
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object AureliusConnection1: TAureliusConnection
    AdapterName = 'UniDac'
    AdaptedConnection = UniConnection1
    Left = 280
    Top = 184
  end
  object AureliusManager1: TAureliusManager
    Connection = AureliusConnection1
    Left = 376
    Top = 136
  end
  object UniConnection1: TUniConnection
    ProviderName = 'MySQL'
    Port = 3307
    Database = 'dbTestAurelius'
    Username = 'root'
    Server = 'localhost'
    LoginPrompt = False
    Left = 432
    Top = 264
    EncryptedPassword = '8DFF90FF90FF8BFF'
  end
  object MySQLUniProvider1: TMySQLUniProvider
    Left = 288
    Top = 256
  end
end
