unit UData;

interface

uses
  System.SysUtils, System.Classes, Aurelius.Engine.ObjectManager, Aurelius.Linq,
  Aurelius.Drivers.UniDac, Data.DB, DBAccess, Uni, UniProvider,
  MySQLUniProvider, Aurelius.Comp.Connection, Aurelius.Comp.Manager;

type
  TDataContainer = class(TDataModule)
    AureliusManager1: TAureliusManager;
    AureliusConnection1: TAureliusConnection;
    MySQLUniProvider1: TMySQLUniProvider;
    UniConnection1: TUniConnection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataContainer: TDataContainer;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
