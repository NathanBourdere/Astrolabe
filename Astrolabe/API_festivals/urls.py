from django.urls import path, include
from .views import *
from rest_framework import routers

app_name = 'API_festivals'

routers = routers.SimpleRouter()
routers.register('artistes', ArtisteViewSet, basename='artistes')
routers.register('categories', CategorieViewSet, basename='categories')
routers.register('performances', PerformanceViewSet, basename='performances')
routers.register('scenes', SceneViewSet, basename='scenes')
routers.register('festivals', ConfigurationFestivalViewSet, basename='festivals')

urlpatterns = [
    path('v0/', include(routers.urls)),
]