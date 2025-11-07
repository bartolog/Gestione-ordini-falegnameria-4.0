object DataContainer: TDataContainer
  Height = 480
  Width = 811
  object AureliusManager1: TAureliusManager
    Connection = AureliusConnection1
    Left = 288
    Top = 352
  end
  object AureliusConnection1: TAureliusConnection
    AdapterName = 'UniDac'
    AdaptedConnection = UniConnection1
    Left = 416
    Top = 312
  end
  object MySQLUniProvider1: TMySQLUniProvider
    Left = 552
    Top = 312
  end
  object UniConnection1: TUniConnection
    ProviderName = 'MySQL'
    Port = 3307
    Database = 'dbTestAurelius'
    Username = 'root'
    Server = 'localhost'
    LoginPrompt = False
    Left = 624
    Top = 328
    EncryptedPassword = '8DFF90FF90FF8BFF'
  end
end
