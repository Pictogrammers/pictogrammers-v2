@echo off

set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

set "CERT_STORE=certs"
set "KEY_FILE=./%CERT_STORE%/dev.pictogrammers-key.pem"
set "CERT_FILE=./%CERT_STORE%/dev.pictogrammers.pem"

IF NOT EXIST %KEY_FILE% IF NOT EXIST %CERT_FILE% (
  choco install mkcert
  mkcert -install
  mkdir "%CERT_STORE%"
  mkcert -key-file "%KEY_FILE%" -cert-file "%CERT_FILE%" dev.pictogrammers.com dev-api.pictogrammers.com localhost 127.0.0.1 ::1
)
