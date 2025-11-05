unit UGridFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Vcl.StdCtrls, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList,
  cxImageList,
  cxDropDownEdit, Generics.Collections, cxTextEdit, Vcl.Menus;

type

  TMyPopMenuItem = class
  private
    FCaption: string;
    FProc: TNotifyEvent;

  public

    property Caption: String read FCaption write FCaption;
    property Proc: TNotifyEvent read FProc write FProc;

  end;

  TSetPropertiesProc = reference to procedure(aItem: TcxCustomGridTableItem);

  TMyGridItem = class
  private
    FName: string;
    FCaption: string;
    FProperties: TSetPropertiesProc;
    FInitProc: TSetPropertiesProc;
    FVisibile: Boolean;

  public

    constructor create(aName, aCaption: string; aProperties: TSetPropertiesProc;
      aInitProc: TSetPropertiesProc);

    property Name: string read FName write FName;
    property Caption: string read FCaption write FCaption;
    property Properties: TSetPropertiesProc read FProperties write FProperties;
    property InitProc: TSetPropertiesProc read FInitProc write FInitProc;
    property Visibile: Boolean read FVisibile write FVisibile;

  end;

  TGridColumnsNames = Tlist<TMyGridItem>;
  TPopMenuItems = Tlist<TMyPopMenuItem>;

  IMasterDetailUnboundedGrid = interface
    ['{9730AD26-176A-43F8-84C2-A2259A814D5C}']
    function GetMasterColumns: TGridColumnsNames;
    function GetDetailColumns: TGridColumnsNames;
    procedure SetDataMasterView(aMasterView: TcxGridTableView);
    procedure SaveDataMasterView(aMasterView: TcxGridTableView );
    procedure DeleteData ( aListOfDeletedObjects : Tlist<Tobject>);

    procedure ExtraButtonProc(aMasterView: TcxGridTableView);
      procedure Refresh(aMasterView: TcxGridTableView);

  end;

  TGridFrame = class(TFrame)
    cxGrid1: TcxGrid;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1Level2: TcxGridLevel;
    MasterView: TcxGridTableView;
    DetailView: TcxGridTableView;
    Panel1: TPanel;
    btnSave: TButton;
    cxImageList1: TcxImageList;
    btnProduzione: TButton;
    btnRefresh: TButton;
    procedure btnSaveClick(Sender: TObject);
    procedure btnProduzioneClick(Sender: TObject);

    procedure btnRefreshClick(Sender: TObject);
    procedure MasterViewDataControllerBeforeDelete(
      ADataController: TcxCustomDataController; ARecordIndex: Integer);

  private
    { Private declarations }
    FGridManager: IMasterDetailUnboundedGrid;
    FDeletedObject : TList<Tobject>;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure CreateDataInterace(aMasterDetailUnboundedInterface
      : IMasterDetailUnboundedGrid);

      property DeletedObject : TList<TObject> read FDeletedObject;

  end;

implementation

{$R *.dfm}

uses UEntitiesModel;
{ TGridFrame }

procedure TGridFrame.btnProduzioneClick(Sender: TObject);
begin
  FGridManager.ExtraButtonProc(MasterView)
end;

procedure TGridFrame.btnRefreshClick(Sender: TObject);
begin
     FGridManager.Refresh(MasterView)
end;

procedure TGridFrame.btnSaveClick(Sender: TObject);
begin
  FGridManager.SaveDataMasterView(MasterView)   ;
  FGridManager.DeleteData(FDeletedObject)  ;

end;

constructor TGridFrame.Create(AOwner: TComponent);
begin
  inherited;
  FDeletedObject := TList<TObject>.Create
end;

procedure TGridFrame.CreateDataInterace(aMasterDetailUnboundedInterface
  : IMasterDetailUnboundedGrid);

var
  lItem: TcxCustomGridTableItem;
begin

  MasterView.ClearItems;

  var
  a := aMasterDetailUnboundedInterface.GetMasterColumns;
  try
    for var I in a do
      with MasterView do
      begin
        lItem := CreateItem;
        lItem.name := I.name;
        lItem.Caption := I.Caption;
        lItem.Visible := I.Visibile;
        TcxGridColumn(lItem).Width := 180;

        if Assigned(I.Properties) then
          I.Properties(lItem);

        if Assigned(I.FInitProc) then
          I.FInitProc(lItem);
        I.Free
      end;

  finally
    a.Free

  end;
  DetailView.ClearItems;
  a := aMasterDetailUnboundedInterface.GetDetailColumns;
  cxGrid1Level2.Visible := a.Count > 0;
  // se ci sono colonne allora rende visibile il livello

  try
    for var I in a do
      with DetailView do
      begin

        lItem := CreateItem;
        lItem.name := I.name;
        lItem.Caption := I.Caption;
        TcxGridColumn(lItem).Width := 200;
        lItem.Visible := I.Visibile;
        if Assigned(I.Properties) then
          I.Properties(lItem);

        if Assigned(I.FInitProc) then
          I.FInitProc(lItem);

        I.Free
      end;

  finally
    a.Free
  end;

  aMasterDetailUnboundedInterface.SetDataMasterView(MasterView);

  FGridManager := aMasterDetailUnboundedInterface

end;




destructor TGridFrame.Destroy;
begin
  FDeletedObject.Free;
  inherited;
end;

procedure TGridFrame.MasterViewDataControllerBeforeDelete(
  ADataController: TcxCustomDataController; ARecordIndex: Integer);
begin
    var ok := false;
     var o : tobject;
    for var I := 0 to  MasterView.ItemCount - 1 do
        if MasterView.Items[I].Caption = 'Object' then
        begin
           o := Tobject(integer(ADataController.Values[ARecordIndex,MasterView.Items[I].Index]));
          ok := true

        end;
        if ok  then
        begin
          FDeletedObject.Add(o)
        // ShowMessage(  o.classname       )
        end;



end;

constructor TMyGridItem.create(aName, aCaption: string;
  aProperties: TSetPropertiesProc; aInitProc: TSetPropertiesProc);
begin
  inherited create;
  FName := aName;
  FCaption := aCaption;
  FProperties := aProperties;
  FInitProc := aInitProc;
  FVisibile := true

end;

end.
