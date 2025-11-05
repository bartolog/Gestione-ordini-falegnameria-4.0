unit UnitName;

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
  TCliente = class;
  TOrdine = class;
  TClienteDictionary = class;
  TOrdineDictionary = class;
  
  [Entity]
  [Table('Clienti')]
  [Id('FID', TIdGenerator.IdentityOrSequence)]
  TCliente = class
  private
    [Column('ID', [TColumnProp.Required, TColumnProp.NoInsert, TColumnProp.NoUpdate])]
    FID: Integer;
    
    [Column('Nome', [TColumnProp.Required], 50)]
    FNome: string;
    
    [ManyValuedAssociation([TAssociationProp.Lazy, TAssociationProp.Required], [TCascadeType.SaveUpdate, TCascadeType.Merge, TCascadeType.Remove], 'F_Cliente')]
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
  [Table('Ordini')]
  [Id('FID', TIdGenerator.None)]
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
    F_Cliente: Proxy<TCliente>;
    function Get_Cliente: TCliente;
    procedure Set_Cliente(const Value: TCliente);
  public
    property ID: Integer read FID write FID;
    property Data: Nullable<TDateTime> read FData write FData;
    property Scadenza: Nullable<TDateTime> read FScadenza write FScadenza;
    property _Cliente: TCliente read Get_Cliente write Set_Cliente;
  end;
  
  IClienteDictionary = interface;
  
  IOrdineDictionary = interface;
  
  IClienteDictionary = interface(IAureliusEntityDictionary)
    function ID: TLinqProjection;
    function Nome: TLinqProjection;
    function Ordini: IOrdineDictionary;
  end;
  
  IOrdineDictionary = interface(IAureliusEntityDictionary)
    function ID: TLinqProjection;
    function Data: TLinqProjection;
    function Scadenza: TLinqProjection;
    function _Cliente: IClienteDictionary;
  end;
  
  TClienteDictionary = class(TAureliusEntityDictionary, IClienteDictionary)
  public
    function ID: TLinqProjection;
    function Nome: TLinqProjection;
    function Ordini: IOrdineDictionary;
  end;
  
  TOrdineDictionary = class(TAureliusEntityDictionary, IOrdineDictionary)
  public
    function ID: TLinqProjection;
    function Data: TLinqProjection;
    function Scadenza: TLinqProjection;
    function _Cliente: IClienteDictionary;
  end;
  
  IDictionary = interface(IAureliusDictionary)
    function Cliente: IClienteDictionary;
    function Ordine: IOrdineDictionary;
  end;
  
  TDictionary = class(TAureliusDictionary, IDictionary)
  public
    function Cliente: IClienteDictionary;
    function Ordine: IOrdineDictionary;
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

{ TOrdine }

function TOrdine.Get_Cliente: TCliente;
begin
  result := F_Cliente.Value;
end;

procedure TOrdine.Set_Cliente(const Value: TCliente);
begin
  F_Cliente.Value := Value;
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

function TOrdineDictionary._Cliente: IClienteDictionary;
begin
  Result := TClienteDictionary.Create(PropName('_Cliente'));
end;

{ TDictionary }

function TDictionary.Cliente: IClienteDictionary;
begin
  Result := TClienteDictionary.Create;
end;

function TDictionary.Ordine: IOrdineDictionary;
begin
  Result := TOrdineDictionary.Create;
end;

initialization
  RegisterEntity(TCliente);
  RegisterEntity(TOrdine);

end.
