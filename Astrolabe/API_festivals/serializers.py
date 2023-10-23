from rest_framework.serializers import ModelSerializer
from .models import Artiste, Categorie, Performance, Scene, ConfigurationFestival

class ConfigurationFestivalSerializer(ModelSerializer):
    class Meta:
        model = ConfigurationFestival
        fields = '__all__'
class ArtisteSerializer(ModelSerializer):
    class Meta:
        model = Artiste
        fields = '__all__'

class CategorieSerializer(ModelSerializer):
    artistes = ArtisteSerializer(many=True)
    class Meta:
        model = Categorie
        fields = '__all__'

class SceneSerializer(ModelSerializer):
    class Meta:
        model = Scene
        fields = '__all__'

class PerformanceSerializer(ModelSerializer):
    artistes = ArtisteSerializer(many=True)
    scene = SceneSerializer()
    class Meta:
        model = Performance
        fields = '__all__'