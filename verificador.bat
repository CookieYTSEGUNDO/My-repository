@echo off
@chcp 65001>nul
set versao=1.0.0
set "filebatch=%~dp0"
title Cookie Client Roblox / Config
goto :config

:config
taskkill /f /im RobloxPlayerBeta.exe
taskkill /f /im RobloxPlayerLauncher.exe
cd %filebatch%
color 07
cls
echo [1] Setar mouse para o mouse preto/cinza antigo do roblox. (ou remover alterações também)
echo [2] Desabilitar atualizações do client (Ou reinstalar o robloxplayerlauncher e desabilitar o robloxplayerbeta para abrir um GUI)
if "%setado%"=="1" echo [3] Voltar ao mouse anterior
if "%atualizado%"=="1" echo [4] Reverter Alteração do roblox player beta
echo [5] Remover texturas
echo [6] Voltar texturas (Apenas para quando você removeu as texturas)
choice /c:123456 /N /M ">:"
set choice=%errorlevel%
if "%choice%"=="1" goto :mouse
if "%choice%"=="2" goto :desativaratualizacoes
if "%choice%"=="3" goto :voltarmouse
if "%choice%"=="4" goto :voltaratualizacoes
if "%choice%"=="5" goto :removertexturas
if "%choice%"=="6" goto :voltartexturas


:mouse
if "%setado%"=="1" color 04 && echo Você não pode setar novamente o mouse, coloque a opção 3 para voltar ao mouse novo. && pause && goto :config
if exist "PlatformContent" ( cd PlatformContent) else ( color 04 && echo Roblox não encontrado && pause && goto :config)
cd textures
cd Cursors
cd KeyboardMouse
move *.png ..\..\..\MOUSES\Backup
timeout /t 1 /nobreak >nul
del *.png
cd %filebatch%
cd PlatformContent\MOUSES\Backup
copy *.png ..\..\textures\Cursors\KeyboardMouse\
cls
echo Pronto!
set setado=1
pause
goto :config

:desativaratualizacoes
if "%atualizado%"=="1" color 04 && echo Erro, você já converteu o seu roblox. && pause && goto :config
set atualizado=1
echo Desativando atualizações e roblox desktop...
mkdir RobloxPlayerLauncherBACKUP
cd RobloxPlayerLauncherBACKUP
copy ..\RobloxPlayerLauncher.exe RobloxPlayerLauncherBackup.exe.backup
cls
cd ..
del RobloxPlayerLauncher.exe
curl https://raw.githubusercontent.com/CookieYTSEGUNDO/My-repository/main/version > versao.txt
>nul findstr /c:"%versao%" versao.txt && (
  del versao.txt
) || (
  
)
curl -L -o RobloxPlayerLauncher.exe https://github.com/CookieYTSEGUNDO/My-repository/blob/main/RobloxPlayerLauncher.exe?raw=true --ssl-no-revoke
cls
echo Você já tem o cookie client completo! :)
pause
goto :config

:voltarmouse
if "%setado%"=="0" goto :config
set setado=0
if exist "PlatformContent" ( cd PlatformContent) else ( color 04 && echo Roblox não encontrado && pause && goto :config)
cd textures
cd Cursors
cd KeyboardMouse
echo A|copy *.png ..\..\..\MOUSES\Backup
cls
del *.png
cd %filebatch%
cd PlatformContent\MOUSES
copy *.png ..\textures\Cursors\KeyboardMouse\
cls
echo Pronto!
set setado=0
pause
goto :config

:voltaratualizacoes
if "%atualizado%"=="0" goto :config
set atualizado=0
echo Ativando atualizações e roblox desktop...
del RobloxPlayerLauncher.exe
cd RobloxPlayerLauncherBACKUP
move RobloxPlayerLauncherBackup.exe.backup ..
copy RobloxPlayerLauncherBackup.exe.backup RobloxPlayerLauncher.exe
timeout /t 1 /nobreak >nul
move RobloxPlayerLauncher.exe.backup RobloxPlayerLauncherBACKUP
cls
echo Agora você só tem o roblox optimizado pelo cookie client :(
pause
goto :config



:removertexturas
cls
if "%texturas%"=="1" color 04 && echo Erro, Você deve reverter as alterações das texturas. && pause && goto :config
if exist "ClientSettings" ( cd ClientSettings) else ( mkdir ClientSettings && cd ClientSettings)
cls
echo Removendo textura..
echo {"FFlagDebugDisableOTAMaterialTexture":"true"} > ClientAppSettings.json
cls
echo Textura removida!
set texturas=1
pause
goto :config


:voltartexturas
if "%texturas%"=="0" goto :config
cls
if exist "ClientSettings" ( cd ClientSettings) else ( mkdir ClientSettings && cd ClientSettings)
echo {"FFlagDebugDisableOTAMaterialTexture":"false"} > ClientAppSettings.json
cls
goto :config
