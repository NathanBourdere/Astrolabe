from django.urls import path, include
from .views import *
from .viewsets import *
from rest_framework import routers

app_name = 'API_festivals'

routers = routers.SimpleRouter()
routers.register('artistes', ArtisteViewSet, basename='artistes')
routers.register('performances', PerformanceViewSet, basename='performances')
routers.register('scenes', SceneViewSet, basename='scenes')
routers.register('configuration', ConfigurationFestivalViewSet, basename='configuration')
routers.register('partenaires', PartenaireViewSet, basename='partenaires')
routers.register('modifications', ModificationViewSet, basename='modifications')
routers.register('news',NewsViewSet,basename="news")
routers.register('tags', TagsViewSet, basename="tags")

urlpatterns = [
    path('v0/', include(routers.urls)),
    path('', accueil, name='accueil'),
    path('configuration/', configuration, name='configuration'),
    path('configuration/update', configuration_update, name='configuration_update'),
    path('configuration/delete', configuration_delete, name='configuration_delete'),
    path('artistes/<int:page>', artistes, name='artistes'),
    path('artistes/detail/<int:id>', artiste_detail, name='artiste_detail'),
    path('artistes/update/<int:id>', artiste_update, name='artiste_update'),
    path('artistes/delete/<int:id>', artiste_delete, name='artiste_delete'),
    path('artistes/create', artiste_create, name='artiste_create'),
    path('partenaires/<int:page>', partenaires, name='partenaires'),
    path('partenaires/detail/<int:id>', partenaire_detail, name='partenaire_detail'),
    path('partenaires/update/<int:id>', partenaire_update, name='partenaire_update'),
    path('partenaires/delete/<int:id>', partenaire_delete, name='partenaire_delete'),
    path('partenaires/create', partenaire_create, name='partenaire_create'),
    path('performances/<int:page>', performances, name='performances'),
    path('performances/detail/<int:id>', performance_detail, name='performance_detail'),
    path('performances/update/<int:id>', performance_update, name='performance_update'),
    path('performances/delete/<int:id>', performance_delete, name='performance_delete'),
    path('performances/create', performance_create, name='performance_create'),
    path('scenes/<int:page>', scenes, name='scenes'),
    path('scenes/detail/<int:id>', scene_detail, name='scene_detail'),
    path('scenes/update/<int:id>', scene_update, name='scene_update'),
    path('scenes/delete/<int:id>', scene_delete, name='scene_delete'),
    path('scenes/create', scene_create, name='scene_create'),
    path('news/<int:page>', news, name='news'),
    path('news/detail/<int:id>', news_detail, name='news_detail'),
    path('news/update/<int:id>', news_update, name='news_update'),
    path('news/delete/<int:id>', news_delete, name='news_delete'),
    path('news/create', news_create, name='news_create'),
    path('tags/', tags, name='tags'),
    path('tags/detail/<int:id>', tag_detail, name='tag_detail'),
    path('tags/update/<int:id>', tag_update, name='tag_update'),
    path('tags/delete/<int:id>', tag_delete, name='tag_delete'),
    path('tags/create', tag_create, name='tag_create'),
    path('parametres/',parametres, name='parametres'),
    path('rechercher_artistes/', rechercher_artistes, name='rechercher_artistes')
]