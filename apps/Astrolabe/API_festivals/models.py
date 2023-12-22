from django.db import models
from django.utils import timezone

class Artiste(models.Model):
    nom = models.CharField(max_length=200)
    description = models.TextField()
    site_web = models.URLField(null=True, blank=True)
    youtube = models.URLField(null=True, blank=True)
    instagram = models.URLField(null=True, blank=True)
    facebook = models.URLField(null=True, blank=True)
    image = models.ImageField(upload_to='static/model/artistes/', unique=True,default='static/model/artistes/default.jpg')
    recommendations = models.ManyToManyField('self',blank=True)

    def description_tronquee(self,max_len=55):
        if len(self.description) > max_len:
            return self.description[:max_len] + "..."
        return self.description
    
    def __str__(self):
        return self.nom

class Partenaire(models.Model):
    nom = models.CharField(max_length=254)
    banniere = models.ImageField(upload_to='static/model/partenaires/', unique=True)
    site = models.URLField(max_length=254,unique=True)

    def __str__(self) -> str:
        return self.nom

class PoliceEcriture(models.Model):
    nom = models.CharField(max_length=200,unique=True)

    def __str__(self):
        return self.nom

class ConfigurationFestival(models.Model):
    nomFestival = models.CharField(max_length=200,unique=True)
    logoFestival = models.ImageField(upload_to="static/model/configuration/logo/",unique=True)
    descriptionFestival = models.TextField(max_length=2500)
    siteWebFestival = models.URLField(max_length=254,unique=True)
    youtubeFestival = models.URLField(max_length=254,unique=True)
    facebookFestival = models.URLField(max_length=254,unique=True)
    instagramFestival = models.URLField(max_length=254,unique=True)
    mentionsLegales = models.TextField(max_length=2500)
    policeEcriture = models.ForeignKey('PoliceEcriture', on_delete=models.CASCADE)
    #RGB
    couleurPrincipale = models.CharField(max_length=30)
    couleurSecondaire = models.CharField(max_length=30)
    couleurBackground = models.CharField(max_length=30)
    video_promo = models.FileField(upload_to="static/model/configuration/video/", null=True, blank=True)
    partenaires = models.ManyToManyField(Partenaire)
    mode_festival = models.BooleanField(default=True)

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

class Tag(models.Model):
    nom = models.CharField(max_length=50)
    visible = models.BooleanField(default=True)
    performances = models.ManyToManyField(Performance)

    def __str__(self):
        return self.nom

class Scene(models.Model):
    nom = models.CharField(max_length=200)
    image = models.ImageField(upload_to='static/model/scenes/', unique=True,default='static/model/scenes/default.jpg')
    lieu = models.CharField(max_length=200, default="Astrolabe")

    def __str__(self):
        return self.nom
    
class Modification(models.Model):
    date_modif_artiste = models.DateTimeField(default=timezone.now)
    date_modif_performance = models.DateTimeField(default=timezone.now)
    date_modif_scene = models.DateTimeField(default=timezone.now)
    date_modif_config = models.DateTimeField(default=timezone.now)
    date_modif_partenaire = models.DateTimeField(default=timezone.now)
    date_modif_news = models.DateTimeField(default=timezone.now)
    date_modif_tags = models.DateTimeField(default=timezone.now)

    def __str__(self) -> str:
        return self.date_modif_artiste

class News(models.Model):
    titre = models.CharField(max_length=254)
    corps = models.TextField(max_length=254)
    image = models.ImageField(upload_to='static/model/news', max_length=254)
    date = models.DateTimeField(default=timezone.now)

    def __str__(self):
        return self.titre
