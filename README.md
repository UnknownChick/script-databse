# Script d'export/installation de base de données WordPress et Prestashop

## Prérequis
Avoir MySQL et mysqldump installé sur sa machine

Bien respecter le nommage de vos fichiers

## Installation
Choisissez les scripts en fonction de votre environnement et mettez les à la racine du projet

## Fonctionnement
La configuration de votre wordpress est automatiquement récupérer ```/wp-config.php``` ou ```/.env```

La configuration de votre prestashop est automatiquement récupérer ```/app/config/parameters.php```

La base de données est exporté dans ```/db/database_export.sql``` à la racine du projet

## Éxécution
Installation/import de la base de données
```SHELL
./install-db.bat
```

Exportation de la base de données
```SHELL
./export-db.bat
```

## Faire attention
**NE PAS OUBLIEZ DE LES SUPPRIMER EN PROD**