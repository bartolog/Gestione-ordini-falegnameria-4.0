unit USettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxCoreGraphics, dxShellDialogs,
  cxClasses, cxPropertiesStore, cxTextEdit, cxMaskEdit, cxButtonEdit,
  Vcl.StdCtrls;

type
  TdlgSettings = class(TForm)
    edtPathPantografo: TcxButtonEdit;
    edtPathBordatrice: TcxButtonEdit;
    cxPropertiesStore1: TcxPropertiesStore;
    Label1: TLabel;
    Label2: TLabel;
    FileOpenDialog1: TFileOpenDialog;
    procedure edtPathPantografoPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgSettings: TdlgSettings;

implementation

{$R *.dfm}

procedure TdlgSettings.edtPathPantografoPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
     if  FileOpenDialog1.Execute then
     (sender as TcxButtonEdit).Text := FileOpenDialog1.FileName
end;

end.
