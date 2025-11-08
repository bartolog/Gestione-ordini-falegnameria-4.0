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
  Vcl.ExtCtrls, UGridFrame, System.ImageList, Vcl.ImgList,
  cxImageList, cxSplitter, Generics.Collections, USettings,UframeDbParams,
  AboutDialog;

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
    function GetSubDetailColumns: TGridColumnsNames;
    procedure SetDataMasterView(aMasterView: TcxGridTableView);
    procedure SaveDataMasterView(aMasterView: TcxGridTableView);
    procedure ExtraButtonProc(aMasterView: TcxGridTableView);
    procedure Refresh(aMasterView: TcxGridTableView);
    procedure DeleteData(aListOfDeletedObjects: Tlist<Tobject>);

  end;

  TProductData = class(TInterfacedObject, IMasterDetailUnboundedGrid)
    function GetMasterColumns: TGridColumnsNames;
    function GetDetailColumns: TGridColumnsNames;
    function GetSubDetailColumns: TGridColumnsNames;
    procedure SetDataMasterView(aMasterView: TcxGridTableView);
    procedure SaveDataMasterView(aMasterView: TcxGridTableView);
    procedure ExtraButtonProc(aMasterView: TcxGridTableView);
    procedure Refresh(aMasterView: TcxGridTableView);
    procedure DeleteData(aListOfDeletedObjects: Tlist<Tobject>);
  end;

  TProductionData = class(TInterfacedObject, IMasterDetailUnboundedGrid)
    function GetMasterColumns: TGridColumnsNames;
    function GetDetailColumns: TGridColumnsNames;
    function GetSubDetailColumns: TGridColumnsNames;
    procedure SetDataMasterView(aMasterView: TcxGridTableView);
    procedure SaveDataMasterView(aMasterView: TcxGridTableView);
    procedure ExtraButtonProc(aMasterView: TcxGridTableView);
    procedure Refresh(aMasterView: TcxGridTableView);
    procedure DeleteData(aListOfDeletedObjects: Tlist<Tobject>);
  end;

  TPartData = class(TInterfacedObject, IMasterDetailUnboundedGrid)
    function GetMasterColumns: TGridColumnsNames;
    function GetDetailColumns: TGridColumnsNames;
    function GetSubDetailColumns: TGridColumnsNames;
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
    Button2: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: Tobject);
    procedure OrdersViewDataControllerBeforeDelete(ADataController
      : TcxCustomDataController; ARecordIndex: Integer);
    procedure OrdersViewDataControllerBeforePost(ADataController
      : TcxCustomDataController);
    procedure OrderDetailViewDataControllerBeforeDelete(ADataController
      : TcxCustomDataController; ARecordIndex: Integer);
    procedure btnCreateFrameClick(Sender: Tobject);
    procedure btnSettingsClick(Sender: Tobject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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
  cxProgressBar, cxCheckBox, IOUtils ;

var
  lo: Tlist<TOrdine>;
  lp: Tlist<TProdotto>;
  frmGrid: TGridFrame;

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
    frmGrid.btnRefresh.Visible := (Sender as TButton).Tag = 3;
    frmGrid.btnProduzione.Visible := (Sender as TButton).Tag = 0;
    frmGrid.MasterView.OptionsView.GroupByBox := (Sender as TButton).Tag = 3;

    if (Sender as TButton).Tag = 0 then // orders
      frmGrid.CreateDataInterace(TOrdersData.Create);
    if (Sender as TButton).Tag = 1 then // prodotti
      frmGrid.CreateDataInterace(TProductData.Create);
    if (Sender as TButton).Tag = 3 then // produzione
    begin
      frmGrid.CreateDataInterace(TProductionData.Create);

    end;
    if (Sender as TButton).Tag = 4 then // parti
      frmGrid.CreateDataInterace(TPartData.Create);

  end;

  frmGrid.Parent := Panel2;
  frmGrid.Align := alClient;

end;

procedure TfrmMain.btnSettingsClick(Sender: Tobject);
begin
  dlgSettings.ShowModal
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
      var f := TForm.Create(nil);
      try
        f.BorderStyle := bsDialog;
        var dbfrm := TframeDBParams.Create(f);
        f.Height := dbfrm.Height;
        f.width := dbfrm.width;



        dbfrm.Align := alClient;
        dbfrm.Parent := f;

        with dbfrm do
        begin
          edtServer.Text := DataContainer.UniConnection1.Server;
          edtDatabase.Text := DataContainer.UniConnection1.Database;
          edtPort.Text := DataContainer.UniConnection1.Port.ToString;
          edtPassword.Text := DataContainer.UniConnection1.Password;
          edtUser.Text := DataContainer.UniConnection1.Username;

        end;


        dbfrm.TestConnection := DataContainer.TestConnection;
        f.ShowModal;







      finally
        f.Free
      end;
end;

procedure TfrmMain.Button3Click(Sender: TObject);
begin
     AboutDialog.ShowAboutDialog;
end;

procedure TfrmMain.FormCreate(Sender: Tobject);

begin

  memoLog.Clear;
 

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

  var
  ol := DataContainer.AureliusManager1.Find<TOrdine>.List;
  try

    for var o in aListOfDeletedObjects do
    begin
      for var ordine in ol do
      begin

        if ((o.ClassType = TArticolo) and (ordine.Articoli.IndexOf(TArticolo(o))
          <> -1)) then
          ordine.Articoli.Delete(ordine.Articoli.IndexOf(TArticolo(o)));

      end;

      DataContainer.AureliusManager1.Remove(o);
    end;

    DataContainer.AureliusManager1.Flush
  finally
    ol.Free
  end;
end;

// mette in produzione
procedure TOrdersData.ExtraButtonProc(aMasterView: TcxGridTableView);
begin
  with aMasterView.DataController do
  begin
    var
    v := Values[FocusedRecordIndex, 0]; // id ordine
    var

      // recupera l'oggetto
    o := DataContainer.AureliusManager1.Find<TOrdine>.Add(Linq['ID'] = v)
      .UniqueResult;
    // per ogni articolo in ordine
    for var a in o.Articoli do
    begin
      var // creo l'articolo di produzione  e lo valorizzo
      ap := TArticoloProduzione.Create;
      ap.ID_Articolo := a;

      // prendo il prodotto agganciato all'articolo in ordine
      var
      p := a.ID_Prodotto;

      // per ogni componente del prodotto  qta_componente * qtaordine
      for var c in p.Componenti do
      begin
        var
        prt := Tparteproduzione.Create;
        prt.ID_parte := c.ID_parte; // riferimento alla parte del prodotto
        prt.ID_Articolo := ap;
        // riferimento all'articolo di produzione (prodotto)
        prt.Qta := c.Qta.Value * a.Qta.Value;
        // quantità parte in produzione = qta componente * quantità articolo(prodotto)

        // per ogni parte vengono create istanze di produzione per ogni fase
        for var f in prt.ID_parte.fasiLavorazione do
        begin

          var
          fp := Tfaseproduzione.Create;
          fp.Id_fase := f;
          fp.ID_parte := prt; // riferimento a che parte la fase appartienee
          fp.Qta_Richiesta := prt.Qta;
          // tante fasi quante sono le parti da creare
          fp.Qta_Eseguita := 0;

          // salva la fase di produzione
          prt.fasiproduzione.Add(fp)
        end;
        // salva la parte di produzione
        ap.partiproduzione.Add(prt);

      end;
      DataContainer.AureliusManager1.Save(ap); // salva l'articolo di produzione

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

function TOrdersData.GetSubDetailColumns: TGridColumnsNames;
begin
  result := Tlist<TMyGridItem>.Create;
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
            (Linq['ID'] = v).UniqueResult;

        c := (TcxCustomGridTableItem(dv.GetItem(2))
          .Properties as TcxComboBoxProperties);
        v := dv.Values[j, 2];
        var
        idx := c.Items.IndexOf(v);
        if idx = -1 then
        begin
          a.ID_Prodotto := TProdotto.Create;
          a.ID_Prodotto.Descrizione := v

        end
        else
          a.ID_Prodotto := TProdotto(c.Items.Objects[idx]);

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

function GetItemByCaption(aView: TcxGridTableView; aItemCaption: string)
  : TcxCustomGridTableItem;
begin
  for var I := 0 to aView.ItemCount - 1 do
    if aItemCaption = aView.Items[I].Caption then
      result := aView.Items[I]

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

          Values[r, aMasterView.FindItemByName('OrderID').Index] := o.ID;
          Values[r, aMasterView.FindItemByName('OrderCliente').Index] :=
            o.Cliente.Nome;
          Values[r, aMasterView.FindItemByName('OrderData').Index] := o.Data;
          Values[r, aMasterView.FindItemByName('OrderScadenza').Index] :=
            o.Scadenza;
          Values[r, aMasterView.FindItemByName('OrderObject').Index] :=
            Integer(o);
          dw := GetDetailDataController(r, 0);

        end;
        var
        dv := (dw.GetOwner as TcxGridTableView);
        for var a in o.Articoli do
        begin

          with dw do
          begin
            var
            rd := AppendRecord;
            var
            I := GetItemByCaption(dv, 'Id_Articolo');
            Values[rd, I.Index] := a.ID;

            I := GetItemByCaption(dv, 'Id_Ordine');
            Values[rd, I.Index] := a.ID_Ordine.ID;


             I := GetItemByCaption(dv, 'Prodotto');
            Values[rd, I.Index] := a.ID_Prodotto.Descrizione;

             I := GetItemByCaption(dv, 'Quantità');
            Values[rd, I.Index] := a.Qta;

             I := GetItemByCaption(dv, 'Object');
            Values[rd, I.Index] := Integer(a)

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

  var
  ol := DataContainer.AureliusManager1.Find<TProdotto>.List;
  try

    for var o in aListOfDeletedObjects do
    begin
      for var prodotto in ol do
      begin

        if ((o.ClassType = TComponente) and
          (prodotto.Componenti.IndexOf(TComponente(o)) <> -1)) then
          prodotto.Componenti.Delete
            (prodotto.Componenti.IndexOf(TComponente(o)));

        if (o.ClassType = Tfase) then
        begin
          for var c in prodotto.Componenti do
            if c.ID_parte.fasiLavorazione.IndexOf(Tfase(o)) <> -1 then
              c.ID_parte.fasiLavorazione.Delete
                (c.ID_parte.fasiLavorazione.IndexOf(Tfase(o)))

        end;
      end;

      DataContainer.AureliusManager1.Remove(o);
    end;

    DataContainer.AureliusManager1.Flush
  finally
    ol.Free
  end;
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

function TProductData.GetSubDetailColumns: TGridColumnsNames;
begin
  result := Tlist<TMyGridItem>.Create;

  var
    p: TSetPropertiesProc;

  var
  I := TMyGridItem.Create('ParteDetailViewID_Fase', 'ID_Fase', nil, nil);
  I.Visibile := false;
  result.Add(I);

  I := TMyGridItem.Create('ParteDEtailViewDescrizioneFase', 'Descrizione fase',
    nil, nil);
  result.Add(I);

  I := TMyGridItem.Create('ParteDetailViewPartProgram', 'File programma',
    nil, nil);
  result.Add(I);

  p := procedure(aItem: TcxCustomGridTableItem)
    begin
      aItem.PropertiesClass := TcxComboBoxProperties

    end;

  I := TMyGridItem.Create('ParteDetailViewPartMacchina', 'Macchina', p,
    procedure(aItem: TcxCustomGridTableItem)

    begin
      var
      cl := DataContainer.AureliusManager1.Find<TMacchina>.List;
      try
        for var c in cl do
        begin

          (aItem.Properties as TcxComboBoxProperties)
            .Items.AddObject(c.Descrizione, c)

        end;
      finally
        cl.Free
      end;

    end);
  result.Add(I);

  I := TMyGridItem.Create('ParteDetailViewPartObject', 'Object', nil, nil);
  I.Visibile := false;
  result.Add(I);
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
            (Linq['ID'] = v).UniqueResult;

        a.ID_Prodotto := o; // metto il prodotto

        a.Qta := dv.Values[j, 3]; // qta componente    da vedere se indice 3

        var
          // la parte del prodotto
        c := (TcxCustomGridTableItem(dv.GetItem(2)) // oggetto combo parte
          .Properties as TcxComboBoxProperties);
        v := dv.Values[j, 2]; // valore

        var
        idx := c.Items.IndexOf(v); // descrizione dedla parte
        if (idx = -1) then
          if Assigned(a.ID_parte) then
            a.ID_parte.Descrizione := v
          else
          begin
            a.ID_parte := Tparte.Create;
            a.ID_parte.Descrizione := v
          end

        else
          a.ID_parte := Tparte(c.Items.Objects[idx]);

        // subdetail fasi

        var
        subdetail_controller := dv.GetDetailDataController(j, 0);

        for var k := 0 to subdetail_controller.RecordCount - 1 do
        begin

          // id fase
          var
          idFase := subdetail_controller.Values[k, 0];
          var
            f: Tfase;
          if VarIsNull(idFase) then
          begin
            f := Tfase.Create;
            a.ID_parte.fasiLavorazione.Add(f);
            f.ID_parte := a.ID_parte;

          end
          else
            f := Tfase(Integer(subdetail_controller.Values[k, 4]));
          // oggetto fase

          f.Descrizione := subdetail_controller.Values[k, 1];
          // descrizione fase
          f.PartProgram := subdetail_controller.Values[k, 2]; // file programma

          // la parte del prodotto
          c := (TcxCustomGridTableItem(subdetail_controller.GetItem(3))
          // oggetto combo parte
            .Properties as TcxComboBoxProperties);
          c.DropDownListStyle := lsEditFixedList; // solo dalla lista
          v := subdetail_controller.Values[k, 3]; // valore

          idx := c.Items.IndexOf(v); // descrizione dedla parte
          if (idx = -1) then
            if Assigned(f.Macchina) then
              f.Macchina.Descrizione := v
            else
            begin
              f.Macchina := TMacchina.Create;
              f.Macchina.Descrizione := v
            end

          else
            f.Macchina := TMacchina(c.Items.Objects[idx]);

        end;

      end;

      // salvataggio
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

            Values[rd, 2] := a.ID_parte.Descrizione; // descrizione della parte
            Values[rd, 3] := a.Qta; // quantità

            Values[rd, 4] := Integer(a); // store dell'oggetto componente
            // Values[rd, 5] := a.ID_Parte.MachineFile // file programma

            // fasi
            var
            sdc := dw.GetDetailDataController(rd, 0);
            for var f in a.ID_parte.fasiLavorazione do
            begin
              var
              r := sdc.AppendRecord;
              sdc.Values[r, 0] := f.ID; // componente
              sdc.Values[r, 1] := f.Descrizione; // componente
              sdc.Values[r, 2] := f.PartProgram; // componente
              sdc.Values[r, 3] := f.Macchina.Descrizione; // componente
              sdc.Values[r, 4] := Integer(f); // componente

            end;

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
  begin
    DataContainer.AureliusManager1.Remove(Tarticoloproduzione(o));

  end;


end;

procedure TProductionData.ExtraButtonProc(aMasterView: TcxGridTableView);
begin

end;

function TProductionData.GetDetailColumns: TGridColumnsNames;
begin

  result := Tlist<TMyGridItem>.Create;
  var
  I := TMyGridItem.Create('ProductionDetailID', 'ID', nil, nil);
  result.Add(I);

  I := TMyGridItem.Create('ProductionDetailParte', 'Parte', nil, nil);
  result.Add(I);

  I := TMyGridItem.Create('ProductionDetailQta', 'Quantità da produrre',
    nil, nil);
  result.Add(I);

  var
p:
  TSetPropertiesProc := procedure(aItem: TcxCustomGridTableItem)
    begin
      aItem.PropertiesClass := TcxProgressBarProperties;

    end;

  I := TMyGridItem.Create('ProductionDetailStato', 'Stato', p, nil);
  result.Add(I);

  I := TMyGridItem.Create('ProductionDetailObject', 'Object', nil, nil);
  I.Visibile := false;
  result.Add(I);

end;

function TProductionData.GetMasterColumns: TGridColumnsNames;
begin
  result := Tlist<TMyGridItem>.Create;
  var
    p: TSetPropertiesProc;

  var
  I := TMyGridItem.Create('ProductionViewId_Ordine', 'ID_Ordine', nil, nil);
  result.Add(I);

  I := TMyGridItem.Create('ProductionViewProdotto', 'Prodotto', nil, nil);
  result.Add(I);

  I := TMyGridItem.Create('ProductionViewQta', 'Quantità', nil, nil);
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

end;

function TProductionData.GetSubDetailColumns: TGridColumnsNames;
begin
  result := Tlist<TMyGridItem>.Create;
  // Values[r, 0] := fp.ID;
  // Values[r, 1] := fp.Id_fase.Descrizione;
  // Values[r, 2] := fp.Id_fase.PartProgram;
  // Values[r, 3] := p.Qta_richiesta;
  // Values[r, 4] := p.Qta_eseguita;
  // Values[r, 5] := Integer(fp);

  var
  I := TMyGridItem.Create('ProductionFasiViewId', 'ID', nil, nil);
  I.Visibile := false;
  result.Add(I);

  I := TMyGridItem.Create('ProductionFasiViewFase', 'Fase', nil, nil);
  result.Add(I);
  I := TMyGridItem.Create('ProductionFasiViewPartProgram', 'File programma',
    nil, nil);
  result.Add(I);

  I := TMyGridItem.Create('ProductionFasiViewQta', 'Quantità da eseguire',
    nil, nil);
  result.Add(I);

  I := TMyGridItem.Create('ProductionFasiViewQtaFatta', 'Quantità eseguita',
    nil, nil);
  result.Add(I);

  I := TMyGridItem.Create('ProductionFasiViewObject', 'Object', nil, nil);
  I.Visibile := false;
  result.Add(I);

end;

procedure TProductionData.Refresh(aMasterView: TcxGridTableView);
begin
  // cerco il file programma nella cartella di produzione della macchina
  // individuo l'oggetto che contiene quel file macchina
  // e aggiorno la quantità e richiamo la procedura di load data

  var
  apl := DataContainer.AureliusManager1.Find<TArticoloProduzione>.List;

  try

    for var ap in apl do // per ogni articolo di produzione
    begin
      for var pp in ap.partiproduzione do
      begin
        // per ogni parte di produzione della'articolo di produzione
        for var fp in pp.fasiproduzione do
        // per ogni fase della parte dell'articolo in produzione
        begin

          if fp.Qta_Eseguita.Value < fp.Qta_Richiesta.Value then

            fp.Qta_Eseguita.Value := fp.Qta_Eseguita.Value + 1;
          // test : incremenmto la quantità fatta
        end
      end;
      DataContainer.AureliusManager1.Update(ap);

    end;

  finally
    apl.Free
  end;

  DataContainer.AureliusManager1.Flush(); // registra la modifica

  SetDataMasterView(aMasterView)


  // lettura del file csv
  { var
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

    r.Free;

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

    SetDataMasterView(aMasterView) }

end;

procedure TProductionData.SaveDataMasterView(aMasterView: TcxGridTableView);
begin
  var
    idx_object: Integer;
  for var I := 0 to aMasterView.ItemCount - 1 do
    if aMasterView.Items[I].Caption = 'Object' then
      idx_object := aMasterView.Items[I].Index;

  for var r := 0 to aMasterView.DataController.RecordCount - 1 do
  begin
    var

    o := TArticoloProduzione(Integer(aMasterView.DataController.Values[r,
      idx_object]));

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

      for var a in lap do // peert ogni artiocolo di produzione
      begin
        with aMasterView.DataController do
        begin
          var
          r := AppendRecord;

          Values[r, 0] := a.ID_Articolo.ID_Ordine.Cliente.Nome; // id ordine
          Values[r, 1] := a.ID_Articolo.ID_Prodotto.Descrizione;
          Values[r, 2] := a.ID_Articolo.Qta.Value;
          Values[r, 3] := a.Stato;
          Values[r, 4] := Integer(a);

          // dettaglio parti
          var
          DetailParti_DataController := GetDetailDataController(r, 0);
          var
          View := TcxGridDBTableView(DetailParti_DataController.GetOwner);
          View.OptionsData.Deleting := false;



          // DetailParti_DataController.OnBeforeDelete := nil;

          with DetailParti_DataController do
          // per ogni parte dell'articolo(prodotto) in produzione
          begin
            for var p in a.partiproduzione do
            begin
              r := AppendRecord;
              Values[r, 0] := p.ID;
              Values[r, 1] := p.ID_parte.Descrizione;
              Values[r, 2] := p.Qta;
              Values[r, 3] := p.Stato;
              Values[r, 4] := Integer(p);

              var
              DetailFasi_DataController := GetDetailDataController(r, 0);

              View := TcxGridDBTableView(DetailFasi_DataController.GetOwner);
              View.OptionsData.Deleting := false;

              with DetailFasi_DataController do
              begin

                for var fp in p.fasiproduzione do
                begin
                  r := AppendRecord;
                  Values[r, 0] := fp.ID;
                  Values[r, 1] := fp.Id_fase.Descrizione;
                  Values[r, 2] := fp.Id_fase.PartProgram;
                  Values[r, 3] := fp.Qta_Richiesta;
                  Values[r, 4] := fp.Qta_Eseguita;
                  Values[r, 5] := Integer(fp);

                end;
              end;

            end;

          end;

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

  var
    p: TSetPropertiesProc;

  result := Tlist<TMyGridItem>.Create; // no detail

  var
  I := TMyGridItem.Create('ParteDetailViewID_Fase', 'ID_Fase', nil, nil);
  result.Add(I);

  I := TMyGridItem.Create('ParteDEtailViewDescrizioneFase', 'Descrizione fase',
    nil, nil);
  result.Add(I);

  I := TMyGridItem.Create('ParteDetailViewPartProgram', 'File programma',
    nil, nil);
  result.Add(I);

  p := procedure(aItem: TcxCustomGridTableItem)
    begin
      aItem.PropertiesClass := TcxComboBoxProperties

    end;

  I := TMyGridItem.Create('ParteDetailViewPartMacchina', 'Macchina', p,
    procedure(aItem: TcxCustomGridTableItem)

    begin
      var
      cl := DataContainer.AureliusManager1.Find<TMacchina>.List;
      try
        for var c in cl do
        begin

          (aItem.Properties as TcxComboBoxProperties)
            .Items.AddObject(c.Descrizione, c)

        end;
      finally
        cl.Free
      end;

    end);
  result.Add(I);

  I := TMyGridItem.Create('ParteDetailViewPartObject', 'Object', nil, nil);
  result.Add(I);

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

  I := TMyGridItem.Create('ParteViewObject', 'Object', nil, nil);
  I.Visibile := false;
  result.Add(I);

end;

function TPartData.GetSubDetailColumns: TGridColumnsNames;
begin
  result := Tlist<TMyGridItem>.Create;

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
        o: Tparte;
      if VarIsNull(ID) then
        o := Tparte.Create
      else
        o := Tparte(Integer(Values[r, 2]));

      o.Descrizione := p;

      // dettaglio fasi
      var
      dc := GetDetailDataController(r, 0);
      for var j := 0 to dc.RecordCount - 1 do
      begin
        var
        idf := dc.Values[j, 0]; // id fase

        var
          fobject: Tfase;
        if VarIsNull(idf) then
          fobject := Tfase.Create
        else
          fobject := Tfase(Integer(dc.Values[j, 4]));

        fobject.Descrizione := dc.Values[j, 1];
        fobject.PartProgram := dc.Values[j, 2];

        var
        c := (TcxCustomGridTableItem(dc.GetItem(3))
          .Properties as TcxComboBoxProperties);
        var
        m := dc.Values[j, 3];

        fobject.Macchina := TMacchina(c.Items.Objects[c.Items.IndexOf(m)]);

        fobject.ID_parte := o;

        o.fasiLavorazione.Add(fobject);

      end;

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
          // Values[r, 2] := p.MachineFile;
          Values[r, 2] := Integer(p);
          // Values[r, 4] := p.Bordato;

          var
          dc := GetDetailDataController(r, 0);

          for var f in p.fasiLavorazione do
          begin
            r := dc.AppendRecord;
            dc.Values[r, 0] := f.ID;
            dc.Values[r, 1] := f.Descrizione;
            dc.Values[r, 2] := f.PartProgram;
            dc.Values[r, 3] := f.Macchina.Descrizione;
            dc.Values[r, 4] := Integer(f);

          end;

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
