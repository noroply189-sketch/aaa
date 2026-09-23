# ============================================
# INSTALL ALL REMOTE DESKTOP FEATURES
# ============================================

Write-Host "[+] Menginstall semua fitur Remote Desktop..." -ForegroundColor Cyan

$features = @(
    "Remote-Desktop-Session-Host",
    "Remote-Desktop-Session-Host-Tools",
    "Remote-Desktop-Services",
    "Remote-Desktop-Services-Licensing",
    "RSAT-Remote-Desktop-Services",
    "RSAT-Remote-Desktop-Services-Licensing",
    "RSAT-Remote-Desktop-Services-Connection",
    "RSAT-Remote-Desktop-Services-Shadow",
    "RSAT-Remote-Desktop-Services-WebAccess",
    "RSAT-Remote-Desktop-Services-Gateway",
    "RSAT-Remote-Desktop-Services-Logging",
    "RSAT-Remote-Desktop-Services-Performance",
    "RSAT-Remote-Desktop-Services-Prototyping"
)

foreach ($feature in $features) {
    try {
        $status = Get-WindowsOptionalFeature -Online -FeatureName $feature -ErrorAction SilentlyContinue
        if ($status.State -eq "Disabled") {
            Enable-WindowsOptionalFeature -Online -FeatureName $feature -NoRestart
            Write-Host "[OK] $feature - Diaktifkan" -ForegroundColor Green
        } elseif ($status.State -eq "Enabled") {
            Write-Host "[SKIP] $feature - Sudah aktif" -ForegroundColor Yellow
        } else {
            Write-Host "[?] $feature - Status: $($status.State)" -ForegroundColor Cyan
        }
    } catch {
        Write-Host "[ERR] $feature - Tidak ditemukan atau error" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "[+] Semua fitur Remote Desktop diproses." -ForegroundColor Green
