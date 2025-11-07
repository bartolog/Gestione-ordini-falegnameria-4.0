unit UEntitiesModel;

interface

uses
  SysUtils,
  Generics.Collections,
  Aurelius.Mapping.Attributes,
  Aurelius.Types.Blob,
  Aurelius.Types.DynamicProperties,
  Aurelius.Types.Nullable,
  Aurelius.Types.Proxy,
  Aurelius.Dictionary.Classes,
  Aurelius.Linq;

type
  TArticolo = class;
  TArticoloProduzione = class;
  TCliente = class;
  TComponente = class;
  TOrdine = class;
  TParte = class;
  TFase = Class;
  TProdotto = class;
  TArticoloDictionary = class;
  TArticoloProduzioneDictionary = class;
  TClienteDictionary = class;
  TComponenteDictionary = class;
  TOrdineDictionary = class;
  TParteDictionary = class;
  TProdottoDictionary = class;
  TMacchina = class;

  [Entity]
  [Table('Macchine')]
  [Id('FID', TIdGenerator.IdentityOrSequence)]
  TMacchina = class

  [Column('ID', [TColumnProp.Required])]
    FID: integer;

    [Column('Descrizione', [], 50)]
    FDescrizione: string;

  public
    property Id: integer read FID write FID;
    property Descrizione: string read FDescrizione write FDescrizione;

  end;

  [Entity]
  [Table('Fasi')]
  [Id('FID', TIdGenerator.IdentityOrSequence)]
  TFase = class

  [Column('ID', [TColumnProp.Required])]
    FID: integer;

    [Column('Descrizione', [], 50)]
    FDescrizione: string;

    [Association([TAssociationProp.Lazy, TAssociationProp.Required],
      CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('ID_Macchina', [], 'ID')]
    FMacchina: Proxy<TMacchina>;

    [Column('MachineFile', [], 50)]
    FMachineFile: Nullable<string>;

     [Column('Eseguita', [] )]
    FEseguita: Boolean;

    [Association([TAssociationProp.Lazy, TAssociationProp.Required],
      CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('ID_parte', [TColumnProp.Required], 'ID')]
    FParte: Proxy<TParte>;



  public
    property Id: integer read FID write FID;
    property Descrizione: string read FDescrizione write FDescrizione;
    property Parte: Proxy<TParte> read FParte write FParte;
    property Macchina: Proxy<TMacchina> read FMacchina write FMacchina;
    property MachineFile : Nullable<string> read FMachineFile write FMachineFile;
    property Eseguita: Boolean read FEseguita write FEseguita;



  end;

  [Entity]
  [Table('Articoli')]
  [Id('FID', TIdGenerator.IdentityOrSequence)]
  TArticolo = class
  private
    [Column('ID', [TColumnProp.Required])]
    FID: integer;

    [Column('Qta', [])]
    FQta: Nullable<integer>;

    [Association([TAssociationProp.Lazy, TAssociationProp.Required],
      CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('ID_Ordine', [TColumnProp.Required], 'ID')]
    FID_Ordine: Proxy<TOrdine>;

    [Association([TAssociationProp.Lazy],
      CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('ID_Prodotto', [], 'ID')]
    FID_Prodotto: Proxy<TProdotto>;

    [ManyValuedAssociation([TAssociationProp.Lazy], [TCascadeType.SaveUpdate,
      TCascadeType.Merge], 'FID_Articolo')]
    FArticoliProduzione: Proxy<TList<TArticoloProduzione>>;
    function GetID_Ordine: TOrdine;
    procedure SetID_Ordine(const Value: TOrdine);
    function GetID_Prodotto: TProdotto;
    procedure SetID_Prodotto(const Value: TProdotto);
    function GetArticoliProduzione: TList<TArticoloProduzione>;
  public
    constructor Create;
    destructor Destroy; override;
    property Id: integer read FID write FID;
    property Qta: Nullable<integer> read FQta write FQta;
    property ID_Ordine: TOrdine read GetID_Ordine write SetID_Ordine;
    property ID_Prodotto: TProdotto read GetID_Prodotto write SetID_Prodotto;
    property ArticoliProduzione: TList<TArticoloProduzione>
      read GetArticoliProduzione;
  end;

  [Entity]
  [Table('ArticoliProduzione')]
  [Id('FID', TIdGenerator.IdentityOrSequence)]
  TArticoloProduzione = class
  private
    [Column('ID', [TColumnProp.Required])]
    FID: integer;

    [Column('QtaInOrdine', [])]
    FQtaInOrdine: Nullable<integer>;

    [Column('QtaParteRichiesta', [])]
    FQtaParteRichiesta: Nullable<integer>;

    [Column('QtaProdotta', [])]
    FQtaProdotta: Nullable<integer>;

    [Association([TAssociationProp.Lazy],
      CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('ID_Articolo', [], 'ID')]
    FID_Articolo: Proxy<TArticolo>;

    [Association([TAssociationProp.Lazy],
      CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('Id_parte', [], 'ID')]
    FId_parte: Proxy<TParte>;
    function GetID_Articolo: TArticolo;
    procedure SetID_Articolo(const Value: TArticolo);
    function GetId_parte: TParte;
    procedure SetId_parte(const Value: TParte);
    function GetAvanzamento: integer;
  public
    property Id: integer read FID write FID;
    property QtaInOrdine: Nullable<integer> read FQtaInOrdine
      write FQtaInOrdine;
    property QtaParteRichiesta: Nullable<integer> read FQtaParteRichiesta
      write FQtaParteRichiesta;
    property QtaProdotta: Nullable<integer> read FQtaProdotta
      write FQtaProdotta;
    property ID_Articolo: TArticolo read GetID_Articolo write SetID_Articolo;
    property Id_parte: TParte read GetId_parte write SetId_parte;
    property Stato: integer read GetAvanzamento;
  end;

  [Entity]
  [Table('Clienti')]
  [Id('FID', TIdGenerator.IdentityOrSequence)]
  TCliente = class
  private
    [Column('ID', [TColumnProp.Required, TColumnProp.NoInsert,
      TColumnProp.NoUpdate])]
    FID: integer;

    [Column('Nome', [TColumnProp.Required], 50)]
    FNome: string;

    [ManyValuedAssociation([TAssociationProp.Lazy, TAssociationProp.Required],
      [TCascadeType.SaveUpdate, TCascadeType.Merge, TCascadeType.Remove],
      'FCliente')]
    FOrdini: Proxy<TList<TOrdine>>;
    function GetOrdini: TList<TOrdine>;
  public
    constructor Create;
    destructor Destroy; override;
    property Id: integer read FID write FID;
    property Nome: string read FNome write FNome;
    property Ordini: TList<TOrdine> read GetOrdini;
  end;

  [Entity]
  [Table('Componenti')]
  [Id('FID', TIdGenerator.IdentityOrSequence)]
  TComponente = class
  private
    [Column('ID', [TColumnProp.Required])]
    FID: integer;

    [Column('Qta', [])]
    FQta: Nullable<integer>;

    [Association([TAssociationProp.Lazy],
      CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('ID_Prodotto', [], 'ID')]
    FID_Prodotto: Proxy<TProdotto>;

    [Association([TAssociationProp.Lazy],
      CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('ID_Parte', [], 'ID')]
    FId_parte: Proxy<TParte>;
    function GetID_Prodotto: TProdotto;
    procedure SetID_Prodotto(const Value: TProdotto);
    function GetId_parte: TParte;
    procedure SetId_parte(const Value: TParte);
  public
    property Id: integer read FID write FID;
    property Qta: Nullable<integer> read FQta write FQta;
    property ID_Prodotto: TProdotto read GetID_Prodotto write SetID_Prodotto;
    property Id_parte: TParte read GetId_parte write SetId_parte;
  end;

  [Entity]
  [Table('Ordini')]
  [Id('FID', TIdGenerator.IdentityOrSequence)]
  TOrdine = class
  private
    [Column('ID', [])]
    FID: integer;

    [Column('Data', [])]
    FData: Nullable<TDateTime>;

    [Column('Scadenza', [])]
    FScadenza: Nullable<TDateTime>;

    [Association([TAssociationProp.Lazy, TAssociationProp.Required],
      CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('ID_Cliente', [TColumnProp.Required], 'ID')]
    FCliente: Proxy<TCliente>;

    [ManyValuedAssociation([TAssociationProp.Lazy, TAssociationProp.Required],
      [TCascadeType.SaveUpdate, TCascadeType.Merge, TCascadeType.Remove],
      'FID_Ordine')]

    FArticoli: Proxy<TList<TArticolo>>;
    function GetCliente: TCliente;
    procedure SetCliente(const Value: TCliente);
    function GetArticoli: TList<TArticolo>;
  public
    constructor Create;
    destructor Destroy; override;
    property Id: integer read FID write FID;
    property Data: Nullable<TDateTime> read FData write FData;
    property Scadenza: Nullable<TDateTime> read FScadenza write FScadenza;
    property Cliente: TCliente read GetCliente write SetCliente;
    property Articoli: TList<TArticolo> read GetArticoli;

    procedure DeleteArticoloById(aId: integer);
  end;

  [Entity]
  [Table('Parti')]
  [Id('FID', TIdGenerator.IdentityOrSequence)]
  TParte = class
  private
    [Column('ID', [])]
    FID: integer;

    [Column('Descrizione', [], 50)]
    FDescrizione: Nullable<string>;

   



    [ManyValuedAssociation([TAssociationProp.Lazy], [TCascadeType.SaveUpdate,
      TCascadeType.Merge], 'FParte')]
    FFasiLavorazione: Proxy<TList<TFase>>;

    function GetAvanzamento : Double;

  public
    constructor Create;
    destructor destroy; override;

    property Id: integer read FID write FID;
    property Descrizione: Nullable<string> read FDescrizione write FDescrizione;
   
    property FasiLavorazione: Proxy < TList < TFase >> read FFasiLavorazione
      write FFasiLavorazione;

    property Avanzamento : Double read GetAvanzamento;

  end;

  [Entity]
  [Table('Prodotti')]
  [Id('FID', TIdGenerator.IdentityOrSequence)]
  TProdotto = class
  private
    [Column('ID', [TColumnProp.Required])]
    FID: integer;

    [Column('Descrizione', [], 50)]
    FDescrizione: Nullable<string>;

    [ManyValuedAssociation([TAssociationProp.Lazy], [TCascadeType.SaveUpdate,
      TCascadeType.Merge, TCascadeType.Remove], 'FID_Prodotto')]
    FComponenti: Proxy<TList<TComponente>>;
    function GetComponenti: TList<TComponente>;
  public
    constructor Create;
    destructor Destroy; override;
    property Id: integer read FID write FID;
    property Descrizione: Nullable<string> read FDescrizione write FDescrizione;
    property Componenti: TList<TComponente> read GetComponenti;
  end;

  IArticoloDictionary = interface;

  IArticoloProduzioneDictionary = interface;

  IClienteDictionary = interface;

  IComponenteDictionary = interface;

  IOrdineDictionary = interface;

  IParteDictionary = interface;

  IProdottoDictionary = interface;

  IArticoloDictionary = interface(IAureliusEntityDictionary)
    function Id: TLinqProjection;
    function Qta: TLinqProjection;
    function ID_Ordine: IOrdineDictionary;
    function ID_Prodotto: IProdottoDictionary;
    function ArticoliProduzione: IArticoloProduzioneDictionary;
  end;

  IArticoloProduzioneDictionary = interface(IAureliusEntityDictionary)
    function Id: TLinqProjection;
    function QtaInOrdine: TLinqProjection;
    function QtaParteRichiesta: TLinqProjection;
    function QtaProdotta: TLinqProjection;
    function ID_Articolo: IArticoloDictionary;
    function Id_parte: IParteDictionary;
  end;

  IClienteDictionary = interface(IAureliusEntityDictionary)
    function Id: TLinqProjection;
    function Nome: TLinqProjection;
    function Ordini: IOrdineDictionary;
  end;

  IComponenteDictionary = interface(IAureliusEntityDictionary)
    function Id: TLinqProjection;
    function Qta: TLinqProjection;
    function ID_Prodotto: IProdottoDictionary;
    function Id_parte: IParteDictionary;
  end;

  IOrdineDictionary = interface(IAureliusEntityDictionary)
    function Id: TLinqProjection;
    function Data: TLinqProjection;
    function Scadenza: TLinqProjection;
    function Cliente: IClienteDictionary;
    function Articoli: IArticoloDictionary;
  end;

  IParteDictionary = interface(IAureliusEntityDictionary)
    function Id: TLinqProjection;
    function Descrizione: TLinqProjection;
    function MachineFile: TLinqProjection;
  end;

  IProdottoDictionary = interface(IAureliusEntityDictionary)
    function Id: TLinqProjection;
    function Descrizione: TLinqProjection;
    function Componenti: IComponenteDictionary;
  end;

  TArticoloDictionary = class(TAureliusEntityDictionary, IArticoloDictionary)
  public
    function Id: TLinqProjection;
    function Qta: TLinqProjection;
    function ID_Ordine: IOrdineDictionary;
    function ID_Prodotto: IProdottoDictionary;
    function ArticoliProduzione: IArticoloProduzioneDictionary;
  end;

  TArticoloProduzioneDictionary = class(TAureliusEntityDictionary,
    IArticoloProduzioneDictionary)
  public
    function Id: TLinqProjection;
    function QtaInOrdine: TLinqProjection;
    function QtaParteRichiesta: TLinqProjection;
    function QtaProdotta: TLinqProjection;
    function ID_Articolo: IArticoloDictionary;
    function Id_parte: IParteDictionary;
  end;

  TClienteDictionary = class(TAureliusEntityDictionary, IClienteDictionary)
  public
    function Id: TLinqProjection;
    function Nome: TLinqProjection;
    function Ordini: IOrdineDictionary;
  end;

  TComponenteDictionary = class(TAureliusEntityDictionary,
    IComponenteDictionary)
  public
    function Id: TLinqProjection;
    function Qta: TLinqProjection;
    function ID_Prodotto: IProdottoDictionary;
    function Id_parte: IParteDictionary;
  end;

  TOrdineDictionary = class(TAureliusEntityDictionary, IOrdineDictionary)
  public
    function Id: TLinqProjection;
    function Data: TLinqProjection;
    function Scadenza: TLinqProjection;
    function Cliente: IClienteDictionary;
    function Articoli: IArticoloDictionary;
  end;

  TParteDictionary = class(TAureliusEntityDictionary, IParteDictionary)
  public
    function Id: TLinqProjection;
    function Descrizione: TLinqProjection;
    function MachineFile: TLinqProjection;
  end;

  TProdottoDictionary = class(TAureliusEntityDictionary, IProdottoDictionary)
  public
    function Id: TLinqProjection;
    function Descrizione: TLinqProjection;
    function Componenti: IComponenteDictionary;
  end;

  IDictionary = interface(IAureliusDictionary)
    function Articolo: IArticoloDictionary;
    function ArticoloProduzione: IArticoloProduzioneDictionary;
    function Cliente: IClienteDictionary;
    function Componente: IComponenteDictionary;
    function Ordine: IOrdineDictionary;
    function Parte: IParteDictionary;
    function Prodotto: IProdottoDictionary;
  end;

  TDictionary = class(TAureliusDictionary, IDictionary)
  public
    function Articolo: IArticoloDictionary;
    function ArticoloProduzione: IArticoloProduzioneDictionary;
    function Cliente: IClienteDictionary;
    function Componente: IComponenteDictionary;
    function Ordine: IOrdineDictionary;
    function Parte: IParteDictionary;
    function Prodotto: IProdottoDictionary;
  end;

function Dic: IDictionary;

implementation

var
  __Dic: IDictionary;

function Dic: IDictionary;
begin
  if __Dic = nil then
    __Dic := TDictionary.Create;
  result := __Dic;
end;

{ TArticolo }

function TArticolo.GetID_Ordine: TOrdine;
begin
  result := FID_Ordine.Value;
end;

procedure TArticolo.SetID_Ordine(const Value: TOrdine);
begin
  FID_Ordine.Value := Value;
end;

function TArticolo.GetID_Prodotto: TProdotto;
begin
  result := FID_Prodotto.Value;
end;

procedure TArticolo.SetID_Prodotto(const Value: TProdotto);
begin
  FID_Prodotto.Value := Value;
end;

constructor TArticolo.Create;
begin
  inherited;
  FArticoliProduzione.SetInitialValue(TList<TArticoloProduzione>.Create);
end;

destructor TArticolo.Destroy;
begin
  FArticoliProduzione.DestroyValue;
  inherited;
end;

function TArticolo.GetArticoliProduzione: TList<TArticoloProduzione>;
begin
  result := FArticoliProduzione.Value;
end;

{ TArticoloProduzione }

function TArticoloProduzione.GetAvanzamento: integer;
begin
  result := Trunc((QtaProdotta.Value / QtaParteRichiesta.Value) * 100)
end;

function TArticoloProduzione.GetID_Articolo: TArticolo;
begin
  result := FID_Articolo.Value;
end;

procedure TArticoloProduzione.SetID_Articolo(const Value: TArticolo);
begin
  FID_Articolo.Value := Value;
end;

function TArticoloProduzione.GetId_parte: TParte;
begin
  result := FId_parte.Value;
end;

procedure TArticoloProduzione.SetId_parte(const Value: TParte);
begin
  FId_parte.Value := Value;
end;

{ TCliente }

constructor TCliente.Create;
begin
  inherited;
  FOrdini.SetInitialValue(TList<TOrdine>.Create);
end;

destructor TCliente.Destroy;
begin
  FOrdini.DestroyValue;
  inherited;
end;

function TCliente.GetOrdini: TList<TOrdine>;
begin
  result := FOrdini.Value;
end;

{ TComponente }

function TComponente.GetID_Prodotto: TProdotto;
begin
  result := FID_Prodotto.Value;
end;

procedure TComponente.SetID_Prodotto(const Value: TProdotto);
begin
  FID_Prodotto.Value := Value;
end;

function TComponente.GetId_parte: TParte;
begin
  result := FId_parte.Value;
end;

procedure TComponente.SetId_parte(const Value: TParte);
begin
  FId_parte.Value := Value;
end;

{ TOrdine }

function TOrdine.GetCliente: TCliente;
begin
  result := FCliente.Value;
end;

procedure TOrdine.SetCliente(const Value: TCliente);
begin
  FCliente.Value := Value;
end;

constructor TOrdine.Create;
begin
  inherited;
  FArticoli.SetInitialValue(TList<TArticolo>.Create);
end;

procedure TOrdine.DeleteArticoloById(aId: integer);
begin
  var
  i := 0;

  while (i < Articoli.Count) do
  begin
    if Articoli[i].Id = aId then
      Articoli.Delete(i)
    else
      inc(i)
  end;

end;

destructor TOrdine.Destroy;
begin
  FArticoli.DestroyValue;
  inherited;
end;

function TOrdine.GetArticoli: TList<TArticolo>;
begin
  result := FArticoli.Value;
end;

{ TProdotto }

constructor TProdotto.Create;
begin
  inherited;
  FComponenti.SetInitialValue(TList<TComponente>.Create);
end;

destructor TProdotto.Destroy;
begin
  FComponenti.DestroyValue;
  inherited;
end;

function TProdotto.GetComponenti: TList<TComponente>;
begin
  result := FComponenti.Value;
end;

{ TArticoloDictionary }

function TArticoloDictionary.Id: TLinqProjection;
begin
  result := Prop('ID');
end;

function TArticoloDictionary.Qta: TLinqProjection;
begin
  result := Prop('Qta');
end;

function TArticoloDictionary.ID_Ordine: IOrdineDictionary;
begin
  result := TOrdineDictionary.Create(PropName('ID_Ordine'));
end;

function TArticoloDictionary.ID_Prodotto: IProdottoDictionary;
begin
  result := TProdottoDictionary.Create(PropName('ID_Prodotto'));
end;

function TArticoloDictionary.ArticoliProduzione: IArticoloProduzioneDictionary;
begin
  result := TArticoloProduzioneDictionary.Create
    (PropName('ArticoliProduzione'));
end;

{ TArticoloProduzioneDictionary }

function TArticoloProduzioneDictionary.Id: TLinqProjection;
begin
  result := Prop('ID');
end;

function TArticoloProduzioneDictionary.QtaInOrdine: TLinqProjection;
begin
  result := Prop('QtaInOrdine');
end;

function TArticoloProduzioneDictionary.QtaParteRichiesta: TLinqProjection;
begin
  result := Prop('QtaParteRichiesta');
end;

function TArticoloProduzioneDictionary.QtaProdotta: TLinqProjection;
begin
  result := Prop('QtaProdotta');
end;

function TArticoloProduzioneDictionary.ID_Articolo: IArticoloDictionary;
begin
  result := TArticoloDictionary.Create(PropName('ID_Articolo'));
end;

function TArticoloProduzioneDictionary.Id_parte: IParteDictionary;
begin
  result := TParteDictionary.Create(PropName('Id_parte'));
end;

{ TClienteDictionary }

function TClienteDictionary.Id: TLinqProjection;
begin
  result := Prop('ID');
end;

function TClienteDictionary.Nome: TLinqProjection;
begin
  result := Prop('Nome');
end;

function TClienteDictionary.Ordini: IOrdineDictionary;
begin
  result := TOrdineDictionary.Create(PropName('Ordini'));
end;

{ TComponenteDictionary }

function TComponenteDictionary.Id: TLinqProjection;
begin
  result := Prop('ID');
end;

function TComponenteDictionary.Qta: TLinqProjection;
begin
  result := Prop('Qta');
end;

function TComponenteDictionary.ID_Prodotto: IProdottoDictionary;
begin
  result := TProdottoDictionary.Create(PropName('ID_Prodotto'));
end;

function TComponenteDictionary.Id_parte: IParteDictionary;
begin
  result := TParteDictionary.Create(PropName('ID_Parte'));
end;

{ TOrdineDictionary }

function TOrdineDictionary.Id: TLinqProjection;
begin
  result := Prop('ID');
end;

function TOrdineDictionary.Data: TLinqProjection;
begin
  result := Prop('Data');
end;

function TOrdineDictionary.Scadenza: TLinqProjection;
begin
  result := Prop('Scadenza');
end;

function TOrdineDictionary.Cliente: IClienteDictionary;
begin
  result := TClienteDictionary.Create(PropName('Cliente'));
end;

function TOrdineDictionary.Articoli: IArticoloDictionary;
begin
  result := TArticoloDictionary.Create(PropName('Articoli'));
end;

{ TParteDictionary }

function TParteDictionary.Id: TLinqProjection;
begin
  result := Prop('ID');
end;

function TParteDictionary.Descrizione: TLinqProjection;
begin
  result := Prop('Descrizione');
end;

function TParteDictionary.MachineFile: TLinqProjection;
begin
  result := Prop('MachineFile');
end;

{ TProdottoDictionary }

function TProdottoDictionary.Id: TLinqProjection;
begin
  result := Prop('ID');
end;

function TProdottoDictionary.Descrizione: TLinqProjection;
begin
  result := Prop('Descrizione');
end;

function TProdottoDictionary.Componenti: IComponenteDictionary;
begin
  result := TComponenteDictionary.Create(PropName('Componenti'));
end;

{ TDictionary }

function TDictionary.Articolo: IArticoloDictionary;
begin
  result := TArticoloDictionary.Create;
end;

function TDictionary.ArticoloProduzione: IArticoloProduzioneDictionary;
begin
  result := TArticoloProduzioneDictionary.Create;
end;

function TDictionary.Cliente: IClienteDictionary;
begin
  result := TClienteDictionary.Create;
end;

function TDictionary.Componente: IComponenteDictionary;
begin
  result := TComponenteDictionary.Create;
end;

function TDictionary.Ordine: IOrdineDictionary;
begin
  result := TOrdineDictionary.Create;
end;

function TDictionary.Parte: IParteDictionary;
begin
  result := TParteDictionary.Create;
end;

function TDictionary.Prodotto: IProdottoDictionary;
begin
  result := TProdottoDictionary.Create;
end;

{ TParte }

constructor TParte.Create;
begin
 inherited;
 FFasiLavorazione.SetInitialValue(Tlist<TFase>.Create)
end;

destructor TParte.destroy;
begin
  FFasiLavorazione.DestroyValue;
  inherited;
end;

function TParte.GetAvanzamento: Double;
begin
    var totFasi := FFasiLavorazione.Value.Count;
    var toteseguiti := 0;
    for var f in FFasiLavorazione.Value do
     if f.Eseguita  then inc(toteseguiti) ;

   Result := toteseguiti / totFasi



end;

initialization

RegisterEntity(TCliente);
RegisterEntity(TOrdine);
RegisterEntity(TArticolo);
RegisterEntity(TProdotto);
RegisterEntity(TParte);
RegisterEntity(TComponente);
RegisterEntity(TArticoloProduzione);
RegisterEntity(TFase);
RegisterEntity(TMacchina);

end.
