--Użytkownicy
create table Uzytkownicy(
    PESEL not null,
    imie not null,
    nazwisko not null,
    telefon not null,
    email not null,
    primary key(PESEL)
);

--Pacjenci
create table Pacjenci(
    PESEL references Uzytkownicy (PESEL) not null,
    primary key (PESEL)
);

--Pracownicy laboratorium
create table Laboranci(
    PESEL references Uzytkownicy (PESEL) not null,
    id_laboratorium references Laboratoria(ID) not null,
    primary key (PESEL)
);

--Specjaliści
create table Specjalisci(
    PESEL references Uzytkownicy (PESEL) not null,
    specjalizacja not null,
    id_poradni references Poradnie(ID),
    primary key (PESEL)
);

--Poradnie
create table Poradnie(
    ID not null,
    typ not null,
    nazwa not null,
    miasto not null,
    adres not null,
    telefon not null,
    primary key (ID)
);

CREATE SEQUENCE poradnia_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER poradnia_id_trg BEFORE
    INSERT ON Poradnie
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := poradnia_id_seq.nextval;
END;

--Jednostki czasu
create table Jednostki_czasu(
    data_i_godzina not null,
    wolna check (wolna in ('W','Z'))not null,
    id_wizyty references Wizyty(ID),
    pesel_pacjenta references Wizyty(pesel_pacjenta),
    pesel_specjalisty references Specjalisci(PESEL) not null,
    primary key(data_i_godzina, pesel_specjalisty)
);

--Wizyty
create table Wizyty(
    ID not null,
    pesel_pacjenta references Pacjenci(pesel) not null,
    primary key (ID, pesel_pacjenta)
);

CREATE SEQUENCE wizyta_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER wizyta_id_trg BEFORE
    INSERT ON Wizyty
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := wizyta_id_seq.nextval;
END;

--Konsultacje
create table Konsultacje(
    ID references Wizyty(ID) not null,
    pesel_pacjenta references Wizyty(pesel_pacjenta) not null,
    primary key(ID, pesel_pacjenta)
);

--Zabiegi
create table Zabiegi(
    nazwa not null,
    opis,
    primary key(nazwa)
);

create table Zabiegi_na_wizytach(
    ID references Wizyty(ID) not null,
    pesel_pacjenta references Wizyty(pesel_pacjenta) not null,
    nazwa_zabiegu references Zabiegi(nazwa) not null,
    primary key(ID, pesel_pacjenta, nazwa_zabiegu)
);

create table Wykonywane_zabiegi(
    pesel_specjalisty references Specjalisci(PESEL) not null,
    nazwa_zabiegu references Zabiegi(nazwa) not null,
    primary key(pesel_specjalisty, nazwa_zabiegu)
);

--Laboratoria
create table Laboratoria(
    ID not null,
    nazwa not null,
    miasto not null,
    adres not null,
    telefon not null,
    primary key (ID)
);

CREATE SEQUENCE laboratorium_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER laboratorium_id_trg BEFORE
    INSERT ON Laboratoria
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := laboratorium_id_seq.nextval;
END;

--Badania
create table Badania(
    nazwa not null,
    typ check(typ in ('krwi','moczu','kału','wymaz')) not null,
    opis,
    primary key(nazwa)
);

create table Wykonywane_badania(
    nazwa_badania references Badania(nazwa),
    id_laboratorium references Laboratoria(ID),
    primary key(nazwa_badania, id_laboratorium)
);

--Pobrania
create table Pobrania(
    ID not null,
    pesel_pacjenta references Pacjenci(PESEL),
    primary key(ID, pesel_pacjenta)
);

CREATE SEQUENCE pobranie_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER pobranie_id_trg BEFORE
    INSERT ON Pobrania
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := pobranie_id_seq.nextval;
END;

create table Badania_do_pobrania(
    id_pobrania references Pobrania(ID),
    pesel_pacjenta references Pacjenci(PESEL),
    nazwa_badania references Badania(nazwa),
    primary key(id_pobrania, pesel_pacjenta, nazwa_badania)
);