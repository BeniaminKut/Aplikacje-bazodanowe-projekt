use ApBazProjekt;
drop trigger if exists UsunTrigger;
drop table if exists model;
drop table if exists logowania;
drop table if exists usuniete;
drop table if exists konto;
drop table if exists klient;
drop table if exists firma;
drop table if exists przeznaczenie;
drop table if exists rozmiar;
drop table if exists kategoria;
drop table if exists dane_personalne;
drop table if exists kontakt;
drop table if exists adres;
drop table if exists rodzaj_konta;
drop table if exists dane_do_faktury;
drop procedure if exists ile_produktow;


--Utworzenie tabel


CREATE TABLE firma (
  id_firma INTEGER IDENTITY(1,1) NOT NULL PRIMARY KEY,
  nazwa_firmy VARCHAR(50) NOT NULL,
);
GO

CREATE TABLE przeznaczenie (
  id_przeznaczenie INTEGER IDENTITY(1,1) NOT NULL PRIMARY KEY,
  przeznaczenie VARCHAR(50) NOT NULL,
);
GO

CREATE TABLE rozmiar (
  id_rozmiar INTEGER IDENTITY(1,1) NOT NULL PRIMARY KEY,
  rozmiar VARCHAR(50) NOT NULL,
);
GO

CREATE TABLE kategoria (
  id_kategoria INTEGER IDENTITY(1,1) NOT NULL PRIMARY KEY,
  nazwa_kategori VARCHAR(50) NOT NULL,
);
GO

CREATE TABLE model (
  id_model INTEGER IDENTITY(1,1) NOT NULL PRIMARY KEY,
  id_rozmiar INTEGER NOT NULL REFERENCES rozmiar(id_rozmiar),
  id_kategoria INTEGER NOT NULL REFERENCES kategoria(id_kategoria),
  id_przeznaczenie INTEGER NOT NULL REFERENCES przeznaczenie(id_przeznaczenie),
  id_firma INTEGER NOT NULL REFERENCES firma(id_firma),
  nazwa_modelu VARCHAR(50) NOT NULL,
  kod_produktu VARCHAR(4) NOT NULL CHECK(len(kod_produktu)=4),
  cena_producenta DECIMAL(8,2) NOT NULL,
  cena DECIMAL(8,2) NOT NULL,
  stan INTEGER NOT NULL
  );
GO


CREATE TABLE adres (
  id_adres INTEGER IDENTITY(1,1) NOT NULL PRIMARY KEY,
  ulica VARCHAR(50) NOT NULL,
  miejscowosc VARCHAR(30) NOT NULL
);
GO

CREATE TABLE rodzaj_konta (
  id_rodzaj_konta INTEGER IDENTITY(1,1) NOT NULL PRIMARY KEY,
  rodzaj_konta VARCHAR(20) NOT NULL
);
GO

CREATE TABLE dane_personalne (
  id_dane_personalne INTEGER IDENTITY(1,1) NOT NULL PRIMARY KEY,
  imie VARCHAR(50) NOT NULL,
  nazwisko VARCHAR(50) NOT NULL,
  data_urodzenia DATE NOT NULL,
  id_adres INTEGER NOT NULL REFERENCES adres(id_adres)
);
GO

CREATE TABLE konto (
  id_konto INTEGER IDENTITY(1,1) NOT NULL PRIMARY KEY,
  id_dane_personalne INTEGER NOT NULL UNIQUE REFERENCES dane_personalne(id_dane_personalne),
  id_rodzaj_konta INTEGER NOT NULL REFERENCES rodzaj_konta(id_rodzaj_konta),
  login_konta VARCHAR(50) NOT NULL,
  haslo VARCHAR(50) NOT NULL
);
GO

CREATE TABLE usuniete (
  id_konto INTEGER IDENTITY(1,1) NOT NULL PRIMARY KEY,
  id_dane_personalne INTEGER NOT NULL UNIQUE REFERENCES dane_personalne(id_dane_personalne),
  id_rodzaj_konta INTEGER NOT NULL REFERENCES rodzaj_konta(id_rodzaj_konta),
  login_konta VARCHAR(50) NOT NULL,
  haslo VARCHAR(50) NOT NULL
);
GO

CREATE TABLE logowania (
  id_logowania INTEGER IDENTITY(1,1) NOT NULL PRIMARY KEY,
  login_konta VARCHAR(50) NOT NULL,
  data_logowania DATETIME NOT NULL DEFAULT GETDATE()
);
GO


CREATE TABLE dane_do_faktury (
  id_dane_do_faktury INTEGER IDENTITY(1,1) NOT NULL PRIMARY KEY,
  nip CHAR(10) NOT NULL,
  nazwa_firmy VARCHAR(50) NOT NULL
);
GO

CREATE TABLE klient (
  id_klient INTEGER IDENTITY(1,1) NOT NULL PRIMARY KEY,
  id_dane_personalne INTEGER NOT NULL UNIQUE REFERENCES dane_personalne(id_dane_personalne),
  id_dane_do_faktury INTEGER NOT NULL REFERENCES dane_do_faktury(id_dane_do_faktury)
);
GO

INSERT INTO firma(nazwa_firmy)
 VALUES 
 ('Nike'),
 ('Reebok');

 INSERT INTO przeznaczenie(przeznaczenie)
 VALUES 
 ('Bieganie'),
 ('Lifestyle'),
 ('Koszykowka');

 INSERT INTO rozmiar(rozmiar)
 VALUES 
 ('XS'),
 ('S'),
 ('M'),
 ('L'),
 ('XL'),
 ('36'),
 ('37'),
 ('38'),
 ('39'),
 ('40'),
 ('41'),
 ('42'),
 ('43'),
 ('44'),
 ('45');

  INSERT INTO kategoria(nazwa_kategori)
 VALUES 
 ('Buty'),
 ('Koszulki');


 ----------------------------------------
  INSERT INTO model(id_rozmiar,id_kategoria,id_przeznaczenie,id_firma,nazwa_modelu,kod_produktu,cena_producenta,cena,stan) 
 VALUES 
 (6,1,1,1,'Epic React','0000',599.99,450.00,23),
 (7,1,1,1,'Epic React','0000',599.99,450.00,55),
 (8,1,1,1,'Epic React','0000',599.99,450.00,3),
 (9,1,1,1,'Epic React','0000',599.99,450.00,1),
 (10,1,1,1,'Epic React','0000',599.99,450.00,132),
 (11,1,1,1,'Epic React','0000',599.99,450.00,9),
 (12,1,1,1,'Epic React','0000',599.99,450.00,0),
 (13,1,1,1,'Epic React','0000',599.99,450.00,5),
 (14,1,1,1,'Epic React','0000',599.99,450.00,45),
 (15,1,1,1,'Epic React','0000',599.99,450.00,31),
 (6,1,1,1,'Free','0001',399.99,300.00,1),
 (7,1,1,1,'Free','0001',399.99,300.00,13),
 (8,1,1,1,'Free','0001',399.99,300.00,23),
 (9,1,1,1,'Free','0001',399.99,300.00,26),
 (10,1,1,1,'Free','0001',399.99,300.00,45),
 (11,1,1,1,'Free','0001',399.99,300.00,73),
 (12,1,1,1,'Free','0001',399.99,300.00,32),
 (13,1,1,1,'Free','0001',399.99,300.00,27),
 (14,1,1,1,'Free','0001',399.99,300.00,12),
 (15,1,1,1,'Free','0001',399.99,300.00,0),
 (6,1,1,1,'Revolution','0002',459.99,399.99,0),
 (7,1,1,1,'Revolution','0002',459.99,399.99,1),
 (8,1,1,1,'Revolution','0002',459.99,399.99,13),
 (9,1,1,1,'Revolution','0002',459.99,399.99,4),
 (10,1,1,1,'Revolution','0002',459.99,399.99,5),
 (11,1,1,1,'Revolution','0002',459.99,399.99,100),
 (12,1,1,1,'Revolution','0002',459.99,399.99,91),
 (13,1,1,1,'Revolution','0002',459.99,399.99,93),
 (14,1,1,1,'Revolution','0002',459.99,399.99,53),
 (15,1,1,1,'Revolution','0002',459.99,399.99,57),
 (6,1,1,1,'Vapor Fly','0003',699.99,549.99,87),
 (7,1,1,1,'Vapor Fly','0003',699.99,549.99,7),
 (8,1,1,1,'Vapor Fly','0003',699.99,549.99,8),
 (9,1,1,1,'Vapor Fly','0003',699.99,549.99,36),
 (10,1,1,1,'Vapor Fly','0003',699.99,549.99,75),
 (11,1,1,1,'Vapor Fly','0003',699.99,549.99,81),
 (12,1,1,1,'Vapor Fly','0003',699.99,549.99,64),
 (13,1,1,1,'Vapor Fly','0003',699.99,549.99,47),
 (14,1,1,1,'Vapor Fly','0003',699.99,549.99,10),
 (15,1,1,1,'Vapor Fly','0003',699.99,549.99,0),
 (6,1,1,1,'Zoom Fly','0004',299.99,249.99,50),
 (7,1,1,1,'Zoom Fly','0004',299.99,249.99,44),
 (8,1,1,1,'Zoom Fly','0004',299.99,249.99,60),
 (9,1,1,1,'Zoom Fly','0004',299.99,249.99,70),
 (10,1,1,1,'Zoom Fly','0004',299.99,249.99,80),
 (11,1,1,1,'Zoom Fly','0004',299.99,249.99,90),
 (12,1,1,1,'Zoom Fly','0004',299.99,249.99,0),
 (13,1,1,1,'Zoom Fly','0004',299.99,249.99,4),
 (14,1,1,1,'Zoom Fly','0004',299.99,249.99,68),
 (15,1,1,1,'Zoom Fly','0004',299.99,249.99,0),
 (6,1,3,1,'Air Precision','0005',599.99,449.99,0),
 (7,1,3,1,'Air Precision','0005',599.99,449.99,0),
 (8,1,3,1,'Air Precision','0005',599.99,449.99,0),
 (9,1,3,1,'Air Precision','0005',599.99,449.99,4),
 (10,1,3,1,'Air Precision','0005',599.99,449.99,12),
 (11,1,3,1,'Air Precision','0005',599.99,449.99,6),
 (12,1,3,1,'Air Precision','0005',599.99,449.99,8),
 (13,1,3,1,'Air Precision','0005',599.99,449.99,10),
 (14,1,3,1,'Air Precision','0005',599.99,449.99,23),
 (15,1,3,1,'Air Precision','0005',599.99,449.99,3),
 (6,1,3,1,'Hyperdunk X','0006',799.99,649.99,12),
 (7,1,3,1,'Hyperdunk X','0006',799.99,649.99,2),
 (8,1,3,1,'Hyperdunk X','0006',799.99,649.99,74),
 (9,1,3,1,'Hyperdunk X','0006',799.99,649.99,24),
 (10,1,3,1,'Hyperdunk X','0006',799.99,649.99,63),
 (11,1,3,1,'Hyperdunk X','0006',799.99,649.99,11),
 (12,1,3,1,'Hyperdunk X','0006',799.99,649.99,0),
 (13,1,3,1,'Hyperdunk X','0006',799.99,649.99,0),
 (14,1,3,1,'Hyperdunk X','0006',799.99,649.99,9),
 (15,1,3,1,'Hyperdunk X','0006',799.99,649.99,0),
 (6,1,3,1,'Jordan XXX','0007',899.99,799.99,0),
 (7,1,3,1,'Jordan XXX','0007',899.99,799.99,54),
 (8,1,3,1,'Jordan XXX','0007',899.99,799.99,78),
 (9,1,3,1,'Jordan XXX','0007',899.99,799.99,32),
 (10,1,3,1,'Jordan XXX','0007',899.99,799.99,12),
 (11,1,3,1,'Jordan XXX','0007',899.99,799.99,0),
 (12,1,3,1,'Jordan XXX','0007',899.99,799.99,0),
 (13,1,3,1,'Jordan XXX','0007',899.99,799.99,6),
 (14,1,3,1,'Jordan XXX','0007',899.99,799.99,4),
 (15,1,3,1,'Jordan XXX','0007',899.99,799.99,0),
 (6,1,3,1,'Kyrie 5','0008',499.99,399.99,5),
 (7,1,3,1,'Kyrie 5','0008',499.99,399.99,0),
 (8,1,3,1,'Kyrie 5','0008',499.99,399.99,0),
 (9,1,3,1,'Kyrie 5','0008',499.99,399.99,0),
 (10,1,3,1,'Kyrie 5','0008',499.99,399.99,11),
 (11,1,3,1,'Kyrie 5','0008',499.99,399.99,22),
 (12,1,3,1,'Kyrie 5','0008',499.99,399.99,51),
 (13,1,3,1,'Kyrie 5','0008',499.99,399.99,13),
 (14,1,3,1,'Kyrie 5','0008',499.99,399.99,12),
 (15,1,3,1,'Kyrie 5','0008',499.99,399.99,52),
 (6,1,3,1,'LeBron 16','0009',650.99,599.99,10),
 (7,1,3,1,'LeBron 16','0009',650.99,599.99,20),
 (8,1,3,1,'LeBron 16','0009',650.99,599.99,30),
 (9,1,3,1,'LeBron 16','0009',650.99,599.99,40),
 (10,1,3,1,'LeBron 16','0009',650.99,599.99,0),
 (11,1,3,1,'LeBron 16','0009',650.99,599.99,0),
 (12,1,3,1,'LeBron 16','0009',650.99,599.99,0),
 (13,1,3,1,'LeBron 16','0009',650.99,599.99,100),
 (14,1,3,1,'LeBron 16','0009',650.99,599.99,55),
 (15,1,3,1,'LeBron 16','0009',650.99,599.99,66),
 (6,1,3,1,'Mamba Focus','0010',550.99,499.99,60),
 (7,1,3,1,'Mamba Focus','0010',550.99,499.99,66),
 (8,1,3,1,'Mamba Focus','0010',550.99,499.99,32),
 (9,1,3,1,'Mamba Focus','0010',550.99,499.99,1),
 (10,1,3,1,'Mamba Focus','0010',550.99,499.99,0),
 (11,1,3,1,'Mamba Focus','0010',550.99,499.99,0),
 (12,1,3,1,'Mamba Focus','0010',550.99,499.99,0),
 (13,1,3,1,'Mamba Focus','0010',550.99,499.99,623),
 (14,1,3,1,'Mamba Focus','0010',550.99,499.99,999),
 (15,1,3,1,'Mamba Focus','0010',550.99,499.99,3),
 (6,1,2,1,'Air Force','0011',550.99,499.99,32),
 (7,1,2,1,'Air Force','0011',550.99,499.99,3),
 (8,1,2,1,'Air Force','0011',550.99,499.99,1),
 (9,1,2,1,'Air Force','0011',550.99,499.99,0),
 (10,1,2,1,'Air Force','0011',550.99,499.99,41),
 (11,1,2,1,'Air Force','0011',550.99,499.99,21),
 (12,1,2,1,'Air Force','0011',550.99,499.99,53),
 (13,1,2,1,'Air Force','0011',550.99,499.99,75),
 (14,1,2,1,'Air Force','0011',550.99,499.99,0),
 (15,1,2,1,'Air Force','0011',550.99,499.99,0),
 (6,1,2,1,'Air Jordan 3','0012',720.99,629.99,13),
 (7,1,2,1,'Air Jordan 3','0012',720.99,629.99,3),
 (8,1,2,1,'Air Jordan 3','0012',720.99,629.99,0),
 (9,1,2,1,'Air Jordan 3','0012',720.99,629.99,0),
 (10,1,2,1,'Air Jordan 3','0012',720.99,629.99,0),
 (11,1,2,1,'Air Jordan 3','0012',720.99,629.99,66),
 (12,1,2,1,'Air Jordan 3','0012',720.99,629.99,22),
 (13,1,2,1,'Air Jordan 3','0012',720.99,629.99,62),
 (14,1,2,1,'Air Jordan 3','0012',720.99,629.99,132),
 (15,1,2,1,'Air Jordan 3','0012',720.99,629.99,0),
 (6,1,2,1,'Air Jordan 4','0013',820.99,719.99,5),
 (7,1,2,1,'Air Jordan 4','0013',820.99,719.99,53),
 (8,1,2,1,'Air Jordan 4','0013',820.99,719.99,89),
 (9,1,2,1,'Air Jordan 4','0013',820.99,719.99,14),
 (10,1,2,1,'Air Jordan 4','0013',820.99,719.99,80),
 (11,1,2,1,'Air Jordan 4','0013',820.99,719.99,46),
 (12,1,2,1,'Air Jordan 4','0013',820.99,719.99,13),
 (13,1,2,1,'Air Jordan 4','0013',820.99,719.99,763),
 (14,1,2,1,'Air Jordan 4','0013',820.99,719.99,0),
 (15,1,2,1,'Air Jordan 4','0013',820.99,719.99,7),
 (6,1,2,1,'Air Jordan DNA','0014',520.99,379.99,50),
 (7,1,2,1,'Air Jordan DNA','0014',520.99,379.99,50),
 (8,1,2,1,'Air Jordan DNA','0014',520.99,379.99,50),
 (9,1,2,1,'Air Jordan DNA','0014',520.99,379.99,50),
 (10,1,2,1,'Air Jordan DNA','0014',520.99,379.99,50),
 (11,1,2,1,'Air Jordan DNA','0014',520.99,379.99,50),
 (12,1,2,1,'Air Jordan DNA','0014',520.99,379.99,50),
 (13,1,2,1,'Air Jordan DNA','0014',520.99,379.99,50),
 (14,1,2,1,'Air Jordan DNA','0014',520.99,379.99,50),
 (15,1,2,1,'Air Jordan DNA','0014',520.99,379.99,50),
 (6,1,2,1,'Air Max 90','0015',650.99,599.99,0),
 (7,1,2,1,'Air Max 90','0015',650.99,599.99,0),
 (8,1,2,1,'Air Max 90','0015',650.99,599.99,0),
 (9,1,2,1,'Air Max 90','0015',650.99,599.99,40),
 (10,1,2,1,'Air Max 90','0015',650.99,599.99,45),
 (11,1,2,1,'Air Max 90','0015',650.99,599.99,24),
 (12,1,2,1,'Air Max 90','0015',650.99,599.99,74),
 (13,1,2,1,'Air Max 90','0015',650.99,599.99,0),
 (14,1,2,1,'Air Max 90','0015',650.99,599.99,98),
 (15,1,2,1,'Air Max 90','0015',650.99,599.99,356),
 (6,1,2,1,'Air Max 270','0016',850.99,659.99,0),
 (7,1,2,1,'Air Max 270','0016',850.99,659.99,0),
 (8,1,2,1,'Air Max 270','0016',850.99,659.99,0),
 (9,1,2,1,'Air Max 270','0016',850.99,659.99,5),
 (10,1,2,1,'Air Max 270','0016',850.99,659.99,13),
 (11,1,2,1,'Air Max 270','0016',850.99,659.99,52),
 (12,1,2,1,'Air Max 270','0016',850.99,659.99,0),
 (13,1,2,1,'Air Max 270','0016',850.99,659.99,23),
 (14,1,2,1,'Air Max 270','0016',850.99,659.99,0),
 (15,1,2,1,'Air Max 270','0016',850.99,659.99,0),
 (6,1,2,1,'Air Vapor Max','0017',999.99,899.99,333),
 (7,1,2,1,'Air Vapor Max','0017',999.99,899.99,222),
 (8,1,2,1,'Air Vapor Max','0017',999.99,899.99,111),
 (9,1,2,1,'Air Vapor Max','0017',999.99,899.99,0),
 (10,1,2,1,'Air Vapor Max','0017',999.99,899.99,0),
 (11,1,2,1,'Air Vapor Max','0017',999.99,899.99,65),
 (12,1,2,1,'Air Vapor Max','0017',999.99,899.99,23),
 (13,1,2,1,'Air Vapor Max','0017',999.99,899.99,99),
 (14,1,2,1,'Air Vapor Max','0017',999.99,899.99,0),
 (15,1,2,1,'Air Vapor Max','0017',999.99,899.99,4),
 (6,1,2,1,'React Element','0018',500.00,359.99,0),
 (7,1,2,1,'React Element','0018',500.00,359.99,0),
 (8,1,2,1,'React Element','0018',500.00,359.99,1),
 (9,1,2,1,'React Element','0018',500.00,359.99,32),
 (10,1,2,1,'React Element','0018',500.00,359.99,11),
 (11,1,2,1,'React Element','0018',500.00,359.99,0),
 (12,1,2,1,'React Element','0018',500.00,359.99,0),
 (13,1,2,1,'React Element','0018',500.00,359.99,0),
 (14,1,2,1,'React Element','0018',500.00,359.99,87),
 (15,1,2,1,'React Element','0018',500.00,359.99,0),--wszystkie buty nike
 (1,2,1,1,'Cool','0019',129.00,99.99,50),
 (2,2,1,1,'Cool','0019',129.00,99.99,3),
 (3,2,1,1,'Cool','0019',129.00,99.99,0),
 (4,2,1,1,'Cool','0019',129.00,99.99,80),
 (5,2,1,1,'Cool','0019',129.00,99.99,64),
 (1,2,1,1,'Miler','0020',159.00,129.99,6),
 (2,2,1,1,'Miler','0020',159.00,129.99,456),
 (3,2,1,1,'Miler','0020',159.00,129.99,0),
 (4,2,1,1,'Miler','0020',159.00,129.99,0),
 (5,2,1,1,'Miler','0020',159.00,129.99,66),
 (1,2,1,1,'Vaporknit','0021',219.00,179.99,0),
 (2,2,1,1,'Vaporknit','0021',219.00,179.99,20),
 (3,2,1,1,'Vaporknit','0021',219.00,179.99,30),
 (4,2,1,1,'Vaporknit','0021',219.00,179.99,40),
 (5,2,1,1,'Vaporknit','0021',219.00,179.99,0),
 (1,2,3,1,'Bucks','0022',319.00,279.99,54),
 (2,2,3,1,'Bucks','0022',319.00,279.99,12),
 (3,2,3,1,'Bucks','0022',319.00,279.99,3),
 (4,2,3,1,'Bucks','0022',319.00,279.99,0),
 (5,2,3,1,'Bucks','0022',319.00,279.99,7),
 (1,2,3,1,'Bulls','0023',419.00,359.99,12),
 (2,2,3,1,'Bulls','0023',419.00,359.99,17),
 (3,2,3,1,'Bulls','0023',419.00,359.99,94),
 (4,2,3,1,'Bulls','0023',419.00,359.99,23),
 (5,2,3,1,'Bulls','0023',419.00,359.99,0),
 (1,2,3,1,'Celtics','0024',369.00,329.99,0),
 (2,2,3,1,'Celtics','0024',369.00,329.99,0),
 (3,2,3,1,'Celtics','0024',369.00,329.99,6),
 (4,2,3,1,'Celtics','0024',369.00,329.99,2),
 (5,2,3,1,'Celtics','0024',369.00,329.99,0),
 (1,2,3,1,'Dallas','0025',339.00,299.99,0),
 (2,2,3,1,'Dallas','0025',339.00,299.99,20),
 (3,2,3,1,'Dallas','0025',339.00,299.99,30),
 (4,2,3,1,'Dallas','0025',339.00,299.99,0),
 (5,2,3,1,'Dallas','0025',339.00,299.99,70),
 (1,2,3,1,'Lakers','0026',500.00,449.99,0),
 (2,2,3,1,'Lakers','0026',500.00,449.99,412),
 (3,2,3,1,'Lakers','0026',500.00,449.99,3),
 (4,2,3,1,'Lakers','0026',500.00,449.99,0),
 (5,2,3,1,'Lakers','0026',500.00,449.99,6),
 (1,2,3,1,'Miami','0027',340.00,289.99,10),
 (2,2,3,1,'Miami','0027',340.00,289.99,0),
 (3,2,3,1,'Miami','0027',340.00,289.99,30),
 (4,2,3,1,'Miami','0027',340.00,289.99,70),
 (5,2,3,1,'Miami','0027',340.00,289.99,80),
 (1,2,3,1,'OKC','0028',280.00,269.99,10),
 (2,2,3,1,'OKC','0028',280.00,269.99,51),
 (3,2,3,1,'OKC','0028',280.00,269.99,32),
 (4,2,3,1,'OKC','0028',280.00,269.99,0),
 (5,2,3,1,'OKC','0028',280.00,269.99,0),
 (1,2,2,1,'Athlete','0029',180.00,159.99,30),
 (2,2,2,1,'Athlete','0029',180.00,159.99,20),
 (3,2,2,1,'Athlete','0029',180.00,159.99,0),
 (4,2,2,1,'Athlete','0029',180.00,159.99,0),
 (5,2,2,1,'Athlete','0029',180.00,159.99,10),
 (1,2,2,1,'Just do it','0030',140.00,100.00,0),
 (2,2,2,1,'Just do it','0030',140.00,100.00,0),
 (3,2,2,1,'Just do it','0030',140.00,100.00,32),
 (4,2,2,1,'Just do it','0030',140.00,100.00,0),
 (5,2,2,1,'Just do it','0030',140.00,100.00,99),
 (1,2,2,1,'Sport 72','0031',120.00,79.00,0),
 (2,2,2,1,'Sport 72','0031',120.00,79.00,2),
 (3,2,2,1,'Sport 72','0031',120.00,79.00,0),
 (4,2,2,1,'Sport 72','0031',120.00,79.00,76),
 (5,2,2,1,'Sport 72','0031',120.00,79.00,0),
 (1,2,2,1,'ZigZag','0032',130.00,89.00,13),
 (2,2,2,1,'ZigZag','0032',130.00,89.00,54),
 (3,2,2,1,'ZigZag','0032',130.00,89.00,0),
 (4,2,2,1,'ZigZag','0032',130.00,89.00,0),
 (5,2,2,1,'ZigZag','0032',130.00,89.00,68),--koniec nike
 (6,1,1,2,'Fast Tempo','0033',230.00,169.00,0),
 (7,1,1,2,'Fast Tempo','0033',230.00,169.00,0),
 (8,1,1,2,'Fast Tempo','0033',230.00,169.00,0),
 (9,1,1,2,'Fast Tempo','0033',230.00,169.00,40),
 (10,1,1,2,'Fast Tempo','0033',230.00,169.00,230),
 (11,1,1,2,'Fast Tempo','0033',230.00,169.00,50),
 (12,1,1,2,'Fast Tempo','0033',230.00,169.00,0),
 (13,1,1,2,'Fast Tempo','0033',230.00,169.00,70),
 (14,1,1,2,'Fast Tempo','0033',230.00,169.00,80),
 (15,1,1,2,'Fast Tempo','0033',230.00,169.00,90),
 (6,1,1,2,'Forever Energy','0034',290.00,269.00,10),
 (7,1,1,2,'Forever Energy','0034',290.00,269.00,514),
 (8,1,1,2,'Forever Energy','0034',290.00,269.00,23),
 (9,1,1,2,'Forever Energy','0034',290.00,269.00,0),
 (10,1,1,2,'Forever Energy','0034',290.00,269.00,0),
 (11,1,1,2,'Forever Energy','0034',290.00,269.00,0),
 (12,1,1,2,'Forever Energy','0034',290.00,269.00,130),
 (13,1,1,2,'Forever Energy','0034',290.00,269.00,0),
 (14,1,1,2,'Forever Energy','0034',290.00,269.00,2),
 (15,1,1,2,'Forever Energy','0034',290.00,269.00,0),
 (6,1,1,2,'Harmony Road','0035',490.00,299.00,40),
 (7,1,1,2,'Harmony Road','0035',490.00,299.00,63),
 (8,1,1,2,'Harmony Road','0035',490.00,299.00,87),
 (9,1,1,2,'Harmony Road','0035',490.00,299.00,0),
 (10,1,1,2,'Harmony Road','0035',490.00,299.00,0),
 (11,1,1,2,'Harmony Road','0035',490.00,299.00,0),
 (12,1,1,2,'Harmony Road','0035',490.00,299.00,24),
 (13,1,1,2,'Harmony Road','0035',490.00,299.00,0),
 (14,1,1,2,'Harmony Road','0035',490.00,299.00,0),
 (15,1,1,2,'Harmony Road','0035',490.00,299.00,1),
 (6,1,3,2,'Blast','0036',590.00,499.00,0),
 (7,1,3,2,'Blast','0036',590.00,499.00,0),
 (8,1,3,2,'Blast','0036',590.00,499.00,10),
 (9,1,3,2,'Blast','0036',590.00,499.00,30),
 (10,1,3,2,'Blast','0036',590.00,499.00,0),
 (11,1,3,2,'Blast','0036',590.00,499.00,3),
 (12,1,3,2,'Blast','0036',590.00,499.00,0),
 (13,1,3,2,'Blast','0036',590.00,499.00,1),
 (14,1,3,2,'Blast','0036',590.00,499.00,2),
 (15,1,3,2,'Blast','0036',590.00,499.00,30),
 (6,1,3,2,'Classic','0037',390.00,299.00,10),
 (7,1,3,2,'Classic','0037',390.00,299.00,0),
 (8,1,3,2,'Classic','0037',390.00,299.00,412),
 (9,1,3,2,'Classic','0037',390.00,299.00,0),
 (10,1,3,2,'Classic','0037',390.00,299.00,4),
 (11,1,3,2,'Classic','0037',390.00,299.00,0),
 (12,1,3,2,'Classic','0037',390.00,299.00,23),
 (13,1,3,2,'Classic','0037',390.00,299.00,1),
 (14,1,3,2,'Classic','0037',390.00,299.00,3),
 (15,1,3,2,'Classic','0037',390.00,299.00,0),
 (6,1,2,2,'At Super','0038',490.00,299.00,0),
 (7,1,2,2,'At Super','0038',490.00,299.00,0),
 (8,1,2,2,'At Super','0038',490.00,299.00,1),
 (9,1,2,2,'At Super','0038',490.00,299.00,42),
 (10,1,2,2,'At Super','0038',490.00,299.00,0),
 (11,1,2,2,'At Super','0038',490.00,299.00,23),
 (12,1,2,2,'At Super','0038',490.00,299.00,0),
 (13,1,2,2,'At Super','0038',490.00,299.00,0),
 (14,1,2,2,'At Super','0038',490.00,299.00,14),
 (15,1,2,2,'At Super','0038',490.00,299.00,88),
 (6,1,2,2,'Classic','0039',390.00,279.00,3),
 (7,1,2,2,'Classic','0039',390.00,279.00,7),
 (8,1,2,2,'Classic','0039',390.00,279.00,5),
 (9,1,2,2,'Classic','0039',390.00,279.00,1),
 (10,1,2,2,'Classic','0039',390.00,279.00,2),
 (11,1,2,2,'Classic','0039',390.00,279.00,3),
 (12,1,2,2,'Classic','0039',390.00,279.00,35),
 (13,1,2,2,'Classic','0039',390.00,279.00,0),
 (14,1,2,2,'Classic','0039',390.00,279.00,0),
 (15,1,2,2,'Classic','0039',390.00,279.00,65),
 (6,1,2,2,'Jogger','0040',190.00,179.00,0),
 (7,1,2,2,'Jogger','0040',190.00,179.00,0),
 (8,1,2,2,'Jogger','0040',190.00,179.00,41),
 (9,1,2,2,'Jogger','0040',190.00,179.00,23),
 (10,1,2,2,'Jogger','0040',190.00,179.00,3),
 (11,1,2,2,'Jogger','0040',190.00,179.00,5),
 (12,1,2,2,'Jogger','0040',190.00,179.00,13),
 (13,1,2,2,'Jogger','0040',190.00,179.00,77),
 (14,1,2,2,'Jogger','0040',190.00,179.00,123),
 (15,1,2,2,'Jogger','0040',190.00,179.00,32),
 (6,1,2,2,'Royal','0041',500.00,379.00,0),
 (7,1,2,2,'Royal','0041',500.00,379.00,1),
 (8,1,2,2,'Royal','0041',500.00,379.00,0),
 (9,1,2,2,'Royal','0041',500.00,379.00,0),
 (10,1,2,2,'Royal','0041',500.00,379.00,2),
 (11,1,2,2,'Royal','0041',500.00,379.00,0),
 (12,1,2,2,'Royal','0041',500.00,379.00,0),
 (13,1,2,2,'Royal','0041',500.00,379.00,234),
 (14,1,2,2,'Royal','0041',500.00,379.00,34),
 (15,1,2,2,'Royal','0041',500.00,379.00,66),
 (6,1,2,2,'Skye Peak','0042',400.00,319.00,10),
 (7,1,2,2,'Skye Peak','0042',400.00,319.00,20),
 (8,1,2,2,'Skye Peak','0042',400.00,319.00,30),
 (9,1,2,2,'Skye Peak','0042',400.00,319.00,0),
 (10,1,2,2,'Skye Peak','0042',400.00,319.00,0),
 (11,1,2,2,'Skye Peak','0042',400.00,319.00,41),
 (12,1,2,2,'Skye Peak','0042',400.00,319.00,0),
 (13,1,2,2,'Skye Peak','0042',400.00,319.00,1),
 (14,1,2,2,'Skye Peak','0042',400.00,319.00,0),
 (15,1,2,2,'Skye Peak','0042',400.00,319.00,0),
 (1,2,1,2,'Bolton','0043',200.00,169.00,133),
 (2,2,1,2,'Bolton','0043',200.00,169.00,32),
 (3,2,1,2,'Bolton','0043',200.00,169.00,5),
 (4,2,1,2,'Bolton','0043',200.00,169.00,1),
 (5,2,1,2,'Bolton','0043',200.00,169.00,54),
 (1,2,1,2,'Classic','0044',100.00,50.00,32),
 (2,2,1,2,'Classic','0044',100.00,50.00,12),
 (3,2,1,2,'Classic','0044',100.00,50.00,0),
 (4,2,1,2,'Classic','0044',100.00,50.00,64),
 (5,2,1,2,'Classic','0044',100.00,50.00,3),
 (1,2,1,2,'Less Mills','0045',150.00,140.00,45),
 (2,2,1,2,'Less Mills','0045',150.00,140.00,23),
 (3,2,1,2,'Less Mills','0045',150.00,140.00,54),
 (4,2,1,2,'Less Mills','0045',150.00,140.00,12),
 (5,2,1,2,'Less Mills','0045',150.00,140.00,66),
 (1,2,1,2,'Run','0046',130.00,120.00,10),
 (2,2,1,2,'Run','0046',130.00,120.00,20),
 (3,2,1,2,'Run','0046',130.00,120.00,30),
 (4,2,1,2,'Run','0046',130.00,120.00,0),
 (5,2,1,2,'Run','0046',130.00,120.00,40),
 (1,2,3,2,'Ball Kick','0047',170.00,150.00,30),
 (2,2,3,2,'Ball Kick','0047',170.00,150.00,20),
 (3,2,3,2,'Ball Kick','0047',170.00,150.00,10),
 (4,2,3,2,'Ball Kick','0047',170.00,150.00,0),
 (5,2,3,2,'Ball Kick','0047',170.00,150.00,20),
 (1,2,2,2,'Premium','0048',220.00,190.00,46),
 (2,2,2,2,'Premium','0048',220.00,190.00,100),
 (3,2,2,2,'Premium','0048',220.00,190.00,666),
 (4,2,2,2,'Premium','0048',220.00,190.00,48),
 (5,2,2,2,'Premium','0048',220.00,190.00,22),
 (1,2,2,2,'UFC','0049',250.00,200.00,50),
 (2,2,2,2,'UFC','0049',250.00,200.00,20),
 (3,2,2,2,'UFC','0049',250.00,200.00,42),
 (4,2,2,2,'UFC','0049',250.00,200.00,12),
 (5,2,2,2,'UFC','0049',250.00,200.00,54),
 (1,2,2,2,'Ultimate','0050',200.00,199.99,10),
 (2,2,2,2,'Ultimate','0050',200.00,199.99,20),
 (3,2,2,2,'Ultimate','0050',200.00,199.99,0),
 (4,2,2,2,'Ultimate','0050',200.00,199.99,0),
 (5,2,2,2,'Ultimate','0050',200.00,199.99,6);
-----------------------------------------

-----------------------------------------
  INSERT INTO adres(ulica,miejscowosc)
 VALUES 
 ('Spokojna','Pruszcz Gdanski'),
 ('Cicha','Gdynia'),
 ('Dluga','Gdansk'),
 ('Glosna','Gdynia');

  INSERT INTO rodzaj_konta(rodzaj_konta)
 VALUES 
 ('Administrator'),
 ('Uzytkownik');

 --DANE PERSONALNE
   INSERT INTO dane_personalne(imie,nazwisko,data_urodzenia,id_adres)
 VALUES 
('Jan','Kowalski','01.01.1980',1),
('Magda','Kowalska','05.09.1982',1),
('Adam','Nowak','10.05.1982',2),
('Jerzy','Robak','02.03.1960',3),
('Anna','Poranna','07.07.1990',4);

 --KONTO
   INSERT INTO konto(id_dane_personalne,id_rodzaj_konta,login_konta,haslo)
 VALUES 
 (1,1,'jan_kowalski','jan_kowalski'),
 (2,2,'magda_kowalska','magda_kowalska'),
 (3,2,'user','user'),
 (4,1,'admin','admin');


  --DANE DO FAKTURY
   INSERT INTO dane_do_faktury(nip,nazwa_firmy)
 VALUES 
 ('1234567890','Sklep koszykarza'),
 ('1112223330','Sklep biegacza'),
 ('0001112223','Sklep nike');

 INSERT INTO klient(id_dane_personalne,id_dane_do_faktury)
 VALUES
 (2,1),
 (4,2),
 (5,3);

 GO
 CREATE PROCEDURE ile_produktow 
 @kategoria int, @firma int
 AS
 BEGIN
 select count(stan) from model where id_kategoria=@kategoria and id_firma=@firma
 END
 GO
 GO
CREATE TRIGGER UsunTrigger
ON konto
AFTER DELETE
AS
BEGIN
       INSERT INTO usuniete(id_dane_personalne,id_rodzaj_konta,login_konta,haslo)
       SELECT 
           id_dane_personalne,
           id_rodzaj_konta,
           login_konta,
           haslo          
       FROM 
           DELETED
		   SELECT * FROM USUNIETE
END
GO


 --SPRAWDZENIA
 --DODAWANIE UZYTKOWNIKA
-- select * from konto k left join dane_personalne p on p.id_dane_personalne=k.id_dane_personalne;
--USUWANIE UZYTKOWNIKA
--select * from konto;
--EDYCJA UZYTKOWNIKA
--select k.login_konta, k.haslo, a.miejscowosc, a.ulica from konto k left join dane_personalne p on k.id_dane_personalne=p.id_dane_personalne left join adres a on a.id_adres=p.id_adres

--REJESTR LOGOWAN
--select data_logowania, login_konta from logowania order by data_logowania desc
--WYZWALACZ
-- delete from konto where id_konto=1
--select * from usuniete
--select * from konto
