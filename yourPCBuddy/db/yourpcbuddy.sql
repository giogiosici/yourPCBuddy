DROP DATABASE IF EXISTS yourpcbuddy;
CREATE DATABASE yourpcbuddy;
USE yourpcbuddy;

-- Tabella Categorie
CREATE TABLE Categorie (
  ID INT PRIMARY KEY,
  Nome VARCHAR(255)
);

-- Tabella product
DROP TABLE IF EXISTS product;

CREATE TABLE product (
  ID INT PRIMARY KEY AUTO_INCREMENT,
  Nome VARCHAR(255),
  Descrizione TEXT,
  Prezzo DECIMAL(10.2),
  QuantitaDisponibile INT,
  CategoriaID INT,
  FOREIGN KEY (CategoriaID) REFERENCES Categorie(ID)
);


-- Tabella Utenti
CREATE TABLE Utenti (
  ID INT PRIMARY KEY,
  Nome VARCHAR(255),
  Email VARCHAR(255),
  Password VARCHAR(255)
);

-- Tabella Ordini
CREATE TABLE Ordini (
  ID INT PRIMARY KEY,
  UtenteID INT,
  DataOra DATETIME,
  FOREIGN KEY (UtenteID) REFERENCES Utenti(ID)
);

-- Tabella DettagliOrdine
CREATE TABLE DettagliOrdine (
  ID INT PRIMARY KEY,
  OrdineID INT,
  ProdottoID INT,
  Quantita INT,
  FOREIGN KEY (OrdineID) REFERENCES Ordini(ID),
  FOREIGN KEY (ProdottoID) REFERENCES product(ID)
);
INSERT INTO Categorie(ID,Nome) values (10,"CPU");

INSERT INTO product (ID,Nome,Descrizione,Prezzo,QuantitaDisponibile) values (1,"Intel i7-13200","Processore",200.00,10);
INSERT INTO product (ID,Nome,Descrizione,Prezzo,QuantitaDisponibile) values (2,"Ryzen 5 5600g","Processore",180.00,5);
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
