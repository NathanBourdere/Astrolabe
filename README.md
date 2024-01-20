# Astrolabe
Astrolabe est un projet proposé par l'organisme du même nom à l'IUT Informatique d'Orléans dans le cadre de la SAÉ de troisième année de BUT.

## Installation et lancement du serveur

### Utilisation d'un environnement virtuel Python (facultatif mais recommandé)
Création de l'environnement virtuel :
```sh
python -m venv venv
```
Activation de l'environnement :

Windows
```sh
.\venv\Scripts\activate
```

Linux
```sh
source venv/bin/activate
```

Pour sortir de l'environnement virtuel python vous n'aurez qu'à exécuter la commande qui suit quand vous le souhaiterez :
```sh
deactivate
```

### Installation des dépendances

Aller dans le dossier du projet :
```sh
cd apps\Astrolabe\
```

Installer les libraires Python :
```sh
pip install -r requirements.txt
```

Installer les modules node :
- Windows
```sh
npm i && cd apps\Astrolabe\Astrolabe\static && npm i
```

- Linux
```sh
npm i && cd apps/Astrolabe/Astrolabe/static && npm i
```

## Documentations de l'API

- Sous format JSON : `<host>/swagger.json`
- Sous format YAML : `<host>/swagger.yaml`
- Vue UI Swagger : `<host>/swagger`
- Vue ReDoc : `<host>/redoc`

## Tests

### Tests unitaires Django

Se rendre dans le dossier du projet :
```sh
cd apps\Astrolabe\
```

Lancer les tests unitaires :
```sh
python manage.py test
```

### Tests E2E Cypress

Installer les dépendances Cypress (si ce n'est pas déjà fait) :
```sh
npm install
```

Installer les packages nécessaires pour Django via Nx (si ce n'est pas déjà fait) :
```sh
npx nx run apps:install
```

En cas de problème avec MySQL, installer les dépendances nécessaires :
```sh
apt install pkg-config libmariadb-dev-compat
```

Modifier les informations de connexion à la base de données MySQL dans le fichier `settings.py` 
```sh
cd apps/Astrolabe/Astrolabe
nano settings.py
```

Créer la base de données avec la commande suivante dans le shell MySQL:
```sh
create database astrolabe_admin
```

Remplir la base de données avec des données de test :
```sh
npx nx run apps:populate
```

Lancer le site :
```sh
npx nx run apps:serve
```

Accéder à Cypress pour exécuter les tests :
```sh
npx cypress open
```