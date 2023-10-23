from .serializers import ArtisteSerializer, CategorieSerializer, PerformanceSerializer, SceneSerializer, ConfigurationFestivalSerializer
from .models import Artiste, Categorie, Performance, Scene, ConfigurationFestival
from rest_framework import viewsets

class ArtisteViewSet(viewsets.ModelViewSet):
    serializer_class = ArtisteSerializer

    def get_queryset(self):
        queryset = Artiste.objects.all()
        id_artiste = self.request.GET.get("id")
        if id_artiste is not None:
            queryset = queryset.filter(id=id_artiste)
        return queryset

class CategorieViewSet(viewsets.ModelViewSet):
    serializer_class = CategorieSerializer

    def get_queryset(self):
        queryset =  Categorie.objects.all()
        id_categorie = self.request.GET.get("id")
        if id_categorie is not None:
            queryset = queryset.filter(id=id_categorie)
        return queryset

class PerformanceViewSet(viewsets.ModelViewSet):
    serializer_class = PerformanceSerializer

    def get_queryset(self):
        queryset =  Performance.objects.all()
        id_performance = self.request.GET.get("id")
        if id_performance is not None:
            queryset = queryset.filter(id=id_performance)
        return queryset

class SceneViewSet(viewsets.ModelViewSet):
    serializer_class = SceneSerializer

    def get_queryset(self):
        queryset =  Scene.objects.all()
        id_scene = self.request.GET.get("id")
        if id_scene is not None:
            queryset = queryset.filter(id=id_scene)
        return queryset

from rest_framework import viewsets
from .models import ConfigurationFestival
from .serializers import ConfigurationFestivalSerializer

class ConfigurationFestivalViewSet(viewsets.ModelViewSet):
    serializer_class = ConfigurationFestivalSerializer

    def get_queryset(self):
        queryset = ConfigurationFestival.objects.all()
        id_festival = self.request.GET.get("id")
        if id_festival:
            queryset = queryset.filter(id=id_festival)
        return queryset
