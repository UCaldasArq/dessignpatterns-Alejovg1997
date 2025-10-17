# Compila todas las fuentes Java y ejecuta los mains de los patrones (sin Maven)
# Uso: Abre PowerShell en la raíz del repo y ejecuta:
# Set-ExecutionPolicy Bypass -Scope Process -Force
# .\scripts\run_mains_no_maven.ps1

$projectRoot = (Resolve-Path ".\")
$srcDir = Join-Path $projectRoot 'src\main\java'
$targetClasses = Join-Path $projectRoot 'target\classes'

Write-Host "Proyecto:" $projectRoot
Write-Host "Fuentes:" $srcDir
Write-Host "Salida de clases:" $targetClasses

# Crear directorio de salida
if (-not (Test-Path $targetClasses)) { New-Item -ItemType Directory -Force -Path $targetClasses | Out-Null }

# Recolectar archivos fuente
$sourceFiles = Get-ChildItem -Path $srcDir -Recurse -Filter '*.java' | ForEach-Object { $_.FullName }
if ($sourceFiles.Count -eq 0) { Write-Error "No se encontraron archivos fuente Java en $srcDir"; exit 1 }

Write-Host "Compilando" ($sourceFiles.Count) "archivos..."
# Compilar
javac -d $targetClasses $sourceFiles
if ($LASTEXITCODE -ne 0) { Write-Error "javac falló. Asegúrate de tener JDK instalado y javac en PATH."; exit 1 }
Write-Host "Compilación finalizada."

# Ejecutar mains uno por uno
$mains = @(
    'edu.ucaldas.behavior.BehaviorMain',
    'edu.ucaldas.creational.CreationalMain'
)

foreach ($main in $mains) {
    Write-Host "`n--- Ejecutando: $main ---`n"
    java -cp $targetClasses $main
    if ($LASTEXITCODE -ne 0) { Write-Error "Ejecución de $main falló con código $LASTEXITCODE"; exit $LASTEXITCODE }
}

Write-Host "`nTodos los mains se ejecutaron correctamente." -ForegroundColor Green
