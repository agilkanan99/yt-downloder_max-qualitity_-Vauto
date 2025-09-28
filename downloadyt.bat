@echo off
title YouTube Downloader Agilkanan vAuto
color 0a

:: Folder default download
set "DOWNLOAD_DIR=C:\DownloadYT"

:: Cek folder download, kalau belum ada bikin
if not exist "%DOWNLOAD_DIR%" mkdir "%DOWNLOAD_DIR%"

:menu
cls
echo ===========================================
echo     YouTube Downloader Agilkanan vAuto
echo ===========================================
echo.
echo [1] Download video kualitas terbaik (MP4)
echo [2] Download audio saja (MP3)
echo [3] Cek daftar format / playback link (via getlink.py)
echo [4] Keluar
echo.
set /p pilihan=Pilih menu (1-4): 

if "%pilihan%"=="1" goto download_video
if "%pilihan%"=="2" goto download_audio
if "%pilihan%"=="3" goto getlink
if "%pilihan%"=="4" exit
goto menu

:download_video
cls
echo ===========================================
echo     MODE: Download Video (MP4)
echo ===========================================
echo.
set /p url=Masukkan link YouTube: 
echo.

:: Paksa output MP4 (tanpa embed metadata/thumbnail biar cepat)
if exist "C:\yt-dlp\cookies.txt" (
    echo [INFO] Menggunakan cookies.txt ...
    yt-dlp.exe --cookies "C:\yt-dlp\cookies.txt" ^
        -S ext:mp4:m4a ^
        --merge-output-format mp4 ^
        --no-embed-metadata --no-embed-thumbnail ^
        --concurrent-fragments 8 ^
        -o "%DOWNLOAD_DIR%\%%(title).100s.mp4" "%url%"
) else (
    echo [INFO] Tidak ada cookies.txt, lanjut tanpa cookies ...
    yt-dlp.exe -S ext:mp4:m4a ^
        --merge-output-format mp4 ^
        --no-embed-metadata --no-embed-thumbnail ^
        --concurrent-fragments 8 ^
        -o "%DOWNLOAD_DIR%\%%(title).100s.mp4" "%url%"
)

echo.
echo ===========================================
echo Download Video selesai! Cek di: %DOWNLOAD_DIR%
echo ===========================================
pause
goto menu

:download_audio
cls
echo ===========================================
echo     MODE: Download Audio (MP3)
echo ===========================================
echo.
set /p url=Masukkan link YouTube: 
echo.

:: Audio tetap mp3
if exist "C:\yt-dlp\cookies.txt" (
    echo [INFO] Menggunakan cookies.txt ...
    yt-dlp.exe --cookies "C:\yt-dlp\cookies.txt" ^
        -x --audio-format mp3 ^
        --concurrent-fragments 8 ^
        -o "%DOWNLOAD_DIR%\%%(title).100s.mp3" "%url%"
) else (
    echo [INFO] Tidak ada cookies.txt, lanjut tanpa cookies ...
    yt-dlp.exe -x --audio-format mp3 ^
        --concurrent-fragments 8 ^
        -o "%DOWNLOAD_DIR%\%%(title).100s.mp3" "%url%"
)

echo.
echo ===========================================
echo Download Audio selesai! Cek di: %DOWNLOAD_DIR%
echo ===========================================
pause
goto menu

:getlink
cls
echo ===========================================
echo     MODE: Cek Format / Playback Link
echo ===========================================
echo.
set /p url=Masukkan link YouTube: 
echo.

python getlink.py "%url%"

echo.
echo ===========================================
echo Daftar format ditampilkan di atas.
echo ===========================================
pause
goto menu
