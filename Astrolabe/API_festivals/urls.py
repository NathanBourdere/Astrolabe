from django.urls import path
from .views import *

app_name = 'API_festivals'

urlpatterns = [
    path('', home, name="home"),
]