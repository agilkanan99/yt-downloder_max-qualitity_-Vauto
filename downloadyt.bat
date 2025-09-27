@echo off
title YouTube Downloader Agilkanan vAuto
color 0a

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

:: Cek cookies
if exist "C:\yt-dlp\cookies.txt" (
    echo [INFO] Menggunakan cookies.txt ...
    yt-dlp.exe --cookies "C:\yt-dlp\cookies.txt" -f "bv*+ba/b" -o "C:\DownloadYT\%%(title)s.mp4" "%url%"
) else (
    echo [INFO] Tidak ada cookies.txt, lanjut tanpa cookies ...
    yt-dlp.exe -f "bv*+ba/b" -o "C:\DownloadYT\%%(title)s.mp4" "%url%"
)

echo.
echo ===========================================
echo Download Video selesai! Cek di: C:\DownloadYT
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

:: Cek cookies
if exist "C:\yt-dlp\cookies.txt" (
    echo [INFO] Menggunakan cookies.txt ...
    yt-dlp.exe --cookies "C:\yt-dlp\cookies.txt" -x --audio-format mp3 -o "C:\DownloadYT\%%(title)s.mp3" "%url%"
) else (
    echo [INFO] Tidak ada cookies.txt, lanjut tanpa cookies ...
    yt-dlp.exe -x --audio-format mp3 -o "C:\DownloadYT\%%(title)s.mp3" "%url%"
)

echo.
echo ===========================================
echo Download Audio selesai! Cek di: C:\DownloadYT
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

:: Panggil Python script getlink.py
python getlink.py "%url%"

echo.
echo ===========================================
echo Daftar format ditampilkan di atas.
echo ===========================================
pause
goto menu
