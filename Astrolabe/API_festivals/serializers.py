from rest_framework.serializers import ModelSerializer
from .models import Artiste, Categorie, Performance, Scene

class ArtisteSerializer(ModelSerializer):
    class Meta:
        model = Artiste
        fields = ["id", "nom", "description", "site_web", "youtube", "instagram", "facebook", "image"]

class CategorieSerializer(ModelSerializer):
    artistes = ArtisteSerializer(many=True)
    class Meta:
        model = Categorie
        fields = ["id", "intitule", "artistes"]

class SceneSerializer(ModelSerializer):
    class Meta:
        model = Scene
        fields = ["id", "nom", "image"]

class PerformanceSerializer(ModelSerializer):
    artistes = ArtisteSerializer(many=True)
    scene = SceneSerializer()
    class Meta:
        model = Performance
        fields = ["id", "nom", "date", "heure_debut", "heure_fin", "artistes", "scene"]