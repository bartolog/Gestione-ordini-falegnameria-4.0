unit UMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Aurelius.Comp.Connection,
  Aurelius.Engine.ObjectManager, Aurelius.Linq, Data.DB, DBAccess, Uni,
  Aurelius.Comp.Manager, Aurelius.Drivers.UniDac, UniProvider, MySQLUniProvider,
  Aurelius.Sql.MySQL,
  Vcl.StdCtrls, UEntitiesModel, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxTextEdit, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxNavigator, dxDateRanges,
  dxScrollbarAnnotations, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, UData,
  Uprodotto, Vcl.ExtCtrls, UGridFrame, System.ImageList, Vcl.ImgList,
  cxImageList, cxSplitter, Generics.Collections, USettings;

type
  TReportInfo = class
    FA: string;
    FB: string;
    FC: string;
    FD: string;
    FE: string;
    FF: string;
    FG: string;
    FH: string;
    FI: string;
    FJ: string;
    FK: string;
    FL: string;
    FM: string;
    FN: string;
    FO: string;
  end;

  TOrdersData = class(TInterfacedObject, IMasterDetailUnboundedGrid)
    function GetMasterColumns: TGridColumnsNames;
    function GetDetailColumns: TGridColumnsNames;
    procedure SetDataMasterView(aMasterView: TcxGridTableView);
    procedure SaveDataMasterView(aMasterView: TcxGridTableView);
    procedure ExtraButtonProc(aMasterView: TcxGridTableView);
    procedure Refresh(aMasterView: TcxGridTableView);
    procedure DeleteData(aListOfDeletedObjects: Tlist<Tobject>);

  end;

  TProductData = class(TInterfacedObject, IMasterDetailUnboundedGrid)
    function GetMasterColumns: TGridColumnsNames;
    function GetDetailColumns: TGridColumnsNames;
    procedure SetDataMasterView(aMasterView: TcxGridTableView);
    procedure SaveDataMasterView(aMasterView: TcxGridTableView);
    procedure ExtraButtonProc(aMasterView: TcxGridTableView);
    procedure Refresh(aMasterView: TcxGridTableView);
    procedure DeleteData(aListOfDeletedObjects: Tlist<Tobject>);
  end;

  TProductionData = class(TInterfacedObject, IMasterDetailUnboundedGrid)
    function GetMasterColumns: TGridColumnsNames;
    function GetDetailColumns: TGridColumnsNames;
    procedure SetDataMasterView(aMasterView: TcxGridTableView);
    procedure SaveDataMasterView(aMasterView: TcxGridTableView);
    procedure ExtraButtonProc(aMasterView: TcxGridTableView);
    procedure Refresh(aMasterView: TcxGridTableView);
    procedure DeleteData(aListOfDeletedObjects: Tlist<Tobject>);
  end;

  TPartData = class(TInterfacedObject, IMasterDetailUnboundedGrid)
    function GetMasterColumns: TGridColumnsNames;
    function GetDetailColumns: TGridColumnsNames;
    procedure SetDataMasterView(aMasterView: TcxGridTableView);
    procedure SaveDataMasterView(aMasterView: TcxGridTableView);
    procedure ExtraButtonProc(aMasterView: TcxGridTableView);
    procedure Refresh(aMasterView: TcxGridTableView);
    procedure DeleteData(aListOfDeletedObjects: Tlist<Tobject>);
  end;

  TfrmMain = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btnCreateFrame: TButton;
    btnFrameProducts: TButton;
    btnProduction: TButton;
    cxImageList1: TcxImageList;
    btnSettings: TButton;
    Button1: TButton;
    memoLog: TMemo;
    cxSplitter1: TcxSplitter;
    procedure FormCreate(Sender: Tobject);
    procedure btnCreaProdottoClick(Sender: Tobject);
    procedure btnCaricaClick(Sender: Tobject);
    procedure btnSalvaTuttoClick(Sender: Tobject);
    procedure btnProdottoClick(Sender: Tobject);
    procedure OrdersViewDataControllerBeforeDelete(ADataController
      : TcxCustomDataController; ARecordIndex: Integer);
    procedure OrdersViewDataControllerBeforePost(ADataController
      : TcxCustomDataController);
    procedure OrderDetailViewDataControllerBeforeDelete(ADataController
      : TcxCustomDataController; ARecordIndex: Integer);
    procedure btnCreateFrameClick(Sender: Tobject);
    procedure btnSettingsClick(Sender: Tobject);
  private
    { Private declarations }

  public
    { Public declarations }

    Function GetLogReport(aPath: string): Tlist<TReportInfo>;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
  Aurelius.Engine.DatabaseManager, Aurelius.Schema.MySQL,
  cxProgressBar, cxCheckBox, IOUtils;

var
  lo: Tlist<TOrdine>;
  lp: Tlist<TProdotto>;
  frmGrid: TGridFrame;

procedure TfrmMain.btnCaricaClick(Sender: Tobject);
// var
// dw: TcxCustomDataController;
begin


  // if Assigned(lo) then lo.Free;

  // lo := DataContainer.AureliusManager1.Find<TOrdine>.List;
  //
  // try
  //
  // OrdersView.DataController.RecordCount := 0;
  //
  // OrdersView.BeginUpdate();
  // try
  // for var o in lo do
  // begin
  // with OrdersView.DataController do
  // begin
  // var
  // r := AppendRecord;
  //
  // Values[r, OrdersViewIdOrder.Index] := o.ID;
  // Values[r, OrdersViewCliente.Index] := o.Cliente.Nome;
  // Values[r, OrdersViewData.Index] := o.Data;
  // Values[r, OrdersViewScadenza.Index] := o.Scadenza;
  // Values[r, OrdersViewObject.Index] := Integer(o);
  // dw := GetDetailDataController(r, 0);
  // end;
  //
  // for var a in o.Articoli do
  // begin
  //
  // with dw do
  // begin
  // var
  // rd := AppendRecord;
  //
  // Values[rd, OrderDetailViewIdOrder.Index] := a.ID_Ordine.ID;
  // Values[rd, OrderDetailViewProdotto.Index] :=
  // a.ID_Prodotto.Descrizione;
  // Values[rd, OrderDetailViewQta.Index] := a.Qta;
  // Values[rd, OrderDetailViewIdArticolo.Index] := a.ID;
  // Values[rd, OrderDetailViewObject.Index] := Integer(a)
  //
  // end;
  // end;
  //
  // end;
  //
  // finally
  // OrdersView.EndUpdate
  // end;
  //
  // finally
  // lo.Free
  // end;
end;

procedure TfrmMain.btnCreaProdottoClick(Sender: Tobject);
begin

  // *** Crea Prodotto (armnadio , cucina, etc...
  var
  p := TProdotto.Create;
  p.Descrizione := 'Armadio modello marte';

  // *** Crea le parti che compongono vari modelli
  var
  prt := Tparte.Create;
  prt.Descrizione := 'Anta sx mod.venere';
  prt.MachineFile := 'Anta_sx_venere.hop';

  // *** Crea componente per il singolo prodotto
  var
  c := TComponente.Create;
  c.Qta := 1;
  c.ID_Prodotto := p;
  c.ID_Parte := prt;

  // aggiungo nella lista dei componenti(distinta)
  p.Componenti.Add(c);

  // *** Crea le parti che compongono vari modelli
  prt := Tparte.Create;
  prt.Descrizione := 'Anta dx mod.venere';
  prt.MachineFile := 'Anta_dx_venere.hop';

  // *** Crea componente per il singolo prodotto
  c := TComponente.Create;
  c.Qta := 1;
  c.ID_Prodotto := p;
  c.ID_Parte := prt;

  // aggiungo nella lista dei componenti(distinta)
  p.Componenti.Add(c);

  // ********************** Creazione di un ordine ***********
  // ...il  Cliente
  var
  cl := TCliente.Create;
  cl.Nome := 'Giorgio Bartolomeo';

  // ...l'ordine
  var
  o := TOrdine.Create;
  o.Cliente := cl;
  o.Data := Now;
  o.Scadenza := Now + 10;

  // ...articolo
  var
  art := TArticolo.Create;
  art.Qta := 1;
  art.ID_Ordine := o;
  art.ID_Prodotto := p;

  // aggiungo all'ordine l'articolo appena creato
  o.Articoli.Add(art);

  with DataContainer do
  begin

    AureliusManager1.Save(p); // salvo il prodotto
    AureliusManager1.Save(cl); // salvo il cliente
    AureliusManager1.Save(o); // e salvo l'ordine

    AureliusManager1.Flush;

  end;
  showmessage('Ok')
end;

procedure TfrmMain.btnCreateFrameClick(Sender: Tobject);
begin

  if Assigned(frmGrid) then
  begin
    // frmGrid.Free;
    FreeAndNil(frmGrid)
  end;

  if not Assigned(frmGrid) then
  begin
    frmGrid := TGridFrame.Create(Self);
    if (Sender as TButton).Tag = 0 then // orders
      frmGrid.CreateDataInterace(TOrdersData.Create);
    if (Sender as TButton).Tag = 1 then // prodotti
      frmGrid.CreateDataInterace(TProductData.Create);
    if (Sender as TButton).Tag = 3 then // produzione
      frmGrid.CreateDataInterace(TProductionData.Create);
    if (Sender as TButton).Tag = 4 then // parti
      frmGrid.CreateDataInterace(TPartData.Create);

  end;

  frmGrid.Parent := Panel2;
  frmGrid.Align := alClient;

end;

procedure TfrmMain.btnProdottoClick(Sender: Tobject);
begin
  frmProdotto.Show
end;

procedure TfrmMain.btnSalvaTuttoClick(Sender: Tobject);
begin
  {
    with OrdersView.DataController do
    begin
    var
    r := RecordCount - 1; // i records da  navigare

    var // oggetto ordine che sarà salvato/aggiornato
    o: TOrdine;

    // per ogni riga ordine 1° livello
    for var I := 0 to r do
    begin

    var
    v := Values[I, OrdersViewIdOrder.Index]; // id ordine
    if VarIsNull(v) then
    o := TOrdine.Create // nuovo ordine
    else
    // ordine esistente
    o := TOrdine(Integer(Values[I, OrdersViewObject.Index]));

    v := Values[I, OrdersViewCliente.Index];

    var
    c := (OrdersViewCliente.Properties as TcxComboBoxProperties);

    o.Cliente := TCliente(c.Items.Objects[c.Items.IndexOf(v)]);

    var
    s := Values[I, OrdersViewData.Index];
    o.Data := strtodatetime(s);

    s := Values[I, OrdersViewScadenza.Index];
    o.Scadenza := strtodatetime(s);

    var
    dv := OrdersView.DataController.GetDetailDataController(I, 0);
    for var j := 0 to dv.RecordCount - 1 do
    begin

    v := dv.Values[j, OrderDetailViewIdArticolo.Index];

    var
    a: TArticolo;
    if VarIsNull(v) then

    begin
    a := TArticolo.Create;
    o.Articoli.Add(a);
    end
    else
    a := DataContainer.AureliusManager1.Find<TArticolo>.Add
    (Dic.Articolo.ID = v).UniqueResult;

    c := (OrderDetailViewProdotto.Properties as TcxComboBoxProperties);
    v := dv.Values[j, OrderDetailViewProdotto.Index];
    a.ID_Prodotto := TProdotto(c.Items.Objects[c.Items.IndexOf(v)]);
    a.Qta.Value := dv.Values[j, OrderDetailViewQta.Index];
    a.ID_Ordine := o;

    end;

    with DataContainer do
    begin

    if AureliusManager1.IsAttached(o) then
    AureliusManager1.Update(o)
    else
    AureliusManager1.Save(o);

    end;

    end;

    DataContainer.AureliusManager1.Flush;
    end; }

end;

procedure TfrmMain.btnSettingsClick(Sender: Tobject);
begin
  dlgSettings.ShowModal
end;

procedure TfrmMain.FormCreate(Sender: Tobject);
 var
 dbmngr: TDatabaseManager;
begin

  memoLog.Clear;
   dbmngr := TDatabaseManager.Create
   (DataContainer.AureliusConnection1.CreateConnection);

   try
   dbmngr.BuildDatabase;

   finally
   dbmngr.Free
   end;

  { var
    cl := DataContainer.AureliusManager1.Find<TCliente>.List;
    try
    for var c in cl do
    begin

    (OrdersViewCliente.Properties as TcxComboBoxProperties)
    .Items.AddObject(c.Nome, c)

    end;
    finally
    cl.Free
    end;

    var
    pr := DataContainer.AureliusManager1.Find<TProdotto>.List;
    try
    for var p in pr do
    begin

    (OrderDetailViewProdotto.Properties as TcxComboBoxProperties)
    .Items.AddObject(p.Descrizione, p)

    end;
    finally
    pr.Free
    end; }

end;

function TfrmMain.GetLogReport(aPath: string): Tlist<TReportInfo>;
var
  t: TextFile;
  y, m, d: word;
begin

  DecodeDate(Now, y, m, d);
  var
  f := Format('Orders_%.2d_%.2d_%.4d.csv', [d, m, y]);
  f := Tpath.Combine(aPath, f);
  if not fileexists(f) then
    raise Exception.Create('Report non trovato!!!');
  result := Tlist<TReportInfo>.Create;

  AssignFile(t, f);
  Reset(t);
  try
    var
      l: string;
    while not eof(t) do
    begin
      Readln(t, l);
      var
      a := l.Split([';']);
      var
      r := TReportInfo.Create;

      r.FA := a[0];
      r.FB := a[1];
      r.FC := a[2];

      r.FD := a[3];
      r.FE := a[4];
      r.FF := a[5];

      r.FG := a[6];
      r.FH := a[7];
      r.FI := a[8];

      r.FJ := a[9];
      r.FK := a[10];
      r.FL := a[11];

      r.FM := a[12];
      r.FN := a[13];
      r.FO := a[14];

      result.Add(r)

    end;

  finally
    CloseFile(t)
  end;

end;

procedure TfrmMain.OrderDetailViewDataControllerBeforeDelete(ADataController
  : TcxCustomDataController; ARecordIndex: Integer);
begin
  { with ADataController do
    begin
    var
    r := ARecordIndex; // record interessato
    var
    v := Values[r, OrderDetailViewIdArticolo.Index]; // eventuale id se presente
    if not VarIsNull(v) then
    begin

    var
    a := TArticolo(Integer(Values[r, OrderDetailViewObject.Index]));
    var
    o := a.ID_Ordine;
    o.DeleteArticoloById(v);

    DataContainer.AureliusManager1.Remove(a)

    end;
    end; }

end;

procedure TfrmMain.OrdersViewDataControllerBeforeDelete(ADataController
  : TcxCustomDataController; ARecordIndex: Integer);
begin {
    with OrdersView.DataController do
    begin
    var
    r := GetFocusedRecordIndex;
    var
    o := TOrdine(Integer(Values[r, OrdersViewObject.Index]));
    lo.Remove(o);
    DataContainer.AureliusManager1.Remove(o);
    end; }

end;

procedure TfrmMain.OrdersViewDataControllerBeforePost(ADataController
  : TcxCustomDataController);
begin {
    with OrdersView.DataController do
    begin
    var
    r := GetFocusedRecordIndex;
    var
    v := Values[r, OrdersViewCliente.Index];

    end; }
end;

procedure TOrdersData.DeleteData(aListOfDeletedObjects: Tlist<Tobject>);
begin
  for var o in aListOfDeletedObjects do
    DataContainer.AureliusManager1.Remove(o);

  DataContainer.AureliusManager1.Flush
end;

procedure TOrdersData.ExtraButtonProc(aMasterView: TcxGridTableView);
begin
  with aMasterView.DataController do
  begin
    var
    v := Values[FocusedRecordIndex, 0]; // id ordine
    var

      // recupera l'oggetto
    o := DataContainer.AureliusManager1.Find<TOrdine>.Where(Dic.Ordine.ID = v)
      .UniqueResult;
    // per ogni articolo in ordine
    for var a in o.Articoli do
    begin

      // prendo il prodotto agganciato all'articolo in ordine
      var
      p := a.ID_Prodotto;

      // per ogni componente del prodotto  qta_componente * qtaordine
      for var c in p.Componenti do
      begin
        var // creo l'articolo di produzione
        op := TArticoloProduzione.Create;
        op.ID_Articolo := a;
        op.QtaInOrdine := a.Qta;
        op.QtaParteRichiesta.Value := op.QtaInOrdine.Value * c.Qta.Value;
        op.QtaProdotta.Value := 0;
        op.ID_Parte := c.ID_Parte;

        DataContainer.AureliusManager1.Save(op);
      end;

    end;

    DataContainer.AureliusManager1.Flush;

    showmessage('Ordine id ' + vartostr(v) + ' inviato in produzione');

  end;

end;

{ TMasterDetailUnboundedData }

function TOrdersData.GetDetailColumns: TGridColumnsNames;
var
  I: TMyGridItem;
begin

  // Result := ['Id_articolo' ,'Id_Ordine',  'Prodotto', 'Qta',  'Object']

  result := Tlist<TMyGridItem>.Create;

  I := TMyGridItem.Create('OrderDetailId_Articolo', 'Id_Articolo', nil, nil);
  I.Visibile := false;
  result.Add(I);

  I := TMyGridItem.Create('OrderDetailId_Ordine', 'Id_Ordine', nil, nil);
  I.Visibile := false;
  result.Add(I);

  var
    p: TSetPropertiesProc;

  p := procedure(aItem: TcxCustomGridTableItem)
    begin
      aItem.PropertiesClass := TcxComboBoxProperties

    end;

  I := TMyGridItem.Create('OrderDetailProdotto', 'Prodotto', p,
    procedure(aItem: TcxCustomGridTableItem)
    begin
      var
      pr := DataContainer.AureliusManager1.Find<TProdotto>.List;
      try
        for var p in pr do
        begin

          (aItem.Properties as TcxComboBoxProperties)
            .Items.AddObject(p.Descrizione, p)

        end;
      finally
        pr.Free
      end
    end);

  result.Add(I);
  I := TMyGridItem.Create('OrderDetailQta', 'Quantità', nil, nil);
  result.Add(I);

  I := TMyGridItem.Create('OrderDetailObject', 'Object', nil, nil);
  I.Visibile := false;
  result.Add(I);

end;

function TOrdersData.GetMasterColumns: TGridColumnsNames;
begin
  // SetLength(Result, 5);
  // Result := ['Id',  'Cliente', 'Data', 'Scadenza','Object']

  result := Tlist<TMyGridItem>.Create;

  var
  I := TMyGridItem.Create('OrderID', 'ID', nil, nil);
  I.Visibile := false;
  result.Add(I);

  var
    p: TSetPropertiesProc;

  p := procedure(aItem: TcxCustomGridTableItem)
    begin
      aItem.PropertiesClass := TcxComboBoxProperties
      // aItem.Properties := TcxComboBoxProperties.Create(nil)
    end;

  I := TMyGridItem.Create('OrderCliente', 'Cliente', p,
    procedure(aItem: TcxCustomGridTableItem)

    begin
      var
      cl := DataContainer.AureliusManager1.Find<TCliente>.List;
      try
        for var c in cl do
        begin

          (aItem.Properties as TcxComboBoxProperties).Items.AddObject(c.Nome, c)

        end;
      finally
        cl.Free
      end;

    end);
  result.Add(I);

  p := procedure(aItem: TcxCustomGridTableItem)
    begin
      aItem.PropertiesClass := TcxDateEditProperties

    end;

  I := TMyGridItem.Create('OrderData', 'Data', p, nil);
  result.Add(I);
  I := TMyGridItem.Create('OrderScadenza', 'Scadenza', p, nil);
  result.Add(I);
  I := TMyGridItem.Create('OrderObject', 'Object', nil, nil);
  I.Visibile := false;
  result.Add(I);

end;

procedure TOrdersData.Refresh(aMasterView: TcxGridTableView);
begin

end;

procedure TOrdersData.SaveDataMasterView(aMasterView: TcxGridTableView);
begin
  with aMasterView.DataController do
  begin
    var
    r := RecordCount - 1; // i records da  navigare

    var // oggetto ordine che sarà salvato/aggiornato
      o: TOrdine;

      // per ogni riga ordine 1° livello
    for var I := 0 to r do
    begin

      var
      v := Values[I, 0]; // id ordine
      if VarIsNull(v) then
        o := TOrdine.Create // nuovo ordine
      else
        // ordine esistente
        o := TOrdine(Integer(Values[I, 4]));

      v := Values[I, 1];

      var
      c := (TcxCustomGridTableItem(GetItem(1))
        .Properties as TcxComboBoxProperties);

      o.Cliente := TCliente(c.Items.Objects[c.Items.IndexOf(v)]);

      var
      s := Values[I, 2];
      o.Data := strtodatetime(s);

      s := Values[I, 3];
      o.Scadenza := strtodatetime(s);

      var
      dv := GetDetailDataController(I, 0);
      //
      for var j := 0 to dv.RecordCount - 1 do
      begin

        v := dv.Values[j, 0]; // articolo

        var
          a: TArticolo;
        if VarIsNull(v) then

        begin
          a := TArticolo.Create;
          o.Articoli.Add(a);
        end
        else
          a := DataContainer.AureliusManager1.Find<TArticolo>.Add
            (Dic.Articolo.ID = v).UniqueResult;

        c := (TcxCustomGridTableItem(dv.GetItem(2))
          .Properties as TcxComboBoxProperties);
        v := dv.Values[j, 2];
        a.ID_Prodotto := TProdotto(c.Items.Objects[c.Items.IndexOf(v)]);
        a.Qta.Value := dv.Values[j, 3]; // qta articolo
        a.ID_Ordine := o;

      end;

      with DataContainer do
      begin

        if AureliusManager1.IsAttached(o) then
          AureliusManager1.Update(o)
        else
          AureliusManager1.Save(o);

      end;

    end;

    if True then

      DataContainer.AureliusManager1.Flush;
  end;

end;

procedure TOrdersData.SetDataMasterView(aMasterView: TcxGridTableView);
var
  dw: TcxCustomDataController;
begin


  // if Assigned(lo) then lo.Free;

  lo := DataContainer.AureliusManager1.Find<TOrdine>.List;

  try

    aMasterView.DataController.RecordCount := 0;

    aMasterView.BeginUpdate();
    try
      for var o in lo do
      begin
        with aMasterView.DataController do
        begin
          var
          r := AppendRecord;

          Values[r, 0] := o.ID;
          Values[r, 1] := o.Cliente.Nome;
          Values[r, 2] := o.Data;
          Values[r, 3] := o.Scadenza;
          Values[r, 4] := Integer(o);
          dw := GetDetailDataController(r, 0);
        end;

        for var a in o.Articoli do
        begin

          with dw do
          begin
            var
            rd := AppendRecord;
            Values[rd, 0] := a.ID;
            Values[rd, 1] := a.ID_Ordine.ID;

            Values[rd, 2] := a.ID_Prodotto.Descrizione;
            Values[rd, 3] := a.Qta;

            Values[rd, 4] := Integer(a)

          end;
        end;

      end;

    finally
      aMasterView.EndUpdate
    end;

  finally
    lo.Free
  end;
end;

{ TProductData }

procedure TProductData.DeleteData(aListOfDeletedObjects: Tlist<Tobject>);
begin
  for var o in aListOfDeletedObjects do
    DataContainer.AureliusManager1.Remove(o);

  DataContainer.AureliusManager1.Flush
end;

procedure TProductData.ExtraButtonProc(aMasterView: TcxGridTableView);
begin

end;

function TProductData.GetDetailColumns: TGridColumnsNames;
var
  I: TMyGridItem;
begin

  // Result := ['ID_Componente' ,'Id_Prodotto',  'ID_Parte', 'Qta',  'Object']

  result := Tlist<TMyGridItem>.Create;

  // id del componente
  I := TMyGridItem.Create('ProductDetailId_Componednte', 'Id_Componente',
    nil, nil);
  I.Visibile := false;
  result.Add(I);

  // id del prodotto
  I := TMyGridItem.Create('ProductDetailId_Prodotto', 'Id_Prodotto', nil, nil);
  I.Visibile := false;
  result.Add(I);

  // item : parte (combo box)
  var
    p: TSetPropertiesProc;

  p := procedure(aItem: TcxCustomGridTableItem)
    begin
      aItem.PropertiesClass := TcxComboBoxProperties

    end;

  I := TMyGridItem.Create('ProductDetailParte', 'Parte', p,
    procedure(aItem: TcxCustomGridTableItem)
    begin
      var
      pr := DataContainer.AureliusManager1.Find<Tparte>.List;
      try
        for var p in pr do
        begin

          (aItem.Properties as TcxComboBoxProperties)
            .Items.AddObject(p.Descrizione, p)

        end;
      finally
        pr.Free
      end
    end);

  result.Add(I);

  // colonna (item) quantità componente

  I := TMyGridItem.Create('ProductDetailQta', 'Quantità', nil, nil);
  result.Add(I);


  // colonna (item) oggetto componente

  I := TMyGridItem.Create('ProductDetailObject', 'Object', nil, nil);
  I.Visibile := false;
  result.Add(I);


  // colonna (item) quantità componente

  I := TMyGridItem.Create('ProductDetailProgramFile', 'File programma',
    nil, nil);
  result.Add(I);

end;

function TProductData.GetMasterColumns: TGridColumnsNames;
begin
  result := Tlist<TMyGridItem>.Create;

  var
  I := TMyGridItem.Create('ProductID', 'ID', nil, nil);
  I.Visibile := false;
  result.Add(I);
  I := TMyGridItem.Create('ProductProdotto', 'Prodotto', nil, nil);
  result.Add(I);
  I := TMyGridItem.Create('ProductObject', 'Object', nil, nil);
  I.Visibile := false;
  result.Add(I);



  // var
  // p: TSetPropertiesProc;
  //
  // p := procedure(aItem: TcxCustomGridTableItem)
  // begin
  // aItem.PropertiesClass := TcxComboBoxProperties
  //
  // end;
  //
  // I := TMyGridItem.Create('ProductProdotto', 'Prodotto', p,
  // procedure(aItem: TcxCustomGridTableItem)
  //
  // begin
  // var
  // cl := DataContainer.AureliusManager1.Find<TProdotto>.List;
  // try
  // for var c in cl do
  // begin
  //
  // (aItem.Properties as TcxComboBoxProperties)
  // .Items.AddObject(c.Descrizione, c)
  //
  // end;
  // finally
  // cl.Free
  // end;
  //
  // end);
  // result.Add(I);
  //
  // p := procedure(aItem: TcxCustomGridTableItem)
  // begin
  // aItem.PropertiesClass := TcxDateEditProperties
  //
  // end;

end;

procedure TProductData.Refresh(aMasterView: TcxGridTableView);
begin

end;

procedure TProductData.SaveDataMasterView(aMasterView: TcxGridTableView);
begin
  with aMasterView.DataController do
  begin
    var
    r := RecordCount - 1; // i records da  navigare

    var // oggetto prodotto che sarà salvato/aggiornato
      o: TProdotto;

      // per ogni riga ordine 1° livello
    for var I := 0 to r do
    begin

      var
      v := Values[I, 0]; // id Prodotto
      if VarIsNull(v) then
        o := TProdotto.Create // nuovo Prodotto
      else
        // ordine esistente
        o := TProdotto(Integer(Values[I, 2])); // object

      o.Descrizione := Values[I, 1];

      var
      dv := GetDetailDataController(I, 0); // prende la view dettaglio
      //
      for var j := 0 to dv.RecordCount - 1 do
      begin

        v := dv.Values[j, 0]; // id componente

        var
          a: TComponente;
        if VarIsNull(v) then // se non c'è l'id componente

        begin
          a := TComponente.Create; // creo un nuovo componente

          o.Componenti.Add(a); // e lo aggiunge
        end
        else // altrimenti   lo recupera
          a := DataContainer.AureliusManager1.Find<TComponente>.Add
            (Dic.Componente.ID = v).UniqueResult;

        a.ID_Prodotto := o; // metto il prodotto

        a.Qta := dv.Values[j, 3]; // qta componente    da vedere se indice 3

        var
        c := (TcxCustomGridTableItem(dv.GetItem(2)) // oggetto combo parte
          .Properties as TcxComboBoxProperties);
        v := dv.Values[j, 2]; // valore

        a.ID_Parte := Tparte(c.Items.Objects[c.Items.IndexOf(v)]);
      end;

      with DataContainer do
      begin

        if AureliusManager1.IsAttached(o) then
          AureliusManager1.Update(o)
        else
          AureliusManager1.Save(o);

      end;

    end;

    DataContainer.AureliusManager1.Flush;
  end;

end;

procedure TProductData.SetDataMasterView(aMasterView: TcxGridTableView);
var
  dw: TcxCustomDataController;
begin

  // carica tutti i prodotti
  lp := DataContainer.AureliusManager1.Find<TProdotto>.List;

  try

    aMasterView.DataController.RecordCount := 0;

    aMasterView.BeginUpdate();
    try
      for var o in lp do
      begin
        with aMasterView.DataController do
        begin
          var
          r := AppendRecord;

          Values[r, 0] := o.ID; // id prodotto
          Values[r, 1] := o.Descrizione; // descrizione
          Values[r, 2] := Integer(o); // oggetto

          dw := GetDetailDataController(r, 0);
        end;

        for var a in o.Componenti do
        begin

          with dw do
          begin
            var
            rd := AppendRecord;
            Values[rd, 0] := a.ID; // componente
            Values[rd, 1] := a.ID_Prodotto.ID; // prodotto

            Values[rd, 2] := a.ID_Parte.Descrizione; // descrizione della parte
            Values[rd, 3] := a.Qta; // quantità

            Values[rd, 4] := Integer(a); // store dell'oggetto componente
            Values[rd, 5] := a.ID_Parte.MachineFile // file programma

          end;
        end;

      end;

    finally
      aMasterView.EndUpdate
    end;

  finally
    lp.Free
  end;
end;

{ TProductionData }

procedure TProductionData.DeleteData(aListOfDeletedObjects: Tlist<Tobject>);
begin
  for var o in aListOfDeletedObjects do
    DataContainer.AureliusManager1.Remove(o);

  DataContainer.AureliusManager1.Flush
end;

procedure TProductionData.ExtraButtonProc(aMasterView: TcxGridTableView);
begin

end;

function TProductionData.GetDetailColumns: TGridColumnsNames;
begin

  result := Tlist<TMyGridItem>.Create
end;

function TProductionData.GetMasterColumns: TGridColumnsNames;
begin
  result := Tlist<TMyGridItem>.Create;
  var
    p: TSetPropertiesProc;

  var
  I := TMyGridItem.Create('ProductionViewId_Ordine', 'ID_Ordine', nil, nil);
  result.Add(I);

  I := TMyGridItem.Create('ProductionViewQta_Articolo', 'Quantità articolo',
    nil, nil);
  result.Add(I);

  I := TMyGridItem.Create('ProductionViewProdotto', 'Prodotto', nil, nil);
  result.Add(I);

  I := TMyGridItem.Create('ProductionViewId_Parte', 'Id_parte', nil, nil);
  result.Add(I);
  I := TMyGridItem.Create('ProductionViewParte', 'Parte', nil, nil);
  result.Add(I);

  I := TMyGridItem.Create('ProductionViewQtaRichiesta', 'Quantità richiesta',
    nil, nil);
  result.Add(I);

  I := TMyGridItem.Create('ProductionViewQtaOttenuta', 'Quantità ottenuta',
    nil, nil);
  result.Add(I);

  p := procedure(aItem: TcxCustomGridTableItem)
    begin
      aItem.PropertiesClass := TcxProgressBarProperties;

    end;

  I := TMyGridItem.Create('ProductionViewStato', 'Stato', p, nil);
  result.Add(I);

  I := TMyGridItem.Create('ProductionViewObject', 'Object', nil, nil);
  I.Visibile := false;
  result.Add(I);

  I := TMyGridItem.Create('ProductionViewProgramFile', 'File programma',
    nil, nil);
  result.Add(I);

end;

procedure TProductionData.Refresh(aMasterView: TcxGridTableView);
begin
  // cerco il file programma nella cartella di produzione della macchina
  // individuo l'oggetto che contiene quel file macchina
  // e aggiorno la quantità e richiamo la procedura di load data

  // lettura del file csv
  var
  f := 'Fiancata lat. dx mod genova.hop';

  var
  lr := frmMain.GetLogReport(dlgSettings.edtPathPantografo.Text);

  try
    for var r in lr do
    begin
      f := trim(dxExtractFileName(r.FE, '/'));
      frmMain.memoLog.Lines.Add
        (Format('Report %s   --  Start   : %s    End  :  %s ',
        [f, r.FK, r.FL]));

      r.Free  ;


      with DataContainer do
  begin

    var
    ap := AureliusManager1.Find<TArticoloProduzione>.Where
      (Dic.ArticoloProduzione.ID_Parte.MachineFile = f)
      .OrderBy(Dic.ArticoloProduzione.ID).List;
    try
      var
      updated := false;
      for var a in ap do
      begin
        if (not updated) and (a.QtaParteRichiesta > a.QtaProdotta) then
        begin
          a.QtaProdotta.Value := a.QtaProdotta.Value + 1;
          AureliusManager1.Flush(a); // registra la modifica

          updated := True
        end;

      end;

    finally
      ap.Free
    end;
  end;





    end;

  finally

    lr.Free
  end;

  with DataContainer do
  begin

    var
    ap := AureliusManager1.Find<TArticoloProduzione>.Where
      (Dic.ArticoloProduzione.ID_Parte.MachineFile = f)
      .OrderBy(Dic.ArticoloProduzione.ID).List;
    try
      var
      updated := false;
      for var a in ap do
      begin
        if (not updated) and (a.QtaParteRichiesta > a.QtaProdotta) then
        begin
          a.QtaProdotta.Value := a.QtaProdotta.Value + 1;
          AureliusManager1.Flush(a); // registra la modifica

          updated := True
        end;

      end;

    finally
      ap.Free
    end;
  end;

  SetDataMasterView(aMasterView)

end;

procedure TProductionData.SaveDataMasterView(aMasterView: TcxGridTableView);
begin
  for var r := 0 to aMasterView.DataController.RecordCount - 1 do
  begin
    var
    o := TArticoloProduzione(Integer(aMasterView.DataController.Values[r, 8]));
    DataContainer.AureliusManager1.Update(o)
  end;

  DataContainer.AureliusManager1.Flush

end;

procedure TProductionData.SetDataMasterView(aMasterView: TcxGridTableView);
begin
  // carico la lista degli articoli in produzione
  var
  lap := DataContainer.AureliusManager1.Find<TArticoloProduzione>.List;
  try

    var
    fr := aMasterView.DataController.FocusedRecordIndex;
    aMasterView.DataController.BeginUpdate;
    try

      aMasterView.DataController.RecordCount := 0;

      for var a in lap do
      begin
        with aMasterView.DataController do
        begin
          var
          r := AppendRecord;
          Values[r, 0] := a.ID_Articolo.ID_Ordine.ID; // id ordine
          Values[r, 1] := a.QtaInOrdine; // qta ordine
          Values[r, 2] := a.ID_Articolo.ID_Prodotto.Descrizione;

          Values[r, 3] := a.ID_Parte.ID;
          Values[r, 4] := a.ID_Parte.Descrizione;
          Values[r, 5] := a.QtaParteRichiesta.Value;

          Values[r, 6] := a.QtaProdotta.Value;
          Values[r, 7] := a.stato;
          Values[r, 8] := Integer(a);
          Values[r, 9] := a.ID_Parte.MachineFile;

        end;
      end;
      aMasterView.DataController.FocusedRecordIndex := fr;
    finally
      aMasterView.DataController.EndUpdate
    end;
  finally
    lap.Free
  end;
end;

{ TPartData }

procedure TPartData.DeleteData(aListOfDeletedObjects: Tlist<Tobject>);
begin
  for var o in aListOfDeletedObjects do
    DataContainer.AureliusManager1.Remove(o);

  DataContainer.AureliusManager1.Flush
end;

procedure TPartData.ExtraButtonProc(aMasterView: TcxGridTableView);
begin

end;

function TPartData.GetDetailColumns: TGridColumnsNames;
begin

  result := Tlist<TMyGridItem>.Create; // no detail
end;

function TPartData.GetMasterColumns: TGridColumnsNames;
begin

  var
    p: TSetPropertiesProc;
  p := procedure(aItem: TcxCustomGridTableItem)
    begin
      aItem.PropertiesClass := TcxCheckBoxProperties;

    end;
  result := Tlist<TMyGridItem>.Create;
  var
  I := TMyGridItem.Create('ParteViewID', 'ID', nil, nil);
  I.Visibile := false;
  result.Add(I);
  I := TMyGridItem.Create('ParteViewParte', 'Parte', nil, nil);
  result.Add(I);

  I := TMyGridItem.Create('ParteViewPartProgram', 'File programma', nil, nil);
  result.Add(I);

  I := TMyGridItem.Create('ParteViewObject', 'Object', nil, nil);
  I.Visibile := false;
  result.Add(I);

  I := TMyGridItem.Create('ParteViewPartBordato', 'Bordato', p, nil);
  result.Add(I);

end;

procedure TPartData.Refresh(aMasterView: TcxGridTableView);
begin

end;

procedure TPartData.SaveDataMasterView(aMasterView: TcxGridTableView);
begin

  with aMasterView.DataController do
  begin

    for var r := 0 to RecordCount - 1 do
    begin

      var
      ID := Values[r, 0];
      var
      p := Values[r, 1];
      var
      m := Values[r, 2];
      var
      b := Values[r, 4];

      var
        o: Tparte;
      if VarIsNull(ID) then
        o := Tparte.Create
      else
        o := Tparte(Integer(Values[r, 3]));

      o.Descrizione := p;
      o.MachineFile := m;
      o.Bordato := b;

      DataContainer.AureliusManager1.SaveOrUpdate(o);
      DataContainer.AureliusManager1.Flush(o)

    end;
  end;

end;

procedure TPartData.SetDataMasterView(aMasterView: TcxGridTableView);
begin

  var
  lp := DataContainer.AureliusManager1.Find<Tparte>.List;
  try

    var
    fr := aMasterView.DataController.FocusedRecordIndex;
    aMasterView.DataController.BeginUpdate;
    try

      aMasterView.DataController.RecordCount := 0;

      for var p in lp do
      begin
        with aMasterView.DataController do
        begin
          var
          r := AppendRecord;

          Values[r, 0] := p.ID;
          Values[r, 1] := p.Descrizione;
          Values[r, 2] := p.MachineFile;
          Values[r, 3] := Integer(p);
          Values[r, 4] := p.Bordato;

        end;
      end;
      aMasterView.DataController.FocusedRecordIndex := fr;
    finally
      aMasterView.DataController.EndUpdate
    end;
  finally
    lp.Free
  end;

end;

end.
