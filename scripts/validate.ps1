# Lokalna walidacja feedu GTFS za pomocą MobilityData gtfs-validator (Docker).
# Użycie: ./scripts/validate.ps1
# Wymaga: zainstalowanego Dockera.

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path $PSScriptRoot -Parent
$outDir = Join-Path $repoRoot "validation"
$workDir = Join-Path $repoRoot ".validation-work"
New-Item -ItemType Directory -Force -Path $outDir, $workDir | Out-Null
Remove-Item (Join-Path $outDir "*") -Recurse -Force -ErrorAction SilentlyContinue

# Spakuj feed do zipa (pliki .txt na root zipa)
$zipPath = Join-Path $workDir "gtfs.zip"
if (Test-Path $zipPath) { Remove-Item $zipPath }
Compress-Archive -Path (Join-Path $repoRoot "feed\*.txt") -DestinationPath $zipPath

Write-Host "Uruchamiam gtfs-validator (Docker)..." -ForegroundColor Cyan
docker run --rm `
  -v "$( $repoRoot -replace '\\', '/' ):/work" `
  ghcr.io/mobilitydata/gtfs-validator:latest `
  -i /work/.validation-work/gtfs.zip `
  -o /work/validation `
  -c pl `
  -t 4

if ($LASTEXITCODE -ne 0) {
  Write-Warning "Walidator zwrócił kod błędu: $LASTEXITCODE"
}

Remove-Item $workDir -Recurse -Force -ErrorAction SilentlyContinue

$report = Join-Path $outDir "report.json"
if (Test-Path $report) {
  $json = Get-Content $report -Raw | ConvertFrom-Json
  Write-Host ""
  Write-Host "Podsumowanie walidacji:" -ForegroundColor Yellow
  $notices = if ($json.notices) { @($json.notices) } else { @() }
  if ($notices.Count -eq 0) {
    Write-Host "Brak uwag — feed przeszedł walidację." -ForegroundColor Green
  }
  foreach ($n in $notices) {
    $color = if ($n.severity -eq "ERROR") { "Red" } else { "Yellow" }
    Write-Host (" - [{0}] {1}: {2}" -f $n.severity, $n.code, $n.totalNoticesCount) -ForegroundColor $color
  }
  Write-Host ""
  Write-Host "Pełny raport: $report oraz $outDir\report.html"
} else {
  Write-Warning "Nie znaleziono report.json — sprawdź powyższy log kontenera."
}