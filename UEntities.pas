unit UEntities;


interface


uses
Aurelius.Mapping.Attributes, Aurelius.Types.Proxy, Generics.Collections;

type



TCliente = class;
TOrdine = class;


[Entity]

[Automapping]
TCliente = class
private
FID : Integer;

[Column('Nome',[TColumnProp.Required],50)]
FNome : string;




FOrdini :  Proxy<TList<TOrdine>>;

public


property ID: Integer   read FID write FID;


property Nome: string read FNome write FNome;


property Ordini: Proxy<TList<TOrdine>> read FOrdini write FOrdini;
end;

[Entity]
[Automapping]

TOrdine = class
  private
  FID : integer;
  [Column('DataOrdine',[TColumnProp.Required])]
  FData : TDate;
  [Column('DataConsegna',[TColumnProp.Required])]
  FConsegna : TDate;

  [ManyValuedAssociation([TAssociationProp.Lazy,TAssociationProp.Required],CascadeTypeAllButRemove,'Id_cliente' )]
  FCliente : TCliente;


  public

  property ID: integer read FID write FID;
  property Data: TDate read FData write FData;
  property Consegna: TDate read FConsegna write FConsegna;
  property Cliente: TCliente read FCliente write FCliente;


end;

implementation



initialization

RegisterEntity(TCliente);
RegisterEntity(TOrdine)



end.
