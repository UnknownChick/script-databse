chcp 65001
@echo off
setlocal enabledelayedexpansion

REM Chemin correct vers le fichier parameters.php
set PARAMETERS_FILE=app\config\parameters.php

REM Vérifiez si le fichier parameters.php existe
if not exist %PARAMETERS_FILE% (
	echo Fichier parameters.php non trouvé !
	exit /b 1
)

REM Initialisation des variables par défaut à vide
set DB_NAME=
set DB_USER=
set DB_PASSWORD=

REM Lire le fichier parameters.php et extraire les valeurs
for /F "tokens=*" %%a in ('type "%PARAMETERS_FILE%"') do (
    set line=%%a
    if "!line:database_name=!" NEQ "%%a" set DB_NAME=!line:~20,-2!
    if "!line:database_user=!" NEQ "%%a" set DB_USER=!line:~20,-2!
    if "!line:database_password=!" NEQ "%%a" set DB_PASSWORD=!line:~24,-2!
)

REM Vérification que toutes les variables nécessaires sont définies
if not defined DB_NAME (
	echo DB_NAME n'est pas defini dans %PARAMETERS_FILE%
	exit /b 1
)
if not defined DB_USER (
	echo DB_USER n'est pas defini dans %PARAMETERS_FILE%
	exit /b 1
)
if not defined DB_PASSWORD (
	echo DB_PASSWORD n'est pas defini dans %PARAMETERS_FILE%
	exit /b 1
)

echo Création de la base de données...
mysql -u%DB_USER% -p%DB_PASSWORD% -e "CREATE DATABASE IF NOT EXISTS %DB_NAME%;"

echo Importation de la base de données...
mysql -u%DB_USER% -p%DB_PASSWORD% %DB_NAME% < db/database_export.sql

echo Terminé!
endlocal