unit Uprodotto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UEntitiesModel, Generics.Collections,
  Vcl.StdCtrls, UData, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, dxScrollbarAnnotations,
  Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid;

type
  TfrmProdotto = class(TForm)
    btnLoadProduct: TButton;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    ProdottoView: TcxGridTableView;
    ProdottoViewNome: TcxGridColumn;
    ProdottoViewId: TcxGridColumn;
    ProdottoViewObject: TcxGridColumn;
    cxGrid1Level2: TcxGridLevel;
    PartiView: TcxGridTableView;
    PartiViewDescrizione: TcxGridColumn;
    PartiViewQta: TcxGridColumn;
    btnSalva: TButton;
    procedure btnLoadProductClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSalvaClick(Sender: TObject);
    procedure ProdottoViewDataControllerBeforeDelete(
      ADataController: TcxCustomDataController; ARecordIndex: Integer);
  private
    { Private declarations }
lp : TList<TProdotto>;
  public
    { Public declarations }
  end;

var
  frmProdotto: TfrmProdotto;

implementation

{$R *.dfm}











procedure TfrmProdotto.btnLoadProductClick(Sender: TObject);
var
dw : TcxCustomDataController;
begin
    if Assigned(lp)  then lp.Free;

    lp :=  datacontainer.AureliusManager1.Find<TProdotto>.List;


ProdottoView.DataController.RecordCount := 0;


ProdottoView.BeginUpdate();
try
for var o in lp do
begin
 with ProdottoView.DataController do
 begin
   var r :=  AppendRecord;

   Values[r,ProdottoViewId.Index] := o.ID;



   Values[r,ProdottoViewNome.Index] := o.Descrizione;
   Values[r,ProdottoViewObject.Index] := integer(o);
   dw := GetDetailDataController(r,0);


   for var a in o.Componenti do
   begin

   with dw do
   begin
      var rd := AppendRecord;

     Values[rd, PartiViewDescrizione.Index] := a.ID_Parte.Descrizione;
     Values[rd, PartiViewQta.Index] := a.Qta;



   end;




 end;

   end;
end;







finally
  ProdottoView.EndUpdate
end;

end;

procedure TfrmProdotto.btnSalvaClick(Sender: TObject);
begin
        with ProdottoView.DataController do
  begin
   var  r := RecordCount - 1;

   for var I := 0 to r  do
   begin
    var o := TProdotto(integer(values[I,ProdottoViewObject.Index]));
    var dw :=  GetDetailDataController(I,0);

    var r1 := dw.RecordCount - 1;
    for var j := 0 to r1 do
    begin
      var v1 := dw.Values[J, PartiViewDescrizione.Index] ;
      var v2 := dw.Values[J, PartiViewQta.Index] ;
      o.Componenti[j].ID_Parte.Descrizione.Value := vartostr(v1);

      var s : string  := v2;
      o.Componenti[j].Qta.Value := s.ToInteger


    end;



   with DataContainer do

    if AureliusManager1.IsAttached(o) then
      AureliusManager1.Update(o)
    else
    AureliusManager1.Save(o)

   end;



   DataContainer.AureliusManager1.Flush

  end;


end;

procedure TfrmProdotto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if  assigned(lp)   then
lp.free
end;









procedure TfrmProdotto.ProdottoViewDataControllerBeforeDelete(
  ADataController: TcxCustomDataController; ARecordIndex: Integer);
begin
    with  ProdottoView.DataController do
    begin
     var r := GetFocusedRecordIndex;
     var o := TProdotto( Integer(Values[r,ProdottoViewObject.Index]));
     lp.Remove(o) ;
     DataContainer.AureliusManager1.Remove(o);
    end;

end;

end.




