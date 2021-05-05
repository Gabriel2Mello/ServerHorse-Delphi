object dmDados: TdmDados
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 325
  Width = 359
  object pvdSqlServer: TSQLServerUniProvider
    Left = 56
    Top = 84
  end
  object UniCon: TUniConnection
    ProviderName = 'SQL Server'
    Port = 1433
    Database = 'DB_TESTE'
    Username = 'sa'
    Server = 'LOCALHOST'
    Connected = True
    LoginPrompt = False
    Left = 56
    Top = 24
    EncryptedPassword = 'CEFFCDFF8EFF88FF9EFF8CFF85FF87FFBFFF'
  end
end
