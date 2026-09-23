# ============================================
# WIN11 RDP ENABLE SCRIPT
# Author: Dardcor Agent
# Version: 1.5.0.9-STABLE
# ============================================

# Jalankan sebagai Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "[!] Jalankan script ini sebagai Administrator!" -ForegroundColor Red
    Write-Host "[*] Klik kanan -> Run as Administrator" -ForegroundColor Yellow
    pause
    exit
}

Write-Host "[+] Mengaktifkan Remote Desktop..." -ForegroundColor Cyan

# Aktifkan RDP via Registry
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "UserAuthentication" -Value 1

# Aktifkan Remote Desktop Feature
Enable-WindowsOptionalFeature -Online -FeatureName "Remote-Desktop-Session-Host" -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName "Remote-Desktop-Session-Host-Tools" -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName "Remote-Desktop-Services" -NoRestart

# Aktifkan Network Level Authentication
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name "SecurityLayer" -Value 1

Write-Host "[+] RDP Berhasil Diaktifkan!" -ForegroundColor Green
Write-Host "[*] Restart diperlukan untuk beberapa perubahan." -ForegroundColor Yellow
Write-Host ""
Write-Host "=== INFORMASI RDP ===" -ForegroundColor Cyan
$computerName = $env:COMPUTERNAME
$username = $env:USERNAME
Write-Host "  Computer Name : $computerName" -ForegroundColor White
Write-Host "  Username      : $username" -ForegroundColor White
Write-Host "  Port          : 3389" -ForegroundColor White
Write-Host ""
Write-Host "Untuk terhubung, gunakan: mstsc.exe di komputer lain" -ForegroundColor Green

# Tanya restart
$restart = Read-Host "[?] Restart sekarang? (y/n)"
if ($restart -eq "y") {
    Restart-Computer -Force
}
