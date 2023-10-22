chcp 65001
@echo off
setlocal enabledelayedexpansion

REM Définition du fichier de configuration par défaut
set ENV_FILE=.env

REM Vérifier si .env.local existe et l'utiliser si c'est le cas
if exist .env.local set ENV_FILE=.env.local

REM Initialisation des variables par défaut à vide
set DB_NAME=
set DB_USER=
set DB_PASSWORD=

REM Lire le fichier de configuration et définir les variables spécifiques
for /F "tokens=1* delims==" %%a in (%ENV_FILE%) do (
	if "%%a"=="DB_NAME" set DB_NAME=%%b
	if "%%a"=="DB_USER" set DB_USER=%%b
	if "%%a"=="DB_PASSWORD" set DB_PASSWORD=%%b
)

REM Supprimer les guillemets simples
set DB_NAME=!DB_NAME:'=!
set DB_USER=!DB_USER:'=!
set DB_PASSWORD=!DB_PASSWORD:'=!

REM Vérification que toutes les variables nécessaires sont définies
if not defined DB_NAME (
	echo DB_NAME n'est pas défini dans %ENV_FILE% et exit /b 1
)
if not defined DB_USER (
	echo DB_USER n'est pas défini dans %ENV_FILE% et exit /b 1
)
if not defined DB_PASSWORD (
	echo DB_PASSWORD n'est pas défini dans %ENV_FILE% et exit /b 1
)

set EXPORT_DIR=db

REM Vérifier si le répertoire 'db' existe, sinon le créer
if not exist %EXPORT_DIR% mkdir %EXPORT_DIR%

REM Exporter la base de données vers un fichier SQL dans le répertoire 'db'
mysqldump -u%DB_USER% -p%DB_PASSWORD% %DB_NAME% > %EXPORT_DIR%\database_export.sql

echo.
echo Export termine!

endlocal