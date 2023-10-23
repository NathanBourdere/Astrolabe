from django.urls import path,include
from .views import *
from rest_framework import routers

app_name = 'API_astrolabe'

router = routers.SimpleRouter()
#router.register('astrolabe', VotreVueAstrolabe)

urlpatterns = [
    path('',include(router.urls)),
]
