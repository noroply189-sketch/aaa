@echo off
TITLE Dardcor Agent - Win11 RDP Quick Config
COLOR 0A

echo ============================================
echo   WIN11 RDP QUICK CONFIGURATION
echo   Dardcor Agent | v1.5.0.9-STABLE
echo ============================================
echo.

:: Cek Admin
net session >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [!] Jalankan sebagai Administrator!
    echo     Klik kanan -> Run as Administrator
    pause
    exit /b 1
)

echo [+] Mengaktifkan RDP...
reg add "HKLM\System\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f >nul 2>&1
echo    [OK] RDP Diaktifkan

echo [+] Mengaktifkan Network Level Authentication...
reg add "HKLM\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v UserAuthentication /t REG_DWORD /d 1 /f >nul 2>&1
echo    [OK] NLA Diaktifkan

echo [+] Membuka Port 3389 di Firewall...
netsh advfirewall firewall add rule name="RDP_Dardcor" dir=in action=allow protocol=TCP localport=3389 >nul 2>&1
echo    [OK] Port 3389 Dibuka

echo [+] Mengaktifkan fitur Remote Desktop...
dism /online /enable-feature /featurename:Remote-Desktop-Session-Host /norestart >nul 2>&1
echo    [OK] Feature Diaktifkan

echo.
echo ============================================
echo   RDP BERHASIL DIKONFIGURASI!
echo ============================================
echo.
echo   Computer Name: %COMPUTERNAME%
echo   Port: 3389
echo.
echo   Untuk connect: Jalankan mstsc.exe di PC lain
echo.
echo [?] Restart sekarang? (Y/N)
set /p choice=
if /i "%choice%"=="Y" (
    shutdown /r /t 5 /c "Restarting for RDP changes - Dardcor Agent"
)
pause
