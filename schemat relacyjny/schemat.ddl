--Użytkownicy
create table Uzytkownicy(
    PESEL int not null,
    imie varchar2(20) not null,
    nazwisko varchar2(20) not null,
    telefon varchar2(12) not null,
    email varchar2(50) not null,
    primary key(PESEL)
);

--Pacjenci
create table Pacjenci(
    PESEL int references Uzytkownicy (PESEL) not null,
    primary key (PESEL)
);

--Laboratoria
create table Laboratoria(
    ID int not null,
    nazwa varchar2(20) not null,
    miasto varchar2(20) not null,
    adres varchar2(50) not null,
    telefon varchar2(12) not null,
    primary key (ID)
);

-- CREATE SEQUENCE laboratorium_id_seq START WITH 1 NOCACHE ORDER;
--
-- CREATE OR REPLACE TRIGGER laboratorium_id_trg BEFORE
--     INSERT ON Laboratoria
--     FOR EACH ROW
--     WHEN ( new.id IS NULL )
-- BEGIN
--     :new.id := laboratorium_id_seq.nextval;
-- END;

--Pracownicy laboratorium
create table Laboranci(
    PESEL int references Uzytkownicy (PESEL) not null,
    id_laboratorium int references Laboratoria(ID) not null,
    primary key (PESEL)
);

--Poradnie
create table Poradnie(
    ID int not null,
    typ varchar2(20) not null,
    nazwa varchar2(20) not null,
    miasto varchar2(20) not null,
    adres varchar2(50) not null,
    telefon varchar2(12) not null,
    primary key (ID)
);

-- CREATE SEQUENCE poradnia_id_seq START WITH 1 NOCACHE ORDER;
--
-- CREATE OR REPLACE TRIGGER poradnia_id_trg BEFORE
--     INSERT ON Poradnie
--     FOR EACH ROW
--     WHEN ( new.id IS NULL )
-- BEGIN
--     :new.id := poradnia_id_seq.nextval;
-- END;

--Specjaliści
create table Specjalisci(
    PESEL int references Uzytkownicy (PESEL) not null,
    specjalizacja varchar2(20) not null,
    id_poradni int references Poradnie(ID),
    primary key (PESEL)
);

--Wizyty
create table Wizyty(
    ID int not null,
    pesel_pacjenta int references Pacjenci(pesel) not null,
    primary key (ID, pesel_pacjenta)
);

-- CREATE SEQUENCE wizyta_id_seq START WITH 1 NOCACHE ORDER;
--
-- CREATE OR REPLACE TRIGGER wizyta_id_trg BEFORE
--     INSERT ON Wizyty
--     FOR EACH ROW
--     WHEN ( new.id IS NULL )
-- BEGIN
--     :new.id := wizyta_id_seq.nextval;
-- END;

--Jednostki czasu
create table Jednostki_czasu(
    data_i_godzina timestamp not null,
    wolna char check (wolna in ('W','Z'))not null,
    id_wizyty int,
    pesel_pacjenta int,
    pesel_specjalisty int references Specjalisci(PESEL) not null,
    constraint jednostka_czasu_wizyta_fk foreign key ( id_wizyty, pesel_pacjenta )
        REFERENCES Wizyty ( ID, pesel_pacjenta ),
    primary key(data_i_godzina, pesel_specjalisty)
);

--Konsultacje
create table Konsultacje(
    ID int not null,
    pesel_pacjenta int not null,
    constraint konsultacja_wizyta_fk foreign key ( ID, pesel_pacjenta )
        REFERENCES Wizyty ( ID, pesel_pacjenta ),
    primary key(ID, pesel_pacjenta)
);

--Zabiegi
create table Zabiegi(
    nazwa varchar2(20) not null,
    opis varchar2(200),
    primary key(nazwa)
);

create table Zabiegi_na_wizytach(
    ID int not null,
    pesel_pacjenta int not null,
    nazwa_zabiegu varchar2(20) references Zabiegi(nazwa) not null,
    constraint zabieg_wizyta_fk foreign key ( ID, pesel_pacjenta )
        REFERENCES Wizyty ( ID, pesel_pacjenta ),
    primary key(ID, pesel_pacjenta, nazwa_zabiegu)
);

create table Wykonywane_zabiegi(
    pesel_specjalisty int references Specjalisci(PESEL) not null,
    nazwa_zabiegu varchar2(20) references Zabiegi(nazwa) not null,
    primary key(pesel_specjalisty, nazwa_zabiegu)
);

--Badania
create table Badania(
    nazwa varchar2(20) not null,
    typ varchar2(5) check(typ in ('krwi','moczu','kalu','wymaz')) not null,
    opis varchar2(200),
    primary key(nazwa)
);

create table Wykonywane_badania(
    nazwa_badania varchar2(20) references Badania(nazwa),
    id_laboratorium int references Laboratoria(ID),
    primary key(nazwa_badania, id_laboratorium)
);

--Pobrania
create table Pobrania(
    ID int not null,
    pesel_pacjenta int references Pacjenci(PESEL),
    primary key(ID, pesel_pacjenta)
);

-- CREATE SEQUENCE pobranie_id_seq START WITH 1 NOCACHE ORDER;
--
-- CREATE OR REPLACE TRIGGER pobranie_id_trg BEFORE
--     INSERT ON Pobrania
--     FOR EACH ROW
--     WHEN ( new.id IS NULL )
-- BEGIN
--     :new.id := pobranie_id_seq.nextval;
-- END;

create table Badania_do_pobrania(
    id_pobrania int,
    pesel_pacjenta int,
    nazwa_badania varchar2(20) references Badania(nazwa),
    constraint badania_pobrania_fk foreign key (id_pobrania, pesel_pacjenta)
        references Pobrania(ID, pesel_pacjenta) ,
    primary key(id_pobrania, pesel_pacjenta, nazwa_badania)
);