# Proces wydania feedu GTFS

Wersjonowanie: **CalVer** `YYYY.MM.DD` — np. `2026.09.21`.
Dniu wydania odpowiada dokładnie jeden tag `vYYYY.MM.DD`; nowa wersja tego
samego dnia oznacza nadpisanie (usunięcie starego taga i release'u przed
wypchnięciem ponownie).

## Wydanie nowej wersji krok po kroku

### 1. Zmień dane w `feed/`

Wszystkie pliki `.txt` feedu leżą w katalogu `feed/`.

### 2. Zweryfikuj feed lokalnie (przed commit)

Wymaga [Dockera](https://docs.docker.com/get-started/):

```powershell
./scripts/validate.ps1
```

Skrypt pakuje `feed/*.txt` do zipa, uruchamia
[MobilityData gtfs-validator](https://github.com/MobilityData/gtfs-validator)
w kontenerze i wypisuje podsumowanie uwag. Pełny raport znajdziesz w
`validation/report.json` oraz `validation/report.html` (otwórz w przeglądarce).

⚠️ Katalogu `validation/` nie commitujemy.

### 3. Commit i push

### 3. Dodaj wpis do `CHANGELOG.md`

Každy release **wymaga** sekcji `## <wersja>` w [`CHANGELOG.md`](../CHANGELOG.md)
— opisu zmian danych (przystanki, kursy, kalendarz). Bez tej sekcji workflow
przerwie się z błędem. Treść sekcji staje się opisem release'u, a cały plik
jest dołączany do niego jako asset.

### 4. Commit i push

```bash
git add feed/ CHANGELOG.md
git commit -m "Aktualizacja rozkładu jazdy"
git push origin main
```

### 5. Otaguj wersję i wypchnij tag

```bash
git tag v2026.09.21
git push origin v2026.09.21
```

### 6. GitHub Actions buduje release

Workflow [`.github/workflows/release.yml`](../.github/workflows/release.yml)
uruchomi się automatycznie po pushu taga (albo ręcznie przez *Run workflow*
w zakładce **Actions** — wtedy wersja bierze się z bieżącej daty):

1. pakuje `feed/*.txt` do `gtfs-nt.zip` (pliki na root zipa, stała nazwa),
2. waliduje feed gtfs-validatorem,
3. wrzuca raport walidacji jako artefakt workflow i podsumowanie w *Job summary*,
4. wyciąga sekcję wersji z `CHANGELOG.md` (**blokuje release**, jeśli brak wpisu)
   i używa jej jako opisu release'u, dołączając changelog jako asset,
5. tworzy release z ZIP-em oraz `report.json` / `report.html` jako assetami
	(ZIP i raport JSON mają stałe nazwy — patrz niżej),
6. przy ręcznym uruchomieniu (*Run workflow*) zamiast release'u powstają
	artefakty: `gtfs-feed-zip` i `gtfs-validation-report`.

## Stałe linki (latest)

Każdy release zawiera assety pod stałymi nazwami, więc konsumenci mogą
subskrybować niezmienne URL-e, które zawsze wskazują najnowsze wydanie:

```
https://github.com/danielmroczek/gtfs-nt/releases/latest/download/gtfs-nt.zip
https://github.com/danielmroczek/gtfs-nt/releases/latest/download/report.json
```

To zgodne z zaleceniem specyfikacji GTFS: feed publikowany pod stałym,
permanentnym URL-em, a „jeden plik w stałej lokalizacji zawsze zawiera
aktualne rozkłady". Wersję rozpoznasz po tagu release'u i `CHANGELOG.md`.

Walidacja **nie blokuje** publikacji release'u — uwagi walidatora traktujemy
informacyjnie.

## Pobieranie feedu

Najnowszy ZIP zawsze znajdziesz na stronie
[Releases](https://github.com/danielmroczek/gtfs-nt/releases).
