SELECT o.ID AS ID_Ordine, Nome, o.Data, o.Scadenza, a.Qta AS qta_ordne, p.Descrizione, c.Qta, p1.Descrizione, p1.MachineFile FROM dbTestAurelius.Clienti
INNER JOIN Ordini o ON Clienti.ID = o.ID_Cliente
INNER JOIN Articoli a ON o.ID = a.ID_Ordine
INNER JOIN Prodotti p ON a.ID_Prodotto = p.ID
INNER JOIN Componenti c ON p.ID = c.ID_Prodotto
INNER JOIN Parti p1 ON c.ID_Parte = p1.ID

