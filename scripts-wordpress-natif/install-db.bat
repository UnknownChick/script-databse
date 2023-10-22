chcp 65001
@echo off
setlocal enabledelayedexpansion

REM Chemin vers le fichier wp-config.php
set WP_CONFIG=wp-config.php

REM Vérifiez si le fichier wp-config.php existe
if not exist %WP_CONFIG% (
    echo Fichier wp-config.php non trouvé !
    exit /b 1
)

REM Initialisation des variables par défaut à vide
set DB_NAME=
set DB_USER=
set DB_PASSWORD=

REM Lire le fichier wp-config.php et extraire les constantes
for /F "tokens=1,2* delims=() " %%a in ('type %WP_CONFIG% ^| findstr /i "DB_NAME DB_USER DB_PASSWORD"') do (
    if "%%a"=="define" (
        set line=%%c
        if "%%b"=="'DB_NAME'," set DB_NAME=!line:~1,-2!
        if "%%b"=="'DB_USER'," set DB_USER=!line:~1,-2!
        if "%%b"=="'DB_PASSWORD'," set DB_PASSWORD=!line:~1,-2!
    )
)

REM Vérification que toutes les variables nécessaires sont définies
if not defined DB_NAME (
    echo DB_NAME n'est pas défini dans %WP_CONFIG%
)
if not defined DB_USER (
    echo DB_USER n'est pas défini dans %WP_CONFIG%
)
if not defined DB_PASSWORD (
    echo DB_PASSWORD n'est pas défini dans %WP_CONFIG%
)

REM Nettoyage des variables pour supprimer l'espace et la virgule
set DB_NAME=!DB_NAME:'=!
set DB_USER=!DB_USER:'=!
set DB_PASSWORD=!DB_PASSWORD:'=!

echo Création de la base de données...
mysql -u%DB_USER% -p%DB_PASSWORD% -e "CREATE DATABASE IF NOT EXISTS %DB_NAME%;"

echo Importation de la base de données...
mysql -u%DB_USER% -p%DB_PASSWORD% %DB_NAME% < db/database_export.sql

echo Terminé!
endlocal