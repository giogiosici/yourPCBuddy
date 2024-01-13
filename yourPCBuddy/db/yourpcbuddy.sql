DROP DATABASE IF EXISTS yourpcbuddy;
CREATE DATABASE yourpcbuddy;
USE yourpcbuddy;


-- Tabella product
DROP TABLE IF EXISTS product;

CREATE TABLE product (
  ID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  Nome VARCHAR(255),
  Descrizione TEXT,
  Prezzo DECIMAL(10,2),
  QuantitaDisponibile INT,
  CategoriaID INT NOT NULL,
  Immagine varchar(255),
  Marca VARCHAR(255)
);



-- Tabella Utenti
CREATE TABLE Utenti (
  ID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  Nome varchar(255),
  Cognome varchar(255),
  Username VARCHAR(255),
  Email VARCHAR(255),
  Password VARCHAR(255),
  Indirizzo varchar(255)
);

-- Tabella Carrello

CREATE TABLE Carrello(
ID INT AUTO_INCREMENT PRIMARY KEY ,
ProdottoID INT,
UtenteID INT,
QuantitaProdotto INT,
FOREIGN KEY (ProdottoID) REFERENCES product(ID),
FOREIGN KEY (UtenteID) REFERENCES Utenti(ID)
);

-- Tabella Ordini
CREATE TABLE Ordini (
  ID INT AUTO_INCREMENT PRIMARY KEY ,
  UtenteID INT,
  DataOra DATETIME,
  CarrelloJSON TEXT,
  FOREIGN KEY (UtenteID) REFERENCES Utenti(ID)
  
);

-- Tabella DettagliOrdine
CREATE TABLE DettagliOrdine (
  ID INT AUTO_INCREMENT PRIMARY KEY,
  OrdineID INT,
  ProdottoID INT,
  Quantita INT,
  FOREIGN KEY (OrdineID) REFERENCES Ordini(ID),
  FOREIGN KEY (ProdottoID) REFERENCES product(ID)
);


INSERT INTO Utenti (Username,Email,Password) values ("root","admin@gmail.com","admin");
INSERT INTO Utenti (Username,Email,Password) values ("pippo","pippofranco@gmail.com","franco");
INSERT INTO product (Nome,Descrizione,Prezzo,QuantitaDisponibile,CategoriaID, Immagine,Marca) values ("Intel i3-12300","Processore",200.00,10,1,"i3-12.png","Intel");
INSERT INTO product (Nome,Descrizione,Prezzo,QuantitaDisponibile,CategoriaID, Immagine,Marca) values ("Intel i7-13200","Processore",200.50,10,1,"i7-13.png","Intel");
INSERT INTO product (Nome,Descrizione,Prezzo,QuantitaDisponibile,CategoriaID, Immagine,Marca) values ("Ryzen 5 5600g","Processore",180.00,5,1,"r5-50.png","AMD");
INSERT INTO product (Nome,Descrizione,Prezzo,QuantitaDisponibile,CategoriaID, Immagine,Marca) values ("Intel i3-13100","Processore",180.00,10,1,"i3-13.png","Intel");
INSERT INTO product (Nome,Descrizione,Prezzo,QuantitaDisponibile,CategoriaID, Immagine,Marca) values ("Ryzen 7 5700g","Processore",210.00,5,1,"r7-50.png","AMD");
INSERT INTO product (Nome,Descrizione,Prezzo,QuantitaDisponibile,CategoriaID, Immagine,Marca) values ("Intel i5-13600","Processore",190.00,10,1,"i5-13.png","Intel");
INSERT INTO product (Nome,Descrizione,Prezzo,QuantitaDisponibile,CategoriaID, Immagine,Marca) values ("Ryzen 9 5900x","Processore",230.00,5,1,"r9-50.png","AMD");
INSERT INTO product (Nome,Descrizione,Prezzo,QuantitaDisponibile,CategoriaID, Immagine,Marca) values ("Intel i7-12700","Processore",200.00,10,1,"i7-12.png","Intel");
INSERT INTO product (Nome,Descrizione,Prezzo,QuantitaDisponibile,CategoriaID, Immagine,Marca) values ("Ryzen 3 4300g","Processore",150.00,5,1,"r3-40.png","AMD");
INSERT INTO product (Nome,Descrizione,Prezzo,QuantitaDisponibile,CategoriaID, Immagine,Marca) values ("Ryzen 5 4600g","Processore",180.00,5,1,"r5-40.png","AMD");
INSERT INTO product (Nome,Descrizione,Prezzo,QuantitaDisponibile,CategoriaID, Immagine,Marca) values ("Intel i5-12500 4700g","Processore",200.00,5,1,"i5-12.png","Intel");
