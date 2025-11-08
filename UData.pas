unit UData;

interface

uses
  System.SysUtils, System.Classes, Aurelius.Engine.ObjectManager, Aurelius.Linq,
  Aurelius.Drivers.UniDac, Data.DB, DBAccess, Uni, UniProvider,
  MySQLUniProvider, Aurelius.Comp.Connection, Aurelius.Comp.Manager, cxClasses,
  cxPropertiesStore;

type
  TDataContainer = class(TDataModule)
    AureliusManager1: TAureliusManager;
    AureliusConnection1: TAureliusConnection;
    MySQLUniProvider1: TMySQLUniProvider;
    UniConnection1: TUniConnection;
    cxPropertiesStore1: TcxPropertiesStore;
  private
    { Private declarations }
  public
    { Public declarations }
    function TestConnection(const aServer, aDatabaseName, aUsername,
      aPassword: string; aPort: integer): Boolean;
   
  end;

var
  DataContainer: TDataContainer;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TDataContainer }


function TDataContainer.TestConnection(const aServer, aDatabaseName, aUsername,
  aPassword: string; aPort: integer): Boolean;
begin
  with UniConnection1 do
  begin
    Connected := false;
    Server := aServer;
    Database := aDatabaseName;
    Username := aUsername;
    Password := aPassword;
    Port := aPort;
    try
      Connected := true;
      result := Connected;

    except
      on e: EDatabaseError do

        result := false

    end;

  end;

end;

end.
