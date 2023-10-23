from django.urls import path
from .views import *

app_name = 'API_astrolabe'

urlpatterns = [
    path('', home, name="home"),
]