from django.db import models

class Artiste(models.Model):
    nom = models.CharField(max_length=200)
    description = models.TextField()
    site_web = models.URLField(null=True, blank=True)
    youtube = models.URLField(null=True, blank=True)
    instagram = models.URLField(null=True, blank=True)
    facebook = models.URLField(null=True, blank=True)
    image = models.ImageField(upload_to='images/', null=True, blank=True)

    def __str__(self):
        return self.nom

class ConfigurationFestival(models.Model):
    nomFestival = models.CharField(max_length=200,unique=True)
    logoFestival = models.CharField(max_length=400,unique=True)
    descriptionFestival = models.TextField(max_length=2500)
    siteWebFestival = models.URLField(max_length=300,unique=True)
    youtubeFestival = models.URLField(max_length=300,unique=True)
    facebookFestival = models.URLField(max_length=300,unique=True)
    instagramFestival = models.URLField(max_length=300,unique=True)
    mentionsLegales = models.TextField(max_length=2000)
    policeEcriture = models.CharField(max_length=200)
    #RGB
    couleurPrincipale = models.CharField(max_length=30)
    couleurSecondaire = models.CharField(max_length=30)
    couleurBackground = models.CharField(max_length=30)

    def __str__(self):
        return self.nomFestival

class Categorie(models.Model):
    intitule = models.CharField(max_length=200)
    artistes = models.ManyToManyField(Artiste)

    def __str__(self):
        return self.intitule

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
