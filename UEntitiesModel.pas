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
  Aurelius.Criteria.Dictionary;

type
  Tarticolo = class;
  Tarticoloproduzione = class;
  Tcliente = class;
  Tcomponente = class;
  Tfase = class;
  Tfaseproduzione = class;
  Tmacchina = class;
  Tordine = class;
  Tparte = class;
  Tparteproduzione = class;
  Tprodotto = class;
  TarticoloTableDictionary = class;
  TarticoloproduzioneTableDictionary = class;
  TclienteTableDictionary = class;
  TcomponenteTableDictionary = class;
  TfaseTableDictionary = class;
  TfaseproduzioneTableDictionary = class;
  TmacchinaTableDictionary = class;
  TordineTableDictionary = class;
  TparteTableDictionary = class;
  TparteproduzioneTableDictionary = class;
  TprodottoTableDictionary = class;
  
  [Entity]
  [Table('articoli')]
  [Id('FID', TIdGenerator.IdentityOrSequence)]
  Tarticolo = class
  private
    [Column('ID', [TColumnProp.Required, TColumnProp.NoInsert, TColumnProp.NoUpdate])]
    FID: Integer;
    
    [Column('Qta', [])]
    FQta: Nullable<Integer>;
    
    [Association([TAssociationProp.Lazy, TAssociationProp.Required], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('ID_Ordine', [TColumnProp.Required], 'ID')]
    FID_Ordine: Proxy<Tordine>;
    
    [Association([TAssociationProp.Lazy], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('ID_Prodotto', [], 'ID')]
    FID_Prodotto: Proxy<Tprodotto>;
    
    [ManyValuedAssociation([TAssociationProp.Lazy], [TCascadeType.SaveUpdate, TCascadeType.Merge], 'FID_Articolo')]
    Farticoliproduzione: Proxy<TList<Tarticoloproduzione>>;
    function GetID_Ordine: Tordine;
    procedure SetID_Ordine(const Value: Tordine);
    function GetID_Prodotto: Tprodotto;
    procedure SetID_Prodotto(const Value: Tprodotto);
    function Getarticoliproduzione: TList<Tarticoloproduzione>;
  public
    constructor Create;
    destructor Destroy; override;
    property ID: Integer read FID write FID;
    property Qta: Nullable<Integer> read FQta write FQta;
    property ID_Ordine: Tordine read GetID_Ordine write SetID_Ordine;
    property ID_Prodotto: Tprodotto read GetID_Prodotto write SetID_Prodotto;
    property articoliproduzione: TList<Tarticoloproduzione> read Getarticoliproduzione;
  end;
  
  [Entity]
  [Table('articoliproduzione')]
  [Id('FID', TIdGenerator.IdentityOrSequence)]
  Tarticoloproduzione = class
  private
    [Column('ID', [TColumnProp.Required, TColumnProp.NoInsert, TColumnProp.NoUpdate])]
    FID: Integer;
    
    [Association([TAssociationProp.Lazy], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('ID_Articolo', [], 'ID')]
    FID_Articolo: Proxy<Tarticolo>;
    
    [ManyValuedAssociation([TAssociationProp.Lazy, TAssociationProp.Required], [TCascadeType.SaveUpdate, TCascadeType.Merge], 'FID_Articolo')]
    Fpartiproduzione: Proxy<TList<Tparteproduzione>>;
    FStato: double;
    function GetID_Articolo: Tarticolo;
    procedure SetID_Articolo(const Value: Tarticolo);
    function Getpartiproduzione: TList<Tparteproduzione>;
    function GetStato : integer;
  public
    constructor Create;
    destructor Destroy; override;
    property ID: Integer read FID write FID;
    property ID_Articolo: Tarticolo read GetID_Articolo write SetID_Articolo;
    property partiproduzione: TList<Tparteproduzione> read Getpartiproduzione;
    property Stato: integer read GetStato ;
  end;
  
  [Entity]
  [Table('clienti')]
  [Id('FID', TIdGenerator.IdentityOrSequence)]
  Tcliente = class
  private
    [Column('ID', [TColumnProp.Required, TColumnProp.NoInsert, TColumnProp.NoUpdate])]
    FID: Integer;
    
    [Column('Nome', [TColumnProp.Required], 50)]
    FNome: string;
    
    [ManyValuedAssociation([TAssociationProp.Lazy, TAssociationProp.Required], [TCascadeType.SaveUpdate, TCascadeType.Merge], 'FCliente')]
    Fordini: Proxy<TList<Tordine>>;
    function Getordini: TList<Tordine>;
  public
    constructor Create;
    destructor Destroy; override;
    property ID: Integer read FID write FID;
    property Nome: string read FNome write FNome;
    property ordini: TList<Tordine> read Getordini;
  end;
  
  [Entity]
  [Table('componenti')]
  [Id('FID', TIdGenerator.IdentityOrSequence)]
  Tcomponente = class
  private
    [Column('ID', [TColumnProp.Required, TColumnProp.NoInsert, TColumnProp.NoUpdate])]
    FID: Integer;
    
    [Column('Qta', [])]
    FQta: Nullable<Integer>;
    
    [Association([TAssociationProp.Lazy], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('ID_Parte', [], 'ID')]
    FID_Parte: Proxy<Tparte>;
    
    [Association([TAssociationProp.Lazy], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('ID_Prodotto', [], 'ID')]
    FID_Prodotto: Proxy<Tprodotto>;
    function GetID_Parte: Tparte;
    procedure SetID_Parte(const Value: Tparte);
    function GetID_Prodotto: Tprodotto;
    procedure SetID_Prodotto(const Value: Tprodotto);
  public
    property ID: Integer read FID write FID;
    property Qta: Nullable<Integer> read FQta write FQta;
    property ID_Parte: Tparte read GetID_Parte write SetID_Parte;
    property ID_Prodotto: Tprodotto read GetID_Prodotto write SetID_Prodotto;
  end;
  
  [Entity]
  [Table('fasi')]
  [Id('FId', TIdGenerator.IdentityOrSequence)]
  Tfase = class
  private
    [Column('Id', [TColumnProp.Required, TColumnProp.NoInsert, TColumnProp.NoUpdate])]
    FId: Integer;
    
    [Column('Descrizione', [], 50)]
    FDescrizione: Nullable<string>;
    
    [Column('PartProgram', [], 80)]
    FPartProgram: Nullable<string>;
    
    [Association([TAssociationProp.Lazy, TAssociationProp.Required], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('Id_Macchina', [TColumnProp.Required], 'Id')]
    FMacchina: Proxy<Tmacchina>;
    
    [Association([TAssociationProp.Lazy, TAssociationProp.Required], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('ID_Parte', [TColumnProp.Required], 'ID')]
    FID_Parte: Proxy<Tparte>;
    function GetMacchina: Tmacchina;
    procedure SetMacchina(const Value: Tmacchina);
    function GetID_Parte: Tparte;
    procedure SetID_Parte(const Value: Tparte);
  public
    property Id: Integer read FId write FId;
    property Descrizione: Nullable<string> read FDescrizione write FDescrizione;
    property PartProgram: Nullable<string> read FPartProgram write FPartProgram;
    property Macchina: Tmacchina read GetMacchina write SetMacchina;
    property ID_Parte: Tparte read GetID_Parte write SetID_Parte;
  end;
  
  [Entity]
  [Table('fasiproduzione')]
  [Id('FID', TIdGenerator.IdentityOrSequence)]
  Tfaseproduzione = class
  private
    [Column('ID', [TColumnProp.Required, TColumnProp.NoInsert, TColumnProp.NoUpdate])]
    FID: Integer;
    
    [Column('Qta_Richiesta', [])]
    FQta_Richiesta: Nullable<Integer>;
    
    [Column('Qta_Eseguita', [])]
    FQta_Eseguita: Nullable<Integer>;
    
    [Association([TAssociationProp.Lazy, TAssociationProp.Required], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('Id_fase', [TColumnProp.Required], 'Id')]
    FId_fase: Proxy<Tfase>;
    
    [Association([TAssociationProp.Lazy, TAssociationProp.Required], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('ID_Parte', [TColumnProp.Required], 'ID')]
    FID_Parte: Proxy<Tparteproduzione>;
    FStato: double;
    function GetId_fase: Tfase;
    procedure SetId_fase(const Value: Tfase);
    function GetID_Parte: Tparteproduzione;
    procedure SetID_Parte(const Value: Tparteproduzione);
    function GetStato : integer;
  public
    property ID: Integer read FID write FID;
    property Qta_Richiesta: Nullable<Integer> read FQta_Richiesta write FQta_Richiesta;
    property Qta_Eseguita: Nullable<Integer> read FQta_Eseguita write FQta_Eseguita;
    property Id_fase: Tfase read GetId_fase write SetId_fase;
    property ID_Parte: Tparteproduzione read GetID_Parte write SetID_Parte;
    property Stato: Integer read GetStato ;
  end;
  
  [Entity]
  [Table('macchine')]
  [Id('FId', TIdGenerator.IdentityOrSequence)]
  Tmacchina = class
  private
    [Column('Id', [TColumnProp.Required, TColumnProp.NoInsert, TColumnProp.NoUpdate])]
    FId: Integer;
    
    [Column('DEscrizione', [], 50)]
    FDEscrizione: Nullable<string>;
    
    [ManyValuedAssociation([TAssociationProp.Lazy, TAssociationProp.Required], [TCascadeType.SaveUpdate, TCascadeType.Merge], 'FMacchina')]
    Ffasi: Proxy<TList<Tfase>>;
    function Getfasi: TList<Tfase>;
  public
    constructor Create;
    destructor Destroy; override;
    property Id: Integer read FId write FId;
    property DEscrizione: Nullable<string> read FDEscrizione write FDEscrizione;
    property fasi: TList<Tfase> read Getfasi;
  end;
  
  [Entity]
  [Table('ordini')]
  [Id('FID', TIdGenerator.IdentityOrSequence)]
  Tordine = class
  private
    [Column('ID', [TColumnProp.Required, TColumnProp.NoInsert, TColumnProp.NoUpdate])]
    FID: Integer;
    
    [Column('Data', [])]
    FData: Nullable<TDateTime>;
    
    [Column('Scadenza', [])]
    FScadenza: Nullable<TDateTime>;
    
    [Association([TAssociationProp.Lazy, TAssociationProp.Required], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('ID_Cliente', [TColumnProp.Required], 'ID')]
    FCliente: Proxy<Tcliente>;
    
    [ManyValuedAssociation([TAssociationProp.Lazy, TAssociationProp.Required], [TCascadeType.SaveUpdate, TCascadeType.Merge], 'FID_Ordine')]
    Farticoli: Proxy<TList<Tarticolo>>;
    function GetCliente: Tcliente;
    procedure SetCliente(const Value: Tcliente);
    function Getarticoli: TList<Tarticolo>;
  public
    constructor Create;
    destructor Destroy; override;
    property ID: Integer read FID write FID;
    property Data: Nullable<TDateTime> read FData write FData;
    property Scadenza: Nullable<TDateTime> read FScadenza write FScadenza;
    property Cliente: Tcliente read GetCliente write SetCliente;
    property articoli: TList<Tarticolo> read Getarticoli;
  end;
  
  [Entity]
  [Table('parti')]
  [Id('FID', TIdGenerator.IdentityOrSequence)]
  Tparte = class
  private
    [Column('ID', [TColumnProp.Required, TColumnProp.NoInsert, TColumnProp.NoUpdate])]
    FID: Integer;
    
    [Column('Descrizione', [], 50)]
    FDescrizione: Nullable<string>;
    
    [ManyValuedAssociation([TAssociationProp.Lazy], [TCascadeType.SaveUpdate, TCascadeType.Merge], 'FID_Parte')]
    Fcomponenti: Proxy<TList<Tcomponente>>;
    
    [ManyValuedAssociation([TAssociationProp.Lazy, TAssociationProp.Required], [TCascadeType.SaveUpdate, TCascadeType.Merge], 'FID_Parte')]
    FfasiLavorazione: Proxy<TList<Tfase>>;
    
    [ManyValuedAssociation([TAssociationProp.Lazy, TAssociationProp.Required], [TCascadeType.SaveUpdate, TCascadeType.Merge], 'FID_parte')]
    Fpartiproduzione: Proxy<TList<Tparteproduzione>>;
    function Getcomponenti: TList<Tcomponente>;
    function GetfasiLavorazione: TList<Tfase>;
    function Getpartiproduzione: TList<Tparteproduzione>;
  public
    constructor Create;
    destructor Destroy; override;
    property ID: Integer read FID write FID;
    property Descrizione: Nullable<string> read FDescrizione write FDescrizione;
    property componenti: TList<Tcomponente> read Getcomponenti;
    property fasiLavorazione: TList<Tfase> read GetfasiLavorazione;
    property partiproduzione: TList<Tparteproduzione> read Getpartiproduzione;
  end;
  
  [Entity]
  [Table('partiproduzione')]
  [Id('FID', TIdGenerator.IdentityOrSequence)]
  Tparteproduzione = class
  private
    [Column('ID', [TColumnProp.Required, TColumnProp.NoInsert, TColumnProp.NoUpdate])]
    FID: Integer;
    
    [Column('Qta', [])]
    FQta: Nullable<Integer>;
    
    [Association([TAssociationProp.Lazy, TAssociationProp.Required], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('ID_Articolo', [TColumnProp.Required], 'ID')]
    FID_Articolo: Proxy<Tarticoloproduzione>;
    
    [Association([TAssociationProp.Lazy, TAssociationProp.Required], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('ID_parte', [TColumnProp.Required], 'ID')]
    FID_parte: Proxy<Tparte>;
    
    [ManyValuedAssociation([TAssociationProp.Lazy, TAssociationProp.Required], [TCascadeType.SaveUpdate, TCascadeType.Merge], 'FID_Parte')]
    Ffasiproduzione: Proxy<TList<Tfaseproduzione>>;
    function GetID_Articolo: Tarticoloproduzione;
    procedure SetID_Articolo(const Value: Tarticoloproduzione);
    function GetID_parte: Tparte;
    procedure SetID_parte(const Value: Tparte);
    function Getfasiproduzione: TList<Tfaseproduzione>;
    function GetStato : Integer;
  public
    constructor Create;
    destructor Destroy; override;
    property ID: Integer read FID write FID;
    property Qta: Nullable<Integer> read FQta write FQta;
    property ID_Articolo: Tarticoloproduzione read GetID_Articolo write SetID_Articolo;
    property ID_parte: Tparte read GetID_parte write SetID_parte;
    property fasiproduzione: TList<Tfaseproduzione> read Getfasiproduzione;
    property Stato: Integer read GetStato;
  end;
  
  [Entity]
  [Table('prodotti')]
  [Id('FID', TIdGenerator.IdentityOrSequence)]
  Tprodotto = class
  private
    [Column('ID', [TColumnProp.Required, TColumnProp.NoInsert, TColumnProp.NoUpdate])]
    FID: Integer;
    
    [Column('Descrizione', [], 50)]
    FDescrizione: Nullable<string>;
    
    [ManyValuedAssociation([TAssociationProp.Lazy], [TCascadeType.SaveUpdate, TCascadeType.Merge], 'FID_Prodotto')]
    Fcomponenti: Proxy<TList<Tcomponente>>;
    function Getcomponenti: TList<Tcomponente>;
  public
    constructor Create;
    destructor Destroy; override;
    property ID: Integer read FID write FID;
    property Descrizione: Nullable<string> read FDescrizione write FDescrizione;
    property componenti: TList<Tcomponente> read Getcomponenti;
  end;
  
  TDicDictionary = class
  private
    Farticolo: TarticoloTableDictionary;
    Farticoloproduzione: TarticoloproduzioneTableDictionary;
    Fcliente: TclienteTableDictionary;
    Fcomponente: TcomponenteTableDictionary;
    Ffase: TfaseTableDictionary;
    Ffaseproduzione: TfaseproduzioneTableDictionary;
    Fmacchina: TmacchinaTableDictionary;
    Fordine: TordineTableDictionary;
    Fparte: TparteTableDictionary;
    Fparteproduzione: TparteproduzioneTableDictionary;
    Fprodotto: TprodottoTableDictionary;
    function Getarticolo: TarticoloTableDictionary;
    function Getarticoloproduzione: TarticoloproduzioneTableDictionary;
    function Getcliente: TclienteTableDictionary;
    function Getcomponente: TcomponenteTableDictionary;
    function Getfase: TfaseTableDictionary;
    function Getfaseproduzione: TfaseproduzioneTableDictionary;
    function Getmacchina: TmacchinaTableDictionary;
    function Getordine: TordineTableDictionary;
    function Getparte: TparteTableDictionary;
    function Getparteproduzione: TparteproduzioneTableDictionary;
    function Getprodotto: TprodottoTableDictionary;
  public
    destructor Destroy; override;
    property articolo: TarticoloTableDictionary read Getarticolo;
    property articoloproduzione: TarticoloproduzioneTableDictionary read Getarticoloproduzione;
    property cliente: TclienteTableDictionary read Getcliente;
    property componente: TcomponenteTableDictionary read Getcomponente;
    property fase: TfaseTableDictionary read Getfase;
    property faseproduzione: TfaseproduzioneTableDictionary read Getfaseproduzione;
    property macchina: TmacchinaTableDictionary read Getmacchina;
    property ordine: TordineTableDictionary read Getordine;
    property parte: TparteTableDictionary read Getparte;
    property parteproduzione: TparteproduzioneTableDictionary read Getparteproduzione;
    property prodotto: TprodottoTableDictionary read Getprodotto;
  end;
  
  TarticoloTableDictionary = class
  private
    FID: TDictionaryAttribute;
    FQta: TDictionaryAttribute;
    FID_Ordine: TDictionaryAssociation;
    FID_Prodotto: TDictionaryAssociation;
  public
    constructor Create;
    property ID: TDictionaryAttribute read FID;
    property Qta: TDictionaryAttribute read FQta;
    property ID_Ordine: TDictionaryAssociation read FID_Ordine;
    property ID_Prodotto: TDictionaryAssociation read FID_Prodotto;
  end;
  
  TarticoloproduzioneTableDictionary = class
  private
    FID: TDictionaryAttribute;
    FID_Articolo: TDictionaryAssociation;
  public
    constructor Create;
    property ID: TDictionaryAttribute read FID;
    property ID_Articolo: TDictionaryAssociation read FID_Articolo;
  end;
  
  TclienteTableDictionary = class
  private
    FID: TDictionaryAttribute;
    FNome: TDictionaryAttribute;
  public
    constructor Create;
    property ID: TDictionaryAttribute read FID;
    property Nome: TDictionaryAttribute read FNome;
  end;
  
  TcomponenteTableDictionary = class
  private
    FID: TDictionaryAttribute;
    FQta: TDictionaryAttribute;
    FID_Parte: TDictionaryAssociation;
    FID_Prodotto: TDictionaryAssociation;
  public
    constructor Create;
    property ID: TDictionaryAttribute read FID;
    property Qta: TDictionaryAttribute read FQta;
    property ID_Parte: TDictionaryAssociation read FID_Parte;
    property ID_Prodotto: TDictionaryAssociation read FID_Prodotto;
  end;
  
  TfaseTableDictionary = class
  private
    FId: TDictionaryAttribute;
    FDescrizione: TDictionaryAttribute;
    FPartProgram: TDictionaryAttribute;
    FMacchina: TDictionaryAssociation;
    FID_Parte: TDictionaryAssociation;
  public
    constructor Create;
    property Id: TDictionaryAttribute read FId;
    property Descrizione: TDictionaryAttribute read FDescrizione;
    property PartProgram: TDictionaryAttribute read FPartProgram;
    property Macchina: TDictionaryAssociation read FMacchina;
    property ID_Parte: TDictionaryAssociation read FID_Parte;
  end;
  
  TfaseproduzioneTableDictionary = class
  private
    FID: TDictionaryAttribute;
    FQta_Richiesta: TDictionaryAttribute;
    FQta_Eseguita: TDictionaryAttribute;
    FId_fase: TDictionaryAssociation;
    FID_Parte: TDictionaryAssociation;
  public
    constructor Create;
    property ID: TDictionaryAttribute read FID;
    property Qta_Richiesta: TDictionaryAttribute read FQta_Richiesta;
    property Qta_Eseguita: TDictionaryAttribute read FQta_Eseguita;
    property Id_fase: TDictionaryAssociation read FId_fase;
    property ID_Parte: TDictionaryAssociation read FID_Parte;
  end;
  
  TmacchinaTableDictionary = class
  private
    FId: TDictionaryAttribute;
    FDEscrizione: TDictionaryAttribute;
  public
    constructor Create;
    property Id: TDictionaryAttribute read FId;
    property DEscrizione: TDictionaryAttribute read FDEscrizione;
  end;
  
  TordineTableDictionary = class
  private
    FID: TDictionaryAttribute;
    FData: TDictionaryAttribute;
    FScadenza: TDictionaryAttribute;
    FCliente: TDictionaryAssociation;
  public
    constructor Create;
    property ID: TDictionaryAttribute read FID;
    property Data: TDictionaryAttribute read FData;
    property Scadenza: TDictionaryAttribute read FScadenza;
    property Cliente: TDictionaryAssociation read FCliente;
  end;
  
  TparteTableDictionary = class
  private
    FID: TDictionaryAttribute;
    FDescrizione: TDictionaryAttribute;
  public
    constructor Create;
    property ID: TDictionaryAttribute read FID;
    property Descrizione: TDictionaryAttribute read FDescrizione;
  end;
  
  TparteproduzioneTableDictionary = class
  private
    FID: TDictionaryAttribute;
    FQta: TDictionaryAttribute;
    FID_Articolo: TDictionaryAssociation;
    FID_parte: TDictionaryAssociation;
  public
    constructor Create;
    property ID: TDictionaryAttribute read FID;
    property Qta: TDictionaryAttribute read FQta;
    property ID_Articolo: TDictionaryAssociation read FID_Articolo;
    property ID_parte: TDictionaryAssociation read FID_parte;
  end;
  
  TprodottoTableDictionary = class
  private
    FID: TDictionaryAttribute;
    FDescrizione: TDictionaryAttribute;
  public
    constructor Create;
    property ID: TDictionaryAttribute read FID;
    property Descrizione: TDictionaryAttribute read FDescrizione;
  end;
  
function Dic: TDicDictionary;

implementation

var
  __Dic: TDicDictionary;

function Dic: TDicDictionary;
begin
  if __Dic = nil then __Dic := TDicDictionary.Create;
  result := __Dic
end;

{ Tarticolo }

function Tarticolo.GetID_Ordine: Tordine;
begin
  result := FID_Ordine.Value;
end;

procedure Tarticolo.SetID_Ordine(const Value: Tordine);
begin
  FID_Ordine.Value := Value;
end;

function Tarticolo.GetID_Prodotto: Tprodotto;
begin
  result := FID_Prodotto.Value;
end;

procedure Tarticolo.SetID_Prodotto(const Value: Tprodotto);
begin
  FID_Prodotto.Value := Value;
end;

constructor Tarticolo.Create;
begin
  inherited;
  Farticoliproduzione.SetInitialValue(TList<Tarticoloproduzione>.Create);
end;

destructor Tarticolo.Destroy;
begin
  Farticoliproduzione.DestroyValue;
  inherited;
end;

function Tarticolo.Getarticoliproduzione: TList<Tarticoloproduzione>;
begin
  result := Farticoliproduzione.Value;
end;

{ Tarticoloproduzione }

function Tarticoloproduzione.GetID_Articolo: Tarticolo;
begin
  result := FID_Articolo.Value;
end;

procedure Tarticoloproduzione.SetID_Articolo(const Value: Tarticolo);
begin
  FID_Articolo.Value := Value;
end;

constructor Tarticoloproduzione.Create;
begin
  inherited;
  Fpartiproduzione.SetInitialValue(TList<Tparteproduzione>.Create);
end;

destructor Tarticoloproduzione.Destroy;
begin
  Fpartiproduzione.DestroyValue;
  inherited;
end;

function Tarticoloproduzione.Getpartiproduzione: TList<Tparteproduzione>;
begin
  result := Fpartiproduzione.Value;
end;

function Tarticoloproduzione.GetStato: integer;
begin

    var conta := 0;
    var Totale := 0;
    for var p in partiproduzione do
    begin
       inc(conta);
       inc(Totale,p.Stato)

    end;
    result := totale div conta
end;

{ Tcliente }

constructor Tcliente.Create;
begin
  inherited;
  Fordini.SetInitialValue(TList<Tordine>.Create);
end;

destructor Tcliente.Destroy;
begin
  Fordini.DestroyValue;
  inherited;
end;

function Tcliente.Getordini: TList<Tordine>;
begin
  result := Fordini.Value;
end;

{ Tcomponente }

function Tcomponente.GetID_Parte: Tparte;
begin
  result := FID_Parte.Value;
end;

procedure Tcomponente.SetID_Parte(const Value: Tparte);
begin
  FID_Parte.Value := Value;
end;

function Tcomponente.GetID_Prodotto: Tprodotto;
begin
  result := FID_Prodotto.Value;
end;

procedure Tcomponente.SetID_Prodotto(const Value: Tprodotto);
begin
  FID_Prodotto.Value := Value;
end;

{ Tfase }

function Tfase.GetMacchina: Tmacchina;
begin
  result := FMacchina.Value;
end;

procedure Tfase.SetMacchina(const Value: Tmacchina);
begin
  FMacchina.Value := Value;
end;

function Tfase.GetID_Parte: Tparte;
begin
  result := FID_Parte.Value;
end;

procedure Tfase.SetID_Parte(const Value: Tparte);
begin
  FID_Parte.Value := Value;
end;

{ Tfaseproduzione }

function Tfaseproduzione.GetId_fase: Tfase;
begin
  result := FId_fase.Value;
end;

procedure Tfaseproduzione.SetId_fase(const Value: Tfase);
begin
  FId_fase.Value := Value;
end;

function Tfaseproduzione.GetID_Parte: Tparteproduzione;
begin
  result := FID_Parte.Value;
end;

function Tfaseproduzione.GetStato: integer;
begin
  result :=   Qta_Eseguita.Value div Qta_Richiesta.Value  * 100
end;

procedure Tfaseproduzione.SetID_Parte(const Value: Tparteproduzione);
begin
  FID_Parte.Value := Value;
end;

{ Tmacchina }

constructor Tmacchina.Create;
begin
  inherited;
  Ffasi.SetInitialValue(TList<Tfase>.Create);
end;

destructor Tmacchina.Destroy;
begin
  Ffasi.DestroyValue;
  inherited;
end;

function Tmacchina.Getfasi: TList<Tfase>;
begin
  result := Ffasi.Value;
end;

{ Tordine }

function Tordine.GetCliente: Tcliente;
begin
  result := FCliente.Value;
end;

procedure Tordine.SetCliente(const Value: Tcliente);
begin
  FCliente.Value := Value;
end;

constructor Tordine.Create;
begin
  inherited;
  Farticoli.SetInitialValue(TList<Tarticolo>.Create);
end;

destructor Tordine.Destroy;
begin
  Farticoli.DestroyValue;
  inherited;
end;

function Tordine.Getarticoli: TList<Tarticolo>;
begin
  result := Farticoli.Value;
end;

{ Tparte }

constructor Tparte.Create;
begin
  inherited;
  Fcomponenti.SetInitialValue(TList<Tcomponente>.Create);
  FfasiLavorazione.SetInitialValue(TList<Tfase>.Create);
  Fpartiproduzione.SetInitialValue(TList<Tparteproduzione>.Create);
end;

destructor Tparte.Destroy;
begin
  Fpartiproduzione.DestroyValue;
  FfasiLavorazione.DestroyValue;
  Fcomponenti.DestroyValue;
  inherited;
end;

function Tparte.Getcomponenti: TList<Tcomponente>;
begin
  result := Fcomponenti.Value;
end;

function Tparte.GetfasiLavorazione: TList<Tfase>;
begin
  result := FfasiLavorazione.Value;
end;

function Tparte.Getpartiproduzione: TList<Tparteproduzione>;
begin
  result := Fpartiproduzione.Value;
end;

{ Tparteproduzione }

function Tparteproduzione.GetID_Articolo: Tarticoloproduzione;
begin
  result := FID_Articolo.Value;
end;

procedure Tparteproduzione.SetID_Articolo(const Value: Tarticoloproduzione);
begin
  FID_Articolo.Value := Value;
end;

function Tparteproduzione.GetID_parte: Tparte;
begin
  result := FID_parte.Value;
end;

function Tparteproduzione.GetStato: integer;
begin
    var conta := 0;
    var Totale := 0;

    for var f in fasiproduzione do
    begin

      inc(Totale, f.Stato);
      inc(conta)


    end;

    result :=  Totale div conta
end;

procedure Tparteproduzione.SetID_parte(const Value: Tparte);
begin
  FID_parte.Value := Value;
end;

constructor Tparteproduzione.Create;
begin
  inherited;
  Ffasiproduzione.SetInitialValue(TList<Tfaseproduzione>.Create);
end;

destructor Tparteproduzione.Destroy;
begin
  Ffasiproduzione.DestroyValue;
  inherited;
end;

function Tparteproduzione.Getfasiproduzione: TList<Tfaseproduzione>;
begin
  result := Ffasiproduzione.Value;
end;

{ Tprodotto }

constructor Tprodotto.Create;
begin
  inherited;
  Fcomponenti.SetInitialValue(TList<Tcomponente>.Create);
end;

destructor Tprodotto.Destroy;
begin
  Fcomponenti.DestroyValue;
  inherited;
end;

function Tprodotto.Getcomponenti: TList<Tcomponente>;
begin
  result := Fcomponenti.Value;
end;

{ TDicDictionary }

destructor TDicDictionary.Destroy;
begin
  if Fprodotto <> nil then Fprodotto.Free;
  if Fparteproduzione <> nil then Fparteproduzione.Free;
  if Fparte <> nil then Fparte.Free;
  if Fordine <> nil then Fordine.Free;
  if Fmacchina <> nil then Fmacchina.Free;
  if Ffaseproduzione <> nil then Ffaseproduzione.Free;
  if Ffase <> nil then Ffase.Free;
  if Fcomponente <> nil then Fcomponente.Free;
  if Fcliente <> nil then Fcliente.Free;
  if Farticoloproduzione <> nil then Farticoloproduzione.Free;
  if Farticolo <> nil then Farticolo.Free;
  inherited;
end;

function TDicDictionary.Getarticolo: TarticoloTableDictionary;
begin
  if Farticolo = nil then Farticolo := TarticoloTableDictionary.Create;
  result := Farticolo;
end;

function TDicDictionary.Getarticoloproduzione: TarticoloproduzioneTableDictionary;
begin
  if Farticoloproduzione = nil then Farticoloproduzione := TarticoloproduzioneTableDictionary.Create;
  result := Farticoloproduzione;
end;

function TDicDictionary.Getcliente: TclienteTableDictionary;
begin
  if Fcliente = nil then Fcliente := TclienteTableDictionary.Create;
  result := Fcliente;
end;

function TDicDictionary.Getcomponente: TcomponenteTableDictionary;
begin
  if Fcomponente = nil then Fcomponente := TcomponenteTableDictionary.Create;
  result := Fcomponente;
end;

function TDicDictionary.Getfase: TfaseTableDictionary;
begin
  if Ffase = nil then Ffase := TfaseTableDictionary.Create;
  result := Ffase;
end;

function TDicDictionary.Getfaseproduzione: TfaseproduzioneTableDictionary;
begin
  if Ffaseproduzione = nil then Ffaseproduzione := TfaseproduzioneTableDictionary.Create;
  result := Ffaseproduzione;
end;

function TDicDictionary.Getmacchina: TmacchinaTableDictionary;
begin
  if Fmacchina = nil then Fmacchina := TmacchinaTableDictionary.Create;
  result := Fmacchina;
end;

function TDicDictionary.Getordine: TordineTableDictionary;
begin
  if Fordine = nil then Fordine := TordineTableDictionary.Create;
  result := Fordine;
end;

function TDicDictionary.Getparte: TparteTableDictionary;
begin
  if Fparte = nil then Fparte := TparteTableDictionary.Create;
  result := Fparte;
end;

function TDicDictionary.Getparteproduzione: TparteproduzioneTableDictionary;
begin
  if Fparteproduzione = nil then Fparteproduzione := TparteproduzioneTableDictionary.Create;
  result := Fparteproduzione;
end;

function TDicDictionary.Getprodotto: TprodottoTableDictionary;
begin
  if Fprodotto = nil then Fprodotto := TprodottoTableDictionary.Create;
  result := Fprodotto;
end;

{ TarticoloTableDictionary }

constructor TarticoloTableDictionary.Create;
begin
  inherited;
  FID := TDictionaryAttribute.Create('ID');
  FQta := TDictionaryAttribute.Create('Qta');
  FID_Ordine := TDictionaryAssociation.Create('ID_Ordine');
  FID_Prodotto := TDictionaryAssociation.Create('ID_Prodotto');
end;

{ TarticoloproduzioneTableDictionary }

constructor TarticoloproduzioneTableDictionary.Create;
begin
  inherited;
  FID := TDictionaryAttribute.Create('ID');
  FID_Articolo := TDictionaryAssociation.Create('ID_Articolo');
end;

{ TclienteTableDictionary }

constructor TclienteTableDictionary.Create;
begin
  inherited;
  FID := TDictionaryAttribute.Create('ID');
  FNome := TDictionaryAttribute.Create('Nome');
end;

{ TcomponenteTableDictionary }

constructor TcomponenteTableDictionary.Create;
begin
  inherited;
  FID := TDictionaryAttribute.Create('ID');
  FQta := TDictionaryAttribute.Create('Qta');
  FID_Parte := TDictionaryAssociation.Create('ID_Parte');
  FID_Prodotto := TDictionaryAssociation.Create('ID_Prodotto');
end;

{ TfaseTableDictionary }

constructor TfaseTableDictionary.Create;
begin
  inherited;
  FId := TDictionaryAttribute.Create('Id');
  FDescrizione := TDictionaryAttribute.Create('Descrizione');
  FPartProgram := TDictionaryAttribute.Create('PartProgram');
  FMacchina := TDictionaryAssociation.Create('Macchina');
  FID_Parte := TDictionaryAssociation.Create('ID_Parte');
end;

{ TfaseproduzioneTableDictionary }

constructor TfaseproduzioneTableDictionary.Create;
begin
  inherited;
  FID := TDictionaryAttribute.Create('ID');
  FQta_Richiesta := TDictionaryAttribute.Create('Qta_Richiesta');
  FQta_Eseguita := TDictionaryAttribute.Create('Qta_Eseguita');
  FId_fase := TDictionaryAssociation.Create('Id_fase');
  FID_Parte := TDictionaryAssociation.Create('ID_Parte');
end;

{ TmacchinaTableDictionary }

constructor TmacchinaTableDictionary.Create;
begin
  inherited;
  FId := TDictionaryAttribute.Create('Id');
  FDEscrizione := TDictionaryAttribute.Create('DEscrizione');
end;

{ TordineTableDictionary }

constructor TordineTableDictionary.Create;
begin
  inherited;
  FID := TDictionaryAttribute.Create('ID');
  FData := TDictionaryAttribute.Create('Data');
  FScadenza := TDictionaryAttribute.Create('Scadenza');
  FCliente := TDictionaryAssociation.Create('Cliente');
end;

{ TparteTableDictionary }

constructor TparteTableDictionary.Create;
begin
  inherited;
  FID := TDictionaryAttribute.Create('ID');
  FDescrizione := TDictionaryAttribute.Create('Descrizione');
end;

{ TparteproduzioneTableDictionary }

constructor TparteproduzioneTableDictionary.Create;
begin
  inherited;
  FID := TDictionaryAttribute.Create('ID');
  FQta := TDictionaryAttribute.Create('Qta');
  FID_Articolo := TDictionaryAssociation.Create('ID_Articolo');
  FID_parte := TDictionaryAssociation.Create('ID_parte');
end;

{ TprodottoTableDictionary }

constructor TprodottoTableDictionary.Create;
begin
  inherited;
  FID := TDictionaryAttribute.Create('ID');
  FDescrizione := TDictionaryAttribute.Create('Descrizione');
end;

initialization
  RegisterEntity(Tarticolo);
  RegisterEntity(Tarticoloproduzione);
  RegisterEntity(Tcliente);
  RegisterEntity(Tcomponente);
  RegisterEntity(Tfase);
  RegisterEntity(Tfaseproduzione);
  RegisterEntity(Tmacchina);
  RegisterEntity(Tordine);
  RegisterEntity(Tparte);
  RegisterEntity(Tparteproduzione);
  RegisterEntity(Tprodotto);

finalization
  if __Dic <> nil then __Dic.Free

end.
