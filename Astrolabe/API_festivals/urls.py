from django.urls import path, include
from .views import *
from rest_framework import routers

app_name = 'API_festivals'

routers = routers.SimpleRouter()
routers.register('artistes', ArtisteViewSet, basename='artistes')
routers.register('performances', PerformanceViewSet, basename='performances')
routers.register('scenes', SceneViewSet, basename='scenes')
routers.register('festivals', ConfigurationFestivalViewSet, basename='festivals')
routers.register('partenaires', PartenaireViewSet, basename='partenaires')
routers.register('modifications', ModificationViewSet, basename='modifications')

urlpatterns = [
    path('v0/', include(routers.urls)),
    path('', accueil, name='accueil'),
    path('configuration', configuration, name='configuration'),
    path('configuration/update', configuration_update, name='configuration_update'),
    path('configuration/delete', configuration_delete, name='configuration_delete'),
    path('artistes/', artistes, name='artistes'),
    path('artistes/<int:id>/', artiste_detail, name='artiste_detail'),
    path('artistes/update/<int:id>', artiste_update, name='artiste_update'),
    path('artistes/delete/<int:id>', artiste_delete, name='artiste_delete'),
    path('artistes/create/', artiste_create, name='artiste_create'),
    path('partenaires/', partenaires, name='partenaires'),
    path('partenaires/<int:id>/', partenaire_detail, name='partenaire_detail'),
    path('partenaires/update/<int:id>', partenaire_update, name='partenaire_update'),
    path('partenaires/delete/<int:id>', partenaire_delete, name='partenaire_delete'),
    path('partenaires/create/', partenaire_create, name='partenaire_create'),
    path('performances/', performances, name='performances'),
    path('performances/<int:id>/', performance_detail, name='performance_detail'),
    path('performances/update/<int:id>', performance_update, name='performance_update'),
    path('performances/delete/<int:id>', performance_delete, name='performance_delete'),
    path('performances/create/', performance_create, name='performance_create'),
    path('scenes/', scenes, name='scenes'),
    path('scenes/<int:id>/', scene_detail, name='scene_detail'),
    path('scenes/update/<int:id>', scene_update, name='scene_update'),
    path('scenes/delete/<int:id>', scene_delete, name='scene_delete'),
    path('scenes/create/', scene_create, name='scene_create'),
    path('news/', news, name='news'),
    path('news/<int:id>/', scene_detail, name='news_detail'),
    path('news/update/<int:id>', news_update, name='news_update'),
    path('news/delete/<int:id>', news_delete, name='news_delete'),
    path('news/create/', news_create, name='news_create'),
]