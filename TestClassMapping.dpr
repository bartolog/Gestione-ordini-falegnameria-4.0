program TestClassMapping;

uses
  {$IFDEF EurekaLog}
  EMemLeaks,
  EResLeaks,
  EDebugJCL,
  EDebugExports,
  EFixSafeCallException,
  EMapWin32,
  EAppVCL,
  EDialogWinAPIMSClassic,
  EDialogWinAPIEurekaLogDetailed,
  EDialogWinAPIStepsToReproduce,
  ExceptionLog7,
  {$ENDIF EurekaLog}
  Vcl.Forms,
  UMainForm in 'UMainForm.pas' {frmMain},
  UEntitiesModel in 'UEntitiesModel.pas',
  Uprodotto in 'Uprodotto.pas' {frmProdotto},
  UData in 'UData.pas' {DataContainer: TDataModule},
  UGridFrame in 'UGridFrame.pas' {GridFrame: TFrame},
  USettings in 'USettings.pas' {dlgSettings};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataContainer, DataContainer);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmProdotto, frmProdotto);
  Application.CreateForm(TdlgSettings, dlgSettings);
  Application.Run;
end.

