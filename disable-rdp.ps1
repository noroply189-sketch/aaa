# ============================================
# DISABLE RDP SCRIPT
# ============================================

$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "[!] Jalankan sebagai Administrator!" -ForegroundColor Red
    pause
    exit
}

Write-Host "[-] Menonaktifkan RDP..." -ForegroundColor Yellow

Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 1
Disable-NetFirewallRule -DisplayName "Remote Desktop - User Mode (TCP-In)" -ErrorAction SilentlyContinue
Disable-NetFirewallRule -DisplayName "RDP Allow (Dardcor)" -ErrorAction SilentlyContinue

Write-Host "[-] RDP Dinonaktifkan." -ForegroundColor Yellow
