from .serializers import *
from .models import *
from rest_framework import viewsets,decorators
from django.db import transaction  

class ArtisteViewSet(viewsets.ReadOnlyModelViewSet):
    serializer_class = ArtisteSerializer

    def get_queryset(self):
        queryset = Artiste.objects.all()
        id_artiste = self.request.GET.get("id")
        if id_artiste is not None:
            queryset = queryset.filter(id=id_artiste)
        return queryset

class PerformanceViewSet(viewsets.ReadOnlyModelViewSet):
    serializer_class = PerformanceSerializer

    def get_queryset(self):
        queryset =  Performance.objects.all()
        id_performance = self.request.GET.get("id")
        if id_performance is not None:
            queryset = queryset.filter(id=id_performance)
        return queryset

class SceneViewSet(viewsets.ReadOnlyModelViewSet):
    serializer_class = SceneSerializer

    def get_queryset(self):
        queryset =  Scene.objects.all()
        id_scene = self.request.GET.get("id")
        if id_scene is not None:
            queryset = queryset.filter(id=id_scene)
        return queryset

class ConfigurationFestivalViewSet(viewsets.ReadOnlyModelViewSet):
    serializer_class = ConfigurationFestivalSerializer

    def get_queryset(self):
        queryset = ConfigurationFestival.objects.all()
        id_festival = self.request.GET.get("id")
        if id_festival :
            queryset = queryset.filter(id=id_festival)
        return queryset

class PartenaireViewSet(viewsets.ReadOnlyModelViewSet):
    serializer_class = PartenaireSerializer

    def get_queryset(self):
        queryset = Partenaire.objects.all()
        id_partenaire = self.request.GET.get("id")
        if id_partenaire :
            queryset = queryset.filter(id=id_partenaire)
        return queryset

class ModificationViewSet(viewsets.ReadOnlyModelViewSet):
    serializer_class = ModificationSerializer

    def get_queryset(self):
        queryset = Modification.objects.all()
        id_modification = self.request.GET.get("id")
        if id_modification :
            queryset = queryset.filter(id=id_modification)
        return queryset

class NewsViewSet(viewsets.ReadOnlyModelViewSet):
    serializer_class = NewsSerializer

    def get_queryset(self):
        queryset = News.objects.all()
        id_news = self.request.GET.get("id")
        if id_news :
            queryset = queryset.filter(id=id_news)
        return queryset