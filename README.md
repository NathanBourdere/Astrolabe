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

Installer les libraires Python :
```sh
pip install -r requirements.txt
```

Installer les modules node :

Windows
```sh
npm i && cd apps\Astrolabe\Astrolabe\static && npm i
```

Linux
```sh
npm i && cd apps/Astrolabe/Astrolabe/static && npm i
```

## Routes

### API (GET)

Requêter tous les artistes : `<host>/festivals/v0/artistes/`

Requêter un artiste en particulier : `<host>/festivals/v0/artistes/<pk>/`

Détail de la configuration : `<host>/festivals/v0/configuration/`

Détail des dernières modifications : `<host>/festivals/v0/modifications/`

Requêter toutes les news : `<host>/festivals/v0/news/`

Requêter une news en particulier : `<host>/festivals/v0/news/<pk>/`

Requêter tous les partenaires : `<host>/festivals/v0/partenaires/`

Requêter un partenaire en particulier : `<host>/festivals/v0/partenaires/<pk>/`

Requêter toutes les performances : `<host>/festivals/v0/performances/`

Requêter une performance en particulier : `<host>/festivals/v0/performances/<pk>/`

Requêter toutes les scènes : `<host>/festivals/v0/scenes/`

Requêter une scène en particulier : `<host>/festivals/v0/scenes/<pk>/`

### Interface admin

Accueil : `<host>/festivals/`

Liste des artistes : `<host>/festivals/artistes/<int:page>`

Création d'artistes : `<host>/festivals/artistes/create/`

Suppression d'artistes : `<host>/festivals/artistes/delete/<int:id>`

Détail d'artistes : `<host>/festivals/artistes/detail/<int:id>/`

Mise à jour d'artistes : `<host>/festivals/artistes/update/<int:id>`

Détail de la configuration : `<host>/festivals/configuration/`

Suppression de la configuration : `<host>/festivals/configuration/delete`

Mise à jour de la configuration : `<host>/festivals/configuration/update`

Liste des news : `<host>/festivals/news/<int:page>`

Création de news : `<host>/festivals/news/create/`

Suppression de news : `<host>/festivals/news/delete/<int:id>`

Détail de news : `<host>/festivals/news/detail/<int:id>/`

Mise à jour de news : `<host>/festivals/news/update/<int:id>`

Liste des partenaires : `<host>/festivals/partenaires/<int:page>`

Création de partenaires : `<host>/festivals/partenaires/create/`

Suppression de partenaires : `<host>/festivals/partenaires/delete/<int:id>`

Détail de partenaires : `<host>/festivals/partenaires/detail/<int:id>/`

Mise à jour de partenaires : `<host>/festivals/partenaires/update/<int:id>`

Liste des performances : `<host>/festivals/performances/<int:page>`

Création de performances : `<host>/festivals/performances/create/`

Suppression de performances : `<host>/festivals/performances/delete/<int:id>`

Détail de performances : `<host>/festivals/performances/detail/<int:id>`

Mise à jour de performances :  `<host>/festivals/performances/update/<int:id>`

Liste des scènes : `<host>/festivals/scenes/<int:page>`

Création de scènes : `<host>/festivals/scenes/create/`

Suppression de scènes : `<host>/festivals/scenes/delete/<int:id>`

Détail de scènes : `<host>/festivals/scenes/detail/<int:id>/`

Mise à jour de scènes : `<host>/festivals/scenes/update/<int:id>`

Liste des tags : `<host>/festivals/tags/`

Création de tags : `<host>/festivals/tags/create/`

Suppression de tags : `<host>/festivals/tags/delete/<int:id>`

Détail de tags : `<host>/festivals/tags/detail/<int:id>`

Mise à jour de tags : `<host>/festivals/tags/update/<int:id>`

