# ============================================
# FIREWALL CONFIGURATION FOR RDP
# ============================================

Write-Host "[+] Mengonfigurasi Firewall untuk RDP..." -ForegroundColor Cyan

# Aktifkan aturan firewall RDP yang sudah ada
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# Tambahkan aturan kustom jika tidak ada
$ruleExists = Get-NetFirewallRule -DisplayName "Remote Desktop - User Mode (TCP-In)" -ErrorAction SilentlyContinue
if (-not $ruleExists) {
    New-NetFirewallRule -DisplayName "RDP Allow (Dardcor)" `
        -Direction Inbound `
        -Protocol TCP `
        -LocalPort 3389 `
        -Action Allow `
        -Profile Any
    Write-Host "[+] Aturan firewall RDP baru dibuat." -ForegroundColor Green
} else {
    Write-Host "[+] Aturan firewall RDP sudah aktif." -ForegroundColor Green
}

# Jika menggunakan port custom, buka juga
# Ganti 3390 dengan port yang diinginkan
# New-NetFirewallRule -DisplayName "RDP Custom Port" -Direction Inbound -Protocol TCP -LocalPort 3390 -Action Allow

Write-Host "[+] Firewall dikonfigurasi." -ForegroundColor Green
