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

class Categorie(models.Model):
    intitule = models.CharField(max_length=200)
    artistes = models.ManyToManyField(Artiste)

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
