unit AboutDialog;



// unit AboutDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, WUpdate, System.ImageList,
  Vcl.ImgList, cxImageList, cxGraphics;

type
  TfrmAbout = class(TForm)
    lblAppName: TLabel;
    lblVersion: TLabel;
    lblCompany: TLabel;
    lblDescription: TLabel;
    btnCheckUpDate: TButton;
    WebUpdate1: TWebUpdate;
    cxImageList1: TcxImageList;
    procedure FormCreate(Sender: TObject);
    procedure btnCheckUpDateClick(Sender: TObject);
  private
//    function GetVersionInfo: string;
  end;

procedure ShowAboutDialog;

implementation

{$R *.dfm}

procedure ShowAboutDialog;
begin
  with TfrmAbout.Create(nil) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

{ TfrmAbout }

procedure TfrmAbout.btnCheckUpDateClick(Sender: TObject);
begin
    with WebUpdate1 do
    begin
    if NewVersionAvailable() then
     DoUpdate
    else
      with TTaskDialog.Create(nil) do
      begin
        Caption := 'Programmazione troncatrici';
        Title := 'Controllo aggiornamenti';

        Text := 'Il programma risulta aggiornato all''ultima versione';
        CommonButtons := [tcbOk];
        MainIcon := tdiInformation;

        Execute;

        Free
      end;

    end;
end;

procedure TfrmAbout.FormCreate(Sender: TObject);
var
  VerInfoSize, VerValueSize, Dummy: DWORD;
  VerInfo: Pointer;
  VerValue: PVSFixedFileInfo;
  Major, Minor, Release, Build: Word;
  CompanyName, FileDescription: string;
  Buffer: PChar;
  BufLen: UINT;
begin
  Caption := 'Informazioni su';
  lblAppName.Caption := ExtractFileName(Application.ExeName);

  VerInfoSize := GetFileVersionInfoSize(PChar(Application.ExeName), Dummy);
  if VerInfoSize > 0 then
  begin
    GetMem(VerInfo, VerInfoSize);
    try
      if GetFileVersionInfo(PChar(Application.ExeName), 0, VerInfoSize, VerInfo) then
      begin
        if VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize) then
        begin
          Major := HiWord(VerValue.dwFileVersionMS);
          Minor := LoWord(VerValue.dwFileVersionMS);
          Release := HiWord(VerValue.dwFileVersionLS);
          Build := LoWord(VerValue.dwFileVersionLS);
          lblVersion.Caption := Format('Versione: %d.%d.%d.%d', [Major, Minor, Release, Build]);
        end;

        if VerQueryValue(VerInfo, '\StringFileInfo\040904E4\CompanyName', Pointer(Buffer), BufLen) then
          CompanyName := Buffer;
        if VerQueryValue(VerInfo, '\StringFileInfo\040904E4\FileDescription', Pointer(Buffer), BufLen) then
          FileDescription := Buffer;

        lblCompany.Caption := 'Azienda: ' + CompanyName;
        lblDescription.Caption := FileDescription;
      end;
    finally
      FreeMem(VerInfo, VerInfoSize);
    end;
  end;
end;

//function TfrmAbout.GetVersionInfo: string;
//var
//  VerInfoSize, VerValueSize, Dummy: DWORD;
//  VerInfo: Pointer;
//  VerValue: PVSFixedFileInfo;
//  Major, Minor, Release, Build: Word;
//begin
//  Result := '';
//  VerInfoSize := GetFileVersionInfoSize(PChar(Application.ExeName), Dummy);
//  if VerInfoSize > 0 then
//  begin
//    GetMem(VerInfo, VerInfoSize);
//    try
//      if GetFileVersionInfo(PChar(Application.ExeName), 0, VerInfoSize, VerInfo) then
//        if VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize) then
//        begin
//          Major := HiWord(VerValue.dwFileVersionMS);
//          Minor := LoWord(VerValue.dwFileVersionMS);
//          Release := HiWord(VerValue.dwFileVersionLS);
//          Build := LoWord(VerValue.dwFileVersionLS);
//          Result := Format('%d.%d.%d.%d', [Major, Minor, Release, Build]);
//        end;
//    finally
//      FreeMem(VerInfo, VerInfoSize);
//    end;
//  end;
//end;


end.


