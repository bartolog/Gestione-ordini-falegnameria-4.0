unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Aurelius.Comp.Connection,
  Aurelius.Engine.ObjectManager, Aurelius.Linq, Data.DB, DBAccess, Uni,
  Aurelius.Comp.Manager, Aurelius.Drivers.UniDac, UniProvider, MySQLUniProvider ;

type
  TForm1 = class(TForm)
    AureliusConnection1: TAureliusConnection;
    AureliusManager1: TAureliusManager;
    UniConnection1: TUniConnection;
    MySQLUniProvider1: TMySQLUniProvider;
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
