@echo off
:: http://stackoverflow.com/questions/7308586/using-batch-echo-with-special-characters
if exist %~dp0powershell.exe.activation_config goto :run
echo.^<?xml version="1.0" encoding="utf-8" ?^>                 > %~dp0powershell.exe.activation_config
echo.^<configuration^>                                        >> %~dp0powershell.exe.activation_config
echo.  ^<startup useLegacyV2RuntimeActivationPolicy="true"^>  >> %~dp0powershell.exe.activation_config
echo.    ^<supportedRuntime version="v4.0"/^>                 >> %~dp0powershell.exe.activation_config
echo.  ^</startup^>                                           >> %~dp0powershell.exe.activation_config
echo.^</configuration^>                                       >> %~dp0powershell.exe.activation_config
:run
:: point COMPLUS_ApplicationMigrationRuntimeActivationConfigPath to the directory that this cmd file lives in
:: and the directory contains a powershell.exe.activation_config file which matches the executable name powershell.exe
set COMPLUS_ApplicationMigrationRuntimeActivationConfigPath=%~dp0
%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe %*
set COMPLUS_ApplicationMigrationRuntimeActivationConfigPath=
