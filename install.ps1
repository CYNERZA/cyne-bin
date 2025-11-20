# Cyne CLI PowerShell Installer
# This script downloads and installs Cyne CLI for Windows

Write-Host ""
Write-Host "================================" -ForegroundColor Cyan
Write-Host "  Cyne CLI Windows Installer" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""

# Check if running as administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if ($isAdmin) {
    Write-Host "Running with administrator privileges..." -ForegroundColor Green
    $installDir = "$env:ProgramFiles\Cyne"
    $scope = "Machine"
} else {
    Write-Host "Running as regular user. Installing to user directory." -ForegroundColor Yellow
    $installDir = "$env:LOCALAPPDATA\Programs\Cyne"
    $scope = "User"
}

Write-Host "Installation directory: $installDir"
Write-Host ""

# Create installation directory
if (-not (Test-Path $installDir)) {
    New-Item -ItemType Directory -Path $installDir -Force | Out-Null
    Write-Host "Created directory: $installDir" -ForegroundColor Green
}

# Download latest release
Write-Host "Downloading Cyne CLI..." -ForegroundColor Cyan
$downloadUrl = "https://github.com/CYNERZA/cyne-bin/releases/latest/download/cyne-windows-x86_64.exe"
$exePath = "$installDir\cyne.exe"

try {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -Uri $downloadUrl -OutFile $exePath -ErrorAction Stop
    Write-Host "Download complete!" -ForegroundColor Green
} catch {
    Write-Host "Error: Failed to download Cyne CLI" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}

Write-Host ""

# Add to PATH
Write-Host "Configuring PATH..." -ForegroundColor Cyan

$path = [Environment]::GetEnvironmentVariable("Path", $scope)

if ($path -notlike "*$installDir*") {
    Write-Host "Adding Cyne to PATH ($scope)..." -ForegroundColor Yellow
    
    if ($path -and -not $path.EndsWith(";")) {
        $path += ";"
    }
    $path += $installDir
    
    try {
        [Environment]::SetEnvironmentVariable("Path", $path, $scope)
        Write-Host "Added to PATH successfully!" -ForegroundColor Green
        Write-Host "Please restart your terminal for PATH changes to take effect." -ForegroundColor Yellow
    } catch {
        Write-Host "Warning: Could not modify PATH automatically." -ForegroundColor Yellow
        Write-Host "Please add '$installDir' to your PATH manually." -ForegroundColor Yellow
    }
} else {
    Write-Host "Cyne is already in PATH." -ForegroundColor Green
}

# Update current session PATH
$env:Path = "$env:Path;$installDir"

Write-Host ""
Write-Host "================================" -ForegroundColor Green
Write-Host "  Installation Complete!" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Green
Write-Host ""
Write-Host "Installed to: $exePath" -ForegroundColor Cyan
Write-Host ""
Write-Host "Usage:" -ForegroundColor White
Write-Host "  1. Open a NEW terminal/PowerShell window" -ForegroundColor Gray
Write-Host "  2. Run: cyne" -ForegroundColor Gray
Write-Host ""
Write-Host "Configuration:" -ForegroundColor White
Write-Host "  Config file: $env:USERPROFILE\.cyne\config.json" -ForegroundColor Gray
Write-Host "  Run 'cyne' and use /config commands to set API keys" -ForegroundColor Gray
Write-Host ""
Write-Host "Examples:" -ForegroundColor White
Write-Host '  cyne                    - Start interactive mode' -ForegroundColor Gray
Write-Host '  cyne "your prompt"      - Run single command' -ForegroundColor Gray
Write-Host '  cyne --help             - Show help' -ForegroundColor Gray
Write-Host ""
Write-Host "Press any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
