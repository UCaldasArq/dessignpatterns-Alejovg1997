<#
Runs unit tests without Maven by downloading junit-platform-console-standalone,
compiling project sources and tests, and invoking the JUnit console launcher.

Usage (PowerShell):
  Set-ExecutionPolicy Bypass -Scope Process -Force
  .\scripts\run_tests_no_maven.ps1
#>

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Resolve-Path "$root\.."
$libDir = "$projectRoot\lib"
$targetClasses = "$projectRoot\target\classes"
$targetTestClasses = "$projectRoot\target\test-classes"

New-Item -ItemType Directory -Force -Path $libDir | Out-Null
New-Item -ItemType Directory -Force -Path $targetClasses | Out-Null
New-Item -ItemType Directory -Force -Path $targetTestClasses | Out-Null

$junitUrl = 'https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/1.9.4/junit-platform-console-standalone-1.9.4.jar'
$junitJar = "$libDir\junit-platform-console-standalone.jar"

if (-not (Test-Path $junitJar)) {
    Write-Host "Descargando JUnit Console Launcher..."
    Invoke-WebRequest -Uri $junitUrl -OutFile $junitJar
}

Write-Host "Compilando fuentes..."
$sourceFiles = Get-ChildItem -Path "$projectRoot\src\main\java" -Recurse -Filter '*.java' | ForEach-Object { $_.FullName }
if ($sourceFiles.Count -eq 0) { Write-Error "No se encontraron fuentes Java."; exit 1 }
javac -d $targetClasses $sourceFiles
if ($LASTEXITCODE -ne 0) { Write-Error "javac falló al compilar las fuentes."; exit 1 }

Write-Host "Compilando tests..."
$testFiles = Get-ChildItem -Path "$projectRoot\src\test\java" -Recurse -Filter '*.java' | ForEach-Object { $_.FullName }
if ($testFiles.Count -eq 0) { Write-Error "No se encontraron tests Java."; exit 1 }
# Include target classes and junit jar in classpath for compiling tests
$cp = "$targetClasses;$junitJar"
javac -cp $cp -d $targetTestClasses $testFiles
if ($LASTEXITCODE -ne 0) { Write-Error "javac falló al compilar los tests."; exit 1 }

Write-Host "Ejecutando tests con JUnit Console Launcher..."
$launchCp = "$targetClasses;$targetTestClasses;$junitJar"
java -jar $junitJar -cp "$launchCp" --scan-class-path $targetTestClasses

if ($LASTEXITCODE -ne 0) { Write-Error "Al menos un test ha fallado."; exit 1 }
Write-Host "Todos los tests pasaron correctamente.";
