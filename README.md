# 🚌 GTFS — Komunikacja Miejska Nowy Tomyśl

Otwarty zbiór danych [GTFS](https://gtfs.org/schedule/) dla komunikacji miejskiej
w Nowym Tomyślu, obsługiwanej przez
**PU Zakład Gospodarki Mieszkaniowej w Nowym Tomyślu Sp. z o.o.**

> [!NOTE]
> Zbiór obejmuje linię **A** (linia okołomiejska Dworzec PKP ↔ Plac Chopina),
> kursującą w dni robocze.

Dane udostępniono na licencji [MIT](./LICENSE).

## Pobieranie

Najnowszą paczkę feedu (ZIP zgodny ze standardem GTFS) pobierzesz ze strony
[Releases](https://github.com/danielmroczek/gtfs-nt/releases).
Wersjonowanie: CalVer `YYYY.MM.DD`. Każdy release zawiera także raport
walidacji ([MobilityData gtfs-validator](https://github.com/MobilityData/gtfs-validator)).

Stały link do najnowszej wersji feedu (do subskrybowania w aplikacjach):

```
https://github.com/danielmroczek/gtfs-nt/releases/latest/download/gtfs-nt-latest.zip
```

Jak wydać nową wersję: [`docs/release.md`](./docs/release.md).

## Struktura repozytorium

- `feed/` — pliki `.txt` feedu GTFS,
- `CHANGELOG.md` — historia zmian danych feedu (wymagany wpis na release),
- `scripts/validate.ps1` — lokalna walidacja feedu (Docker),
- `docs/release.md` — proces wydania.

## Źródło danych

Zbiór oparty jest na rozkładzie jazdy opublikowanym na stronie
[www.puzgm.pl/rozklad-jazdy](https://www.puzgm.pl/rozklad-jazdy/) —
oficjalnej stronie operatora.

## Zgłoszenia

Zauważyłeś błąd w rozkładzie albo chcesz wykorzystać te dane w swojej aplikacji?
[Otwórz issue](https://github.com/danielmroczek/gtfs-nt/issues).