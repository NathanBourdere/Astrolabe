from django.db import models

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
    