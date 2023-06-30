DROP DATABASE IF EXISTS yourpcbuddy;
CREATE DATABASE yourpcbuddy;
USE yourpcbuddy;

-- Tabella Categorie
--  ID INT PRIMARY KEY,
 -- Nome VARCHAR(255)
 -- );


-- Tabella product
DROP TABLE IF EXISTS product;

CREATE TABLE product (
  ID INT AUTO_INCREMENT PRIMARY KEY,
  Nome VARCHAR(255),
  Descrizione TEXT,
  Prezzo DECIMAL(10.2),
  QuantitaDisponibile INT,
  CategoriaID INT NOT NULL,
  Immagine varchar(255)
  -- FOREIGN KEY (CategoriaID) REFERENCES Categorie(ID)
);


-- Tabella Utenti
CREATE TABLE Utenti (
  ID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  Nome VARCHAR(255),
  Email VARCHAR(255),
  Password VARCHAR(255)
);

-- Tabella Ordini
CREATE TABLE Ordini (
  ID INT AUTO_INCREMENT PRIMARY KEY ,
  UtenteID INT,
  DataOra DATETIME,
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
CREATE TABLE Carrello(
ID INT AUTO_INCREMENT PRIMARY KEY ,
PrezzoTotale INT,
ProdottoID INT,
UtenteID INT,
OrdineID INT,
FOREIGN KEY (ProdottoID) REFERENCES product(ID),
FOREIGN KEY (OrdineID) REFERENCES Ordini(ID),
FOREIGN KEY (UtenteID) REFERENCES Utenti(ID)
);

INSERT INTO Utenti (Nome,Email,Password) values ("root","admin@gmail.com","admin");
INSERT INTO product (ID,Nome,Descrizione,Prezzo,QuantitaDisponibile,CategoriaID, Immagine) values (1,"Intel i7-13200","Processore",200.00,10,1,"C:\\\Users\\\giogi\\\git\\\yourPCBuddy\\\yourPCBuddy\\\src\\\main\\\WebContent\\\Images\\\i7-13.png");
INSERT INTO product (ID,Nome,Descrizione,Prezzo,QuantitaDisponibile,CategoriaID, Immagine) values (2,"Ryzen 5 5600g","Processore",180.00,5,1,"C:\\\Users\\\giogi\\\git\\\yourPCBuddy\\\yourPCBuddy\\\src\\\main\\\WebContent\\\Images\\\r5-50.png");
/*INSERT INTO product (ID,Nome,Descrizione,Prezzo,QuantitaDisponibile)  values ();
INSERT INTO product (ID,Nome,Descrizione,Prezzo,QuantitaDisponibile) values ();
INSERT INTO product (ID,Nome,Descrizione,Prezzo,QuantitaDisponibile)  values ();
INSERT INTO product (ID,Nome,Descrizione,Prezzo,QuantitaDisponibile)  values ();
INSERT INTO product (ID,Nome,Descrizione,Prezzo,QuantitaDisponibile)  values ();
INSERT INTO product (ID,Nome,Descrizione,Prezzo,QuantitaDisponibile)  values ();
INSERT INTO product (ID,Nome,Descrizione,Prezzo,QuantitaDisponibile)  values ();
INSERT INTO product (ID,Nome,Descrizione,Prezzo,QuantitaDisponibile)  values ();
INSERT INTO product (ID,Nome,Descrizione,Prezzo,QuantitaDisponibile)  values ();
INSERT INTO product (ID,Nome,Descrizione,Prezzo,QuantitaDisponibile)  values ();*/