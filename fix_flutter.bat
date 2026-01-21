@echo off
echo Killing processes that might be locking Flutter files...
taskkill /F /IM dart.exe 2>nul
taskkill /F /IM flutter.exe 2>nul
taskkill /F /IM chrome.exe 2>nul
taskkill /F /IM msedge.exe 2>nul
taskkill /F /IM java.exe 2>nul
taskkill /F /IM adb.exe 2>nul

echo Waiting for 3 seconds...
timeout /t 3 /nobreak >nul

echo Running Flutter clean...
flutter clean

echo Running Flutter pub get...
flutter pub get

echo Done!
pause