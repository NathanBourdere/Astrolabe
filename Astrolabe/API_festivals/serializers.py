from rest_framework.serializers import ModelSerializer,PrimaryKeyRelatedField
from .models import Artiste, Performance, Scene, ConfigurationFestival,Modification,Partenaire,News
class ArtisteSerializer(ModelSerializer):
    recommendations = PrimaryKeyRelatedField(many=True, queryset=Artiste.objects.all())

    class Meta:
        model = Artiste
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

class ModificationSerializer(ModelSerializer):
    class Meta:
        model = Modification
        fields = '__all__'

class PartenaireSerializer(ModelSerializer):
    class Meta:
        model = Partenaire
        fields = '__all__'

class ConfigurationFestivalSerializer(ModelSerializer):
    partenaires = PartenaireSerializer(many=True)
    class Meta:
        model = ConfigurationFestival
        fields = '__all__'

class NewsSerializer(ModelSerializer):
    class Meta:
        model = News
        fields = '__all__'