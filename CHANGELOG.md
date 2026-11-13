# Changelog danych GTFS

Wszystkie istotne zmiany **danych feedu** (przystanki, kursy, kalendarz, linie).
Zmiany skryptów i workflow notujemy tylko wtedy, gdy wpływają na konsumentów
(np. zmiana nazw assetów release'ów).

Format: sekcja `## <wersja>` na wydanie, wersjonowanie CalVer `YYYY.MM.DD`.

## v2026.11.13

- Aktualizacja rozkładu jazdy na okres 26.10.2026–11.12.2026
	(źródło: puzgm.pl/rozklad-jazdy).
- Nowe godziny odjazdów w obu kierunkach; bez zmian: 10 kursów w dni
	robocze, trasa linii A, przystanki i kształty przejazdu.
- Zaktualizowano `calendar.txt` (20261026–20261211) oraz `feed_info.txt`
	(nowy `feed_version` `2026-11-13-1`).

## v2026.09.23

- Dodano shapes.txt: kształty `chop-pkp` i `pkp-chop` dla linii A; kursy
	w trips.txt wskazują `shape_id`.
- Zmiana wydawcy metadanych: Daniel Mroczek (źródło danych: puzgm.pl),
	nowy feed_version `2026-09-23-1`, kontakt przez GitHub.
- Przeczyszczenie kolumn: usunięto puste `parent_station` (stops.txt) oraz
	`bikes_allowed` (trips.txt).
- Poprawka nazwy przystanku GRUD: ul. Grudnowa → ul. Grudniowa.

## v2026.09.21

- Pierwsze wydanie feedu: linia A (Dworzec PKP ↔ Plac Chopina), dni robocze.
- brak shapes.txt