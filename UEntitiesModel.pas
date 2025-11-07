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
  TFase = class;
  TFaseProduzione = class;
  TMacchina = class;
  TOrdine = class;
  TParte = class;
  TParteProduzione = class;
  TProdotto = class;
  TArticoloDictionary = class;
  TArticoloProduzioneDictionary = class;
  TClienteDictionary = class;
  TComponenteDictionary = class;
  TFaseDictionary = class;
  TFaseProduzioneDictionary = class;
  TMacchinaDictionary = class;
  TOrdineDictionary = class;
  TParteDictionary = class;
  TParteProduzioneDictionary = class;
  TProdottoDictionary = class;
  
  [Entity]
  [Table('Articoli')]
  [Id('FID', TIdGenerator.IdentityOrSequence)]
  TArticolo = class
  private
    [Column('ID', [TColumnProp.Required])]
    FID: Integer;
    
    [Column('Qta', [])]
    FQta: Nullable<Integer>;
    
    [Association([TAssociationProp.Lazy, TAssociationProp.Required], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('ID_Ordine', [TColumnProp.Required], 'ID')]
    FID_Ordine: Proxy<TOrdine>;
    
    [Association([TAssociationProp.Lazy], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('ID_Prodotto', [], 'ID')]
    FID_Prodotto: Proxy<TProdotto>;
    
    [ManyValuedAssociation([TAssociationProp.Lazy], [TCascadeType.SaveUpdate, TCascadeType.Merge], 'FID_Articolo')]
    FArticoliProduzione: Proxy<TList<TArticoloProduzione>>;
    function GetID_Ordine: TOrdine;
    procedure SetID_Ordine(const Value: TOrdine);
    function GetID_Prodotto: TProdotto;
    procedure SetID_Prodotto(const Value: TProdotto);
    function GetArticoliProduzione: TList<TArticoloProduzione>;
  public
    constructor Create;
    destructor Destroy; override;
    property ID: Integer read FID write FID;
    property Qta: Nullable<Integer> read FQta write FQta;
    property ID_Ordine: TOrdine read GetID_Ordine write SetID_Ordine;
    property ID_Prodotto: TProdotto read GetID_Prodotto write SetID_Prodotto;
    property ArticoliProduzione: TList<TArticoloProduzione> read GetArticoliProduzione;
  end;
  
  [Entity]
  [Table('ArticoliProduzione')]
  [Id('FID', TIdGenerator.IdentityOrSequence)]
  TArticoloProduzione = class
  private
    [Column('ID', [TColumnProp.Required])]
    FID: Integer;
    
    [Association([TAssociationProp.Lazy], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('ID_Articolo', [], 'ID')]
    FID_Articolo: Proxy<TArticolo>;
    
    [ManyValuedAssociation([TAssociationProp.Lazy, TAssociationProp.Required], [TCascadeType.SaveUpdate, TCascadeType.Merge, TCascadeType.Remove], 'FID_Articolo')]
    FPartiProduzione: Proxy<TList<TParteProduzione>>;
    function GetID_Articolo: TArticolo;
    procedure SetID_Articolo(const Value: TArticolo);
    function GetPartiProduzione: TList<TParteProduzione>;
    function GetStato : double;
  public
    constructor Create;
    destructor Destroy; override;
    property ID: Integer read FID write FID;
    property ID_Articolo: TArticolo read GetID_Articolo write SetID_Articolo;
    property PartiProduzione: TList<TParteProduzione> read GetPartiProduzione;
    property Stato : double read GetStato;
  end;
  
  [Entity]
  [Table('Clienti')]
  [Id('FID', TIdGenerator.IdentityOrSequence)]
  TCliente = class
  private
    [Column('ID', [TColumnProp.Required, TColumnProp.NoInsert, TColumnProp.NoUpdate])]
    FID: Integer;
    
    [Column('Nome', [TColumnProp.Required], 50)]
    FNome: string;
    
    [ManyValuedAssociation([TAssociationProp.Lazy, TAssociationProp.Required], [TCascadeType.SaveUpdate, TCascadeType.Merge, TCascadeType.Remove], 'FCliente')]
    FOrdini: Proxy<TList<TOrdine>>;
    function GetOrdini: TList<TOrdine>;
  public
    constructor Create;
    destructor Destroy; override;
    property ID: Integer read FID write FID;
    property Nome: string read FNome write FNome;
    property Ordini: TList<TOrdine> read GetOrdini;
  end;
  
  [Entity]
  [Table('Componenti')]
  [Id('FID', TIdGenerator.IdentityOrSequence)]
  TComponente = class
  private
    [Column('ID', [TColumnProp.Required])]
    FID: Integer;
    
    [Column('Qta', [])]
    FQta: Nullable<Integer>;
    
    [Association([TAssociationProp.Lazy], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('ID_Prodotto', [], 'ID')]
    FID_Prodotto: Proxy<TProdotto>;
    
    [Association([TAssociationProp.Lazy], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('ID_Parte', [], 'ID')]
    FID_Parte: Proxy<TParte>;
    function GetID_Prodotto: TProdotto;
    procedure SetID_Prodotto(const Value: TProdotto);
    function GetID_Parte: TParte;
    procedure SetID_Parte(const Value: TParte);
  public
    property ID: Integer read FID write FID;
    property Qta: Nullable<Integer> read FQta write FQta;
    property ID_Prodotto: TProdotto read GetID_Prodotto write SetID_Prodotto;
    property ID_Parte: TParte read GetID_Parte write SetID_Parte;
  end;
  
  [Entity]
  [Table('Fasi')]
  [Id('FId', TIdGenerator.IdentityOrSequence)]
  TFase = class
  private
    [Column('Id', [TColumnProp.Required])]
    FId: Integer;
    
    [Column('Descrizione', [], 50)]
    FDescrizione: Nullable<string>;
    
    [Column('PartProgram', [], 80)]
    FPartProgram: Nullable<string>;
    
    [Association([TAssociationProp.Lazy, TAssociationProp.Required], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('ID_Parte', [TColumnProp.Required], 'ID')]
    FParte: Proxy<TParte>;
    
    [Association([TAssociationProp.Lazy, TAssociationProp.Required], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('Id_Macchina', [TColumnProp.Required], 'Id')]
    FMacchina: Proxy<TMacchina>;
    
    [ManyValuedAssociation([TAssociationProp.Lazy, TAssociationProp.Required], [TCascadeType.SaveUpdate, TCascadeType.Merge], 'FId_fase')]
    FFasiProduzioneList: Proxy<TList<TFaseProduzione>>;
    function GetParte: TParte;
    procedure SetParte(const Value: TParte);
    function GetMacchina: TMacchina;
    procedure SetMacchina(const Value: TMacchina);
    function GetFasiProduzioneList: TList<TFaseProduzione>;
  public
    constructor Create;
    destructor Destroy; override;
    property Id: Integer read FId write FId;
    property Descrizione: Nullable<string> read FDescrizione write FDescrizione;
    property PartProgram: Nullable<string> read FPartProgram write FPartProgram;
    property Parte: TParte read GetParte write SetParte;
    property Macchina: TMacchina read GetMacchina write SetMacchina;
    property FasiProduzioneList: TList<TFaseProduzione> read GetFasiProduzioneList;
  end;
  
  [Entity]
  [Table('FasiProduzione')]
  [Id('FID', TIdGenerator.IdentityOrSequence)]
  TFaseProduzione = class
  private
    [Column('ID', [TColumnProp.Required])]
    FID: Integer;
    
    [Column('Qta_Richiesta', [])]
    FQta_Richiesta: Nullable<Integer>;
    
    [Column('Qta_Eseguita', [])]
    FQta_Eseguita: Nullable<Integer>;
    
    [Association([TAssociationProp.Lazy, TAssociationProp.Required], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('ID_Parte', [TColumnProp.Required], 'ID')]
    FID_Parte: Proxy<TParteProduzione>;
    
    [Association([TAssociationProp.Lazy, TAssociationProp.Required], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('Id_fase', [TColumnProp.Required], 'Id')]
    FId_fase: Proxy<TFase>;
    function GetID_Parte: TParteProduzione;
    procedure SetID_Parte(const Value: TParteProduzione);
    function GetId_fase: TFase;
    procedure SetId_fase(const Value: TFase);
  public
    property ID: Integer read FID write FID;
    property Qta_Richiesta: Nullable<Integer> read FQta_Richiesta write FQta_Richiesta;
    property Qta_Eseguita: Nullable<Integer> read FQta_Eseguita write FQta_Eseguita;
    property ID_Parte: TParteProduzione read GetID_Parte write SetID_Parte;
    property Id_fase: TFase read GetId_fase write SetId_fase;
  end;
  
  [Entity]
  [Table('Macchine')]
  [Id('FId', TIdGenerator.IdentityOrSequence)]
  TMacchina = class
  private
    [Column('Id', [TColumnProp.Required])]
    FId: Integer;
    
    [Column('DEscrizione', [], 50)]
    FDEscrizione: Nullable<string>;
    
    [ManyValuedAssociation([TAssociationProp.Lazy, TAssociationProp.Required], [TCascadeType.SaveUpdate, TCascadeType.Merge], 'FMacchina')]
    FFasiList: Proxy<TList<TFase>>;
    function GetFasiList: TList<TFase>;
  public
    constructor Create;
    destructor Destroy; override;
    property Id: Integer read FId write FId;
    property DEscrizione: Nullable<string> read FDEscrizione write FDEscrizione;
    property FasiList: TList<TFase> read GetFasiList;
  end;
  
  [Entity]
  [Table('Ordini')]
  [Id('FID', TIdGenerator.IdentityOrSequence)]
  TOrdine = class
  private
    [Column('ID', [TColumnProp.Required])]
    FID: Integer;
    
    [Column('Data', [])]
    FData: Nullable<TDateTime>;
    
    [Column('Scadenza', [])]
    FScadenza: Nullable<TDateTime>;
    
    [Association([TAssociationProp.Lazy, TAssociationProp.Required], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('ID_Cliente', [TColumnProp.Required], 'ID')]
    FCliente: Proxy<TCliente>;
    
    [ManyValuedAssociation([TAssociationProp.Lazy, TAssociationProp.Required], [TCascadeType.SaveUpdate, TCascadeType.Merge, TCascadeType.Remove], 'FID_Ordine')]
    FArticoli: Proxy<TList<TArticolo>>;
    function GetCliente: TCliente;
    procedure SetCliente(const Value: TCliente);
    function GetArticoli: TList<TArticolo>;
  public
    constructor Create;
    destructor Destroy; override;
    property ID: Integer read FID write FID;
    property Data: Nullable<TDateTime> read FData write FData;
    property Scadenza: Nullable<TDateTime> read FScadenza write FScadenza;
    property Cliente: TCliente read GetCliente write SetCliente;
    property Articoli: TList<TArticolo> read GetArticoli;
  end;
  
  [Entity]
  [Table('Parti')]
  [Id('FID', TIdGenerator.IdentityOrSequence)]
  TParte = class
  private
    [Column('ID', [TColumnProp.Required])]
    FID: Integer;
    
    [Column('Descrizione', [], 50)]
    FDescrizione: Nullable<string>;
    
    [ManyValuedAssociation([TAssociationProp.Lazy], [TCascadeType.SaveUpdate, TCascadeType.Merge], 'FID_Parte')]
    FComponenti: Proxy<TList<TComponente>>;
    
    [ManyValuedAssociation([TAssociationProp.Lazy, TAssociationProp.Required], [TCascadeType.SaveUpdate, TCascadeType.Merge, TCascadeType.Remove], 'FParte')]
    FFasiLavorazione: Proxy<TList<TFase>>;
    
    [ManyValuedAssociation([TAssociationProp.Lazy, TAssociationProp.Required], [TCascadeType.SaveUpdate, TCascadeType.Merge], 'FID_parte')]
    FPartiProduzione: Proxy<TList<TParteProduzione>>;
    function GetComponenti: TList<TComponente>;
    function GetFasiLavorazione: TList<TFase>;
    function GetPartiProduzione: TList<TParteProduzione>;
  public
    constructor Create;
    destructor Destroy; override;
    property ID: Integer read FID write FID;
    property Descrizione: Nullable<string> read FDescrizione write FDescrizione;
    property Componenti: TList<TComponente> read GetComponenti;
    property FasiLavorazione: TList<TFase> read GetFasiLavorazione;
    property PartiProduzione: TList<TParteProduzione> read GetPartiProduzione;
  end;
  
  [Entity]
  [Table('PartiProduzione')]
  [Id('FID', TIdGenerator.IdentityOrSequence)]
  TParteProduzione = class
  private
    [Column('ID', [TColumnProp.Required])]
    FID: Integer;
    
    [Column('Qta', [])]
    FQta: Nullable<Integer>;
    
    [Association([TAssociationProp.Lazy, TAssociationProp.Required], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('ID_Articolo', [TColumnProp.Required], 'ID')]
    FID_Articolo: Proxy<TArticoloProduzione>;
    
    [Association([TAssociationProp.Lazy, TAssociationProp.Required], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('ID_parte', [TColumnProp.Required], 'ID')]
    FID_parte: Proxy<TParte>;
    function GetID_Articolo: TArticoloProduzione;
    procedure SetID_Articolo(const Value: TArticoloProduzione);
    function GetID_parte: TParte;
    procedure SetID_parte(const Value: TParte);
  public
    property ID: Integer read FID write FID;
    property Qta: Nullable<Integer> read FQta write FQta;
    property ID_Articolo: TArticoloProduzione read GetID_Articolo write SetID_Articolo;
    property ID_parte: TParte read GetID_parte write SetID_parte;
  end;
  
  [Entity]
  [Table('Prodotti')]
  [Id('FID', TIdGenerator.IdentityOrSequence)]
  TProdotto = class
  private
    [Column('ID', [TColumnProp.Required])]
    FID: Integer;
    
    [Column('Descrizione', [], 50)]
    FDescrizione: Nullable<string>;
    
    [ManyValuedAssociation([TAssociationProp.Lazy], [TCascadeType.SaveUpdate, TCascadeType.Merge], 'FID_Prodotto')]
    FArticoli: Proxy<TList<TArticolo>>;
    
    [ManyValuedAssociation([TAssociationProp.Lazy], [TCascadeType.SaveUpdate, TCascadeType.Merge, TCascadeType.Remove], 'FID_Prodotto')]
    FComponenti: Proxy<TList<TComponente>>;
    function GetArticoli: TList<TArticolo>;
    function GetComponenti: TList<TComponente>;
  public
    constructor Create;
    destructor Destroy; override;
    property ID: Integer read FID write FID;
    property Descrizione: Nullable<string> read FDescrizione write FDescrizione;
    property Articoli: TList<TArticolo> read GetArticoli;
    property Componenti: TList<TComponente> read GetComponenti;
  end;
  
  IArticoloDictionary = interface;
  
  IArticoloProduzioneDictionary = interface;
  
  IClienteDictionary = interface;
  
  IComponenteDictionary = interface;
  
  IFaseDictionary = interface;
  
  IFaseProduzioneDictionary = interface;
  
  IMacchinaDictionary = interface;
  
  IOrdineDictionary = interface;
  
  IParteDictionary = interface;
  
  IParteProduzioneDictionary = interface;
  
  IProdottoDictionary = interface;
  
  IArticoloDictionary = interface(IAureliusEntityDictionary)
    function ID: TLinqProjection;
    function Qta: TLinqProjection;
    function ID_Ordine: IOrdineDictionary;
    function ID_Prodotto: IProdottoDictionary;
    function ArticoliProduzione: IArticoloProduzioneDictionary;
  end;
  
  IArticoloProduzioneDictionary = interface(IAureliusEntityDictionary)
    function ID: TLinqProjection;
    function ID_Articolo: IArticoloDictionary;
    function PartiProduzione: IParteProduzioneDictionary;
  end;
  
  IClienteDictionary = interface(IAureliusEntityDictionary)
    function ID: TLinqProjection;
    function Nome: TLinqProjection;
    function Ordini: IOrdineDictionary;
  end;
  
  IComponenteDictionary = interface(IAureliusEntityDictionary)
    function ID: TLinqProjection;
    function Qta: TLinqProjection;
    function ID_Prodotto: IProdottoDictionary;
    function ID_Parte: IParteDictionary;
  end;
  
  IFaseDictionary = interface(IAureliusEntityDictionary)
    function Id: TLinqProjection;
    function Descrizione: TLinqProjection;
    function PartProgram: TLinqProjection;
    function Parte: IParteDictionary;
    function Macchina: IMacchinaDictionary;
    function FasiProduzioneList: IFaseProduzioneDictionary;
  end;
  
  IFaseProduzioneDictionary = interface(IAureliusEntityDictionary)
    function ID: TLinqProjection;
    function Qta_Richiesta: TLinqProjection;
    function Qta_Eseguita: TLinqProjection;
    function ID_Parte: IParteProduzioneDictionary;
    function Id_fase: IFaseDictionary;
  end;
  
  IMacchinaDictionary = interface(IAureliusEntityDictionary)
    function Id: TLinqProjection;
    function DEscrizione: TLinqProjection;
    function FasiList: IFaseDictionary;
  end;
  
  IOrdineDictionary = interface(IAureliusEntityDictionary)
    function ID: TLinqProjection;
    function Data: TLinqProjection;
    function Scadenza: TLinqProjection;
    function Cliente: IClienteDictionary;
    function Articoli: IArticoloDictionary;
  end;
  
  IParteDictionary = interface(IAureliusEntityDictionary)
    function ID: TLinqProjection;
    function Descrizione: TLinqProjection;
    function Componenti: IComponenteDictionary;
    function FasiLavorazione: IFaseDictionary;
    function PartiProduzione: IParteProduzioneDictionary;
  end;
  
  IParteProduzioneDictionary = interface(IAureliusEntityDictionary)
    function ID: TLinqProjection;
    function Qta: TLinqProjection;
    function ID_Articolo: IArticoloProduzioneDictionary;
    function ID_parte: IParteDictionary;
  end;
  
  IProdottoDictionary = interface(IAureliusEntityDictionary)
    function ID: TLinqProjection;
    function Descrizione: TLinqProjection;
    function Articoli: IArticoloDictionary;
    function Componenti: IComponenteDictionary;
  end;
  
  TArticoloDictionary = class(TAureliusEntityDictionary, IArticoloDictionary)
  public
    function ID: TLinqProjection;
    function Qta: TLinqProjection;
    function ID_Ordine: IOrdineDictionary;
    function ID_Prodotto: IProdottoDictionary;
    function ArticoliProduzione: IArticoloProduzioneDictionary;
  end;
  
  TArticoloProduzioneDictionary = class(TAureliusEntityDictionary, IArticoloProduzioneDictionary)
  public
    function ID: TLinqProjection;
    function ID_Articolo: IArticoloDictionary;
    function PartiProduzione: IParteProduzioneDictionary;
  end;
  
  TClienteDictionary = class(TAureliusEntityDictionary, IClienteDictionary)
  public
    function ID: TLinqProjection;
    function Nome: TLinqProjection;
    function Ordini: IOrdineDictionary;
  end;
  
  TComponenteDictionary = class(TAureliusEntityDictionary, IComponenteDictionary)
  public
    function ID: TLinqProjection;
    function Qta: TLinqProjection;
    function ID_Prodotto: IProdottoDictionary;
    function ID_Parte: IParteDictionary;
  end;
  
  TFaseDictionary = class(TAureliusEntityDictionary, IFaseDictionary)
  public
    function Id: TLinqProjection;
    function Descrizione: TLinqProjection;
    function PartProgram: TLinqProjection;
    function Parte: IParteDictionary;
    function Macchina: IMacchinaDictionary;
    function FasiProduzioneList: IFaseProduzioneDictionary;
  end;
  
  TFaseProduzioneDictionary = class(TAureliusEntityDictionary, IFaseProduzioneDictionary)
  public
    function ID: TLinqProjection;
    function Qta_Richiesta: TLinqProjection;
    function Qta_Eseguita: TLinqProjection;
    function ID_Parte: IParteProduzioneDictionary;
    function Id_fase: IFaseDictionary;
  end;
  
  TMacchinaDictionary = class(TAureliusEntityDictionary, IMacchinaDictionary)
  public
    function Id: TLinqProjection;
    function DEscrizione: TLinqProjection;
    function FasiList: IFaseDictionary;
  end;
  
  TOrdineDictionary = class(TAureliusEntityDictionary, IOrdineDictionary)
  public
    function ID: TLinqProjection;
    function Data: TLinqProjection;
    function Scadenza: TLinqProjection;
    function Cliente: IClienteDictionary;
    function Articoli: IArticoloDictionary;
  end;
  
  TParteDictionary = class(TAureliusEntityDictionary, IParteDictionary)
  public
    function ID: TLinqProjection;
    function Descrizione: TLinqProjection;
    function Componenti: IComponenteDictionary;
    function FasiLavorazione: IFaseDictionary;
    function PartiProduzione: IParteProduzioneDictionary;
  end;
  
  TParteProduzioneDictionary = class(TAureliusEntityDictionary, IParteProduzioneDictionary)
  public
    function ID: TLinqProjection;
    function Qta: TLinqProjection;
    function ID_Articolo: IArticoloProduzioneDictionary;
    function ID_parte: IParteDictionary;
  end;
  
  TProdottoDictionary = class(TAureliusEntityDictionary, IProdottoDictionary)
  public
    function ID: TLinqProjection;
    function Descrizione: TLinqProjection;
    function Articoli: IArticoloDictionary;
    function Componenti: IComponenteDictionary;
  end;
  
  IDictionary = interface(IAureliusDictionary)
    function Articolo: IArticoloDictionary;
    function ArticoloProduzione: IArticoloProduzioneDictionary;
    function Cliente: IClienteDictionary;
    function Componente: IComponenteDictionary;
    function Fase: IFaseDictionary;
    function FaseProduzione: IFaseProduzioneDictionary;
    function Macchina: IMacchinaDictionary;
    function Ordine: IOrdineDictionary;
    function Parte: IParteDictionary;
    function ParteProduzione: IParteProduzioneDictionary;
    function Prodotto: IProdottoDictionary;
  end;
  
  TDictionary = class(TAureliusDictionary, IDictionary)
  public
    function Articolo: IArticoloDictionary;
    function ArticoloProduzione: IArticoloProduzioneDictionary;
    function Cliente: IClienteDictionary;
    function Componente: IComponenteDictionary;
    function Fase: IFaseDictionary;
    function FaseProduzione: IFaseProduzioneDictionary;
    function Macchina: IMacchinaDictionary;
    function Ordine: IOrdineDictionary;
    function Parte: IParteDictionary;
    function ParteProduzione: IParteProduzioneDictionary;
    function Prodotto: IProdottoDictionary;
  end;
  
function Dic: IDictionary;

implementation

var
  __Dic: IDictionary;

function Dic: IDictionary;
begin
  if __Dic = nil then __Dic := TDictionary.Create;
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

function TArticoloProduzione.GetID_Articolo: TArticolo;
begin
  result := FID_Articolo.Value;
end;

procedure TArticoloProduzione.SetID_Articolo(const Value: TArticolo);
begin
  FID_Articolo.Value := Value;
end;

constructor TArticoloProduzione.Create;
begin
  inherited;
  FPartiProduzione.SetInitialValue(TList<TParteProduzione>.Create);
end;

destructor TArticoloProduzione.Destroy;
begin
  FPartiProduzione.DestroyValue;
  inherited;
end;

function TArticoloProduzione.GetPartiProduzione: TList<TParteProduzione>;
begin
  result := FPartiProduzione.Value;
end;

function TArticoloProduzione.GetStato: double;
begin
  result := 100;
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

function TComponente.GetID_Parte: TParte;
begin
  result := FID_Parte.Value;
end;

procedure TComponente.SetID_Parte(const Value: TParte);
begin
  FID_Parte.Value := Value;
end;

{ TFase }

function TFase.GetParte: TParte;
begin
  result := FParte.Value;
end;

procedure TFase.SetParte(const Value: TParte);
begin
  FParte.Value := Value;
end;

function TFase.GetMacchina: TMacchina;
begin
  result := FMacchina.Value;
end;

procedure TFase.SetMacchina(const Value: TMacchina);
begin
  FMacchina.Value := Value;
end;

constructor TFase.Create;
begin
  inherited;
  FFasiProduzioneList.SetInitialValue(TList<TFaseProduzione>.Create);
end;

destructor TFase.Destroy;
begin
  FFasiProduzioneList.DestroyValue;
  inherited;
end;

function TFase.GetFasiProduzioneList: TList<TFaseProduzione>;
begin
  result := FFasiProduzioneList.Value;
end;

{ TFaseProduzione }

function TFaseProduzione.GetID_Parte: TParteProduzione;
begin
  result := FID_Parte.Value;
end;

procedure TFaseProduzione.SetID_Parte(const Value: TParteProduzione);
begin
  FID_Parte.Value := Value;
end;

function TFaseProduzione.GetId_fase: TFase;
begin
  result := FId_fase.Value;
end;

procedure TFaseProduzione.SetId_fase(const Value: TFase);
begin
  FId_fase.Value := Value;
end;

{ TMacchina }

constructor TMacchina.Create;
begin
  inherited;
  FFasiList.SetInitialValue(TList<TFase>.Create);
end;

destructor TMacchina.Destroy;
begin
  FFasiList.DestroyValue;
  inherited;
end;

function TMacchina.GetFasiList: TList<TFase>;
begin
  result := FFasiList.Value;
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

destructor TOrdine.Destroy;
begin
  FArticoli.DestroyValue;
  inherited;
end;

function TOrdine.GetArticoli: TList<TArticolo>;
begin
  result := FArticoli.Value;
end;

{ TParte }

constructor TParte.Create;
begin
  inherited;
  FComponenti.SetInitialValue(TList<TComponente>.Create);
  FFasiLavorazione.SetInitialValue(TList<TFase>.Create);
  FPartiProduzione.SetInitialValue(TList<TParteProduzione>.Create);
end;

destructor TParte.Destroy;
begin
  FPartiProduzione.DestroyValue;
  FFasiLavorazione.DestroyValue;
  FComponenti.DestroyValue;
  inherited;
end;

function TParte.GetComponenti: TList<TComponente>;
begin
  result := FComponenti.Value;
end;

function TParte.GetFasiLavorazione: TList<TFase>;
begin
  result := FFasiLavorazione.Value;
end;

function TParte.GetPartiProduzione: TList<TParteProduzione>;
begin
  result := FPartiProduzione.Value;
end;

{ TParteProduzione }

function TParteProduzione.GetID_Articolo: TArticoloProduzione;
begin
  result := FID_Articolo.Value;
end;

procedure TParteProduzione.SetID_Articolo(const Value: TArticoloProduzione);
begin
  FID_Articolo.Value := Value;
end;

function TParteProduzione.GetID_parte: TParte;
begin
  result := FID_parte.Value;
end;

procedure TParteProduzione.SetID_parte(const Value: TParte);
begin
  FID_parte.Value := Value;
end;

{ TProdotto }

constructor TProdotto.Create;
begin
  inherited;
  FArticoli.SetInitialValue(TList<TArticolo>.Create);
  FComponenti.SetInitialValue(TList<TComponente>.Create);
end;

destructor TProdotto.Destroy;
begin
  FComponenti.DestroyValue;
  FArticoli.DestroyValue;
  inherited;
end;

function TProdotto.GetArticoli: TList<TArticolo>;
begin
  result := FArticoli.Value;
end;

function TProdotto.GetComponenti: TList<TComponente>;
begin
  result := FComponenti.Value;
end;

{ TArticoloDictionary }

function TArticoloDictionary.ID: TLinqProjection;
begin
  Result := Prop('ID');
end;

function TArticoloDictionary.Qta: TLinqProjection;
begin
  Result := Prop('Qta');
end;

function TArticoloDictionary.ID_Ordine: IOrdineDictionary;
begin
  Result := TOrdineDictionary.Create(PropName('ID_Ordine'));
end;

function TArticoloDictionary.ID_Prodotto: IProdottoDictionary;
begin
  Result := TProdottoDictionary.Create(PropName('ID_Prodotto'));
end;

function TArticoloDictionary.ArticoliProduzione: IArticoloProduzioneDictionary;
begin
  Result := TArticoloProduzioneDictionary.Create(PropName('ArticoliProduzione'));
end;

{ TArticoloProduzioneDictionary }

function TArticoloProduzioneDictionary.ID: TLinqProjection;
begin
  Result := Prop('ID');
end;

function TArticoloProduzioneDictionary.ID_Articolo: IArticoloDictionary;
begin
  Result := TArticoloDictionary.Create(PropName('ID_Articolo'));
end;

function TArticoloProduzioneDictionary.PartiProduzione: IParteProduzioneDictionary;
begin
  Result := TParteProduzioneDictionary.Create(PropName('PartiProduzione'));
end;

{ TClienteDictionary }

function TClienteDictionary.ID: TLinqProjection;
begin
  Result := Prop('ID');
end;

function TClienteDictionary.Nome: TLinqProjection;
begin
  Result := Prop('Nome');
end;

function TClienteDictionary.Ordini: IOrdineDictionary;
begin
  Result := TOrdineDictionary.Create(PropName('Ordini'));
end;

{ TComponenteDictionary }

function TComponenteDictionary.ID: TLinqProjection;
begin
  Result := Prop('ID');
end;

function TComponenteDictionary.Qta: TLinqProjection;
begin
  Result := Prop('Qta');
end;

function TComponenteDictionary.ID_Prodotto: IProdottoDictionary;
begin
  Result := TProdottoDictionary.Create(PropName('ID_Prodotto'));
end;

function TComponenteDictionary.ID_Parte: IParteDictionary;
begin
  Result := TParteDictionary.Create(PropName('ID_Parte'));
end;

{ TFaseDictionary }

function TFaseDictionary.Id: TLinqProjection;
begin
  Result := Prop('Id');
end;

function TFaseDictionary.Descrizione: TLinqProjection;
begin
  Result := Prop('Descrizione');
end;

function TFaseDictionary.PartProgram: TLinqProjection;
begin
  Result := Prop('PartProgram');
end;

function TFaseDictionary.Parte: IParteDictionary;
begin
  Result := TParteDictionary.Create(PropName('Parte'));
end;

function TFaseDictionary.Macchina: IMacchinaDictionary;
begin
  Result := TMacchinaDictionary.Create(PropName('Macchina'));
end;

function TFaseDictionary.FasiProduzioneList: IFaseProduzioneDictionary;
begin
  Result := TFaseProduzioneDictionary.Create(PropName('FasiProduzioneList'));
end;

{ TFaseProduzioneDictionary }

function TFaseProduzioneDictionary.ID: TLinqProjection;
begin
  Result := Prop('ID');
end;

function TFaseProduzioneDictionary.Qta_Richiesta: TLinqProjection;
begin
  Result := Prop('Qta_Richiesta');
end;

function TFaseProduzioneDictionary.Qta_Eseguita: TLinqProjection;
begin
  Result := Prop('Qta_Eseguita');
end;

function TFaseProduzioneDictionary.ID_Parte: IParteProduzioneDictionary;
begin
  Result := TParteProduzioneDictionary.Create(PropName('ID_Parte'));
end;

function TFaseProduzioneDictionary.Id_fase: IFaseDictionary;
begin
  Result := TFaseDictionary.Create(PropName('Id_fase'));
end;

{ TMacchinaDictionary }

function TMacchinaDictionary.Id: TLinqProjection;
begin
  Result := Prop('Id');
end;

function TMacchinaDictionary.DEscrizione: TLinqProjection;
begin
  Result := Prop('DEscrizione');
end;

function TMacchinaDictionary.FasiList: IFaseDictionary;
begin
  Result := TFaseDictionary.Create(PropName('FasiList'));
end;

{ TOrdineDictionary }

function TOrdineDictionary.ID: TLinqProjection;
begin
  Result := Prop('ID');
end;

function TOrdineDictionary.Data: TLinqProjection;
begin
  Result := Prop('Data');
end;

function TOrdineDictionary.Scadenza: TLinqProjection;
begin
  Result := Prop('Scadenza');
end;

function TOrdineDictionary.Cliente: IClienteDictionary;
begin
  Result := TClienteDictionary.Create(PropName('Cliente'));
end;

function TOrdineDictionary.Articoli: IArticoloDictionary;
begin
  Result := TArticoloDictionary.Create(PropName('Articoli'));
end;

{ TParteDictionary }

function TParteDictionary.ID: TLinqProjection;
begin
  Result := Prop('ID');
end;

function TParteDictionary.Descrizione: TLinqProjection;
begin
  Result := Prop('Descrizione');
end;

function TParteDictionary.Componenti: IComponenteDictionary;
begin
  Result := TComponenteDictionary.Create(PropName('Componenti'));
end;

function TParteDictionary.FasiLavorazione: IFaseDictionary;
begin
  Result := TFaseDictionary.Create(PropName('FasiLavorazione'));
end;

function TParteDictionary.PartiProduzione: IParteProduzioneDictionary;
begin
  Result := TParteProduzioneDictionary.Create(PropName('PartiProduzione'));
end;

{ TParteProduzioneDictionary }

function TParteProduzioneDictionary.ID: TLinqProjection;
begin
  Result := Prop('ID');
end;

function TParteProduzioneDictionary.Qta: TLinqProjection;
begin
  Result := Prop('Qta');
end;

function TParteProduzioneDictionary.ID_Articolo: IArticoloProduzioneDictionary;
begin
  Result := TArticoloProduzioneDictionary.Create(PropName('ID_Articolo'));
end;

function TParteProduzioneDictionary.ID_parte: IParteDictionary;
begin
  Result := TParteDictionary.Create(PropName('ID_parte'));
end;

{ TProdottoDictionary }

function TProdottoDictionary.ID: TLinqProjection;
begin
  Result := Prop('ID');
end;

function TProdottoDictionary.Descrizione: TLinqProjection;
begin
  Result := Prop('Descrizione');
end;

function TProdottoDictionary.Articoli: IArticoloDictionary;
begin
  Result := TArticoloDictionary.Create(PropName('Articoli'));
end;

function TProdottoDictionary.Componenti: IComponenteDictionary;
begin
  Result := TComponenteDictionary.Create(PropName('Componenti'));
end;

{ TDictionary }

function TDictionary.Articolo: IArticoloDictionary;
begin
  Result := TArticoloDictionary.Create;
end;

function TDictionary.ArticoloProduzione: IArticoloProduzioneDictionary;
begin
  Result := TArticoloProduzioneDictionary.Create;
end;

function TDictionary.Cliente: IClienteDictionary;
begin
  Result := TClienteDictionary.Create;
end;

function TDictionary.Componente: IComponenteDictionary;
begin
  Result := TComponenteDictionary.Create;
end;

function TDictionary.Fase: IFaseDictionary;
begin
  Result := TFaseDictionary.Create;
end;

function TDictionary.FaseProduzione: IFaseProduzioneDictionary;
begin
  Result := TFaseProduzioneDictionary.Create;
end;

function TDictionary.Macchina: IMacchinaDictionary;
begin
  Result := TMacchinaDictionary.Create;
end;

function TDictionary.Ordine: IOrdineDictionary;
begin
  Result := TOrdineDictionary.Create;
end;

function TDictionary.Parte: IParteDictionary;
begin
  Result := TParteDictionary.Create;
end;

function TDictionary.ParteProduzione: IParteProduzioneDictionary;
begin
  Result := TParteProduzioneDictionary.Create;
end;

function TDictionary.Prodotto: IProdottoDictionary;
begin
  Result := TProdottoDictionary.Create;
end;

initialization
  RegisterEntity(TCliente);
  RegisterEntity(TOrdine);
  RegisterEntity(TArticolo);
  RegisterEntity(TProdotto);
  RegisterEntity(TParte);
  RegisterEntity(TComponente);
  RegisterEntity(TArticoloProduzione);
  RegisterEntity(TParteProduzione);
  RegisterEntity(TFaseProduzione);
  RegisterEntity(TMacchina);
  RegisterEntity(TFase);

end.
