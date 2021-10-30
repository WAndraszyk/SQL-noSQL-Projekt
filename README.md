# Zarządzanie Bazami SQL i NoSQL Projekt – opis funkcjonalności
## Aplikacja obsługująca system rezerwacji wizyt w poradniach specjalistycznych i badań laboratoryjnych
### Autorzy: Witold Andraszyk, Stanisław Bilewski
Celem aplikacji jest obsługa systemu rezerwacji wizyt w poradniach specjalistycznych i badań laboratoryjnych poprzez stworzony interfejs graficzny. Aplikacja przewiduje dwa typy dostępu do bazy danych:
* Dostęp jako pacjent. W tym trybie aplikacja oferuje możliwość:
  * rejestracji pacjenta w bazie danych poprzez formularz do samodzielnego wypełnienia przez użytkownika.
  * zalogowania do systemu zarejestrowanego użytkownika.
  * przeglądania bazy dostępnych laboratoriów i poradni specjalistycznych oraz dostępnych specjalistów w każdej z nich.
  * przeglądania kalendarza wolnych terminów w formacie „termin wolny/zajęty”
    i umówienia się na wizytę u wybranego specjalisty lub wykonania badania w laboratorium.
  * przeglądania oferty zabiegów u danego specjalisty i umówienie się na zabieg.
  * przeglądu umówionych przez użytkownika wizyt/zabiegów/badań.
  * odwołania wizyty/zabiegu/badania. 
* Dostęp jako specjalista/pracownik laboratorium. W tym trybie aplikacja oferuje możliwość:
  * rejestracji specjalisty/laboranta w bazie danych i przypisania do poradni, w której przyjmuje poprzez formularz do samodzielnego wypełnienia przez użytkownika.
  * rejestracji poradni/laboratorium niewystępującej/ącego w bazie danych.
  * zalogowania do systemu zarejestrowanego użytkownika.
  * edycji oferowanych zabiegów/badań i ich cen.
  * przeglądania kalendarza umówionych wizyt z ich szczegółami (każdy specjalista ma dostęp wyłącznie do swojego kalendarza).
  * odwołania wizyty/zabiegu/badania.
