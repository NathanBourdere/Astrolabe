from django.db import models

class Artiste(models.Model):
    nom = models.CharField(max_length=200)
    description = models.TextField()
    site_web = models.URLField(null=True, blank=True)
    youtube = models.URLField(null=True, blank=True)
    instagram = models.URLField(null=True, blank=True)
    facebook = models.URLField(null=True, blank=True)
    image = models.ImageField(upload_to='images/', null=True, blank=True)
    recommendations = models.ManyToManyField('self',blank=True)

    def __str__(self):
        return self.nom

class Partenaire(models.Model):
    nom = models.CharField(max_length=254)
    banniere = models.CharField(max_length=254,unique=True)
    site = models.URLField(max_length=254,unique=True)

    def __str__(self) -> str:
        return self.nom

class ConfigurationFestival(models.Model):
    nomFestival = models.CharField(max_length=200,unique=True)
    logoFestival = models.CharField(max_length=254,unique=True)
    descriptionFestival = models.TextField(max_length=2500)
    siteWebFestival = models.URLField(max_length=254,unique=True)
    youtubeFestival = models.URLField(max_length=254,unique=True)
    facebookFestival = models.URLField(max_length=254,unique=True)
    instagramFestival = models.URLField(max_length=254,unique=True)
    mentionsLegales = models.TextField(max_length=2500)
    policeEcriture = models.CharField(max_length=200)
    #RGB
    couleurPrincipale = models.CharField(max_length=30)
    couleurSecondaire = models.CharField(max_length=30)
    couleurBackground = models.CharField(max_length=30)
    video_promo = models.URLField(max_length=254,null=True,blank=True)
    partenaires = models.ManyToManyField(Partenaire)

    def __str__(self):
        return self.nomFestival

class Performance(models.Model):
    nom = models.CharField(max_length=200)
    date = models.DateField()
    heure_debut = models.TimeField()
    heure_fin = models.TimeField()
    artistes = models.ManyToManyField(Artiste)
    scene = models.ForeignKey('Scene', on_delete=models.CASCADE)

    def __str__(self):
        return self.nom

class Scene(models.Model):
    nom = models.CharField(max_length=200)
    image = models.ImageField(upload_to='images/', null=True, blank=True)

    def __str__(self):
        return self.nom
    
class Modification(models.Model):
    date_modif_artiste = models.DateField()
    date_modif_performance = models.DateField()
    date_modif_scene = models.DateField()
    date_modif_config = models.DateField()
    date_modif_partenaire = models.DateField()

    def __str__(self) -> str:
        return self.date_modif_artiste

class News(models.Model):
    titre = models.CharField(max_length=254)
    corps = models.CharField(max_length=254)
    image = models.CharField(max_length=254)

    def __str__(self):
        return self.titre