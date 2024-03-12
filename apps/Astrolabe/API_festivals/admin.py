from django.contrib import admin
from .models import *
from django.forms import FileInput
class MyModelAdmin(admin.ModelAdmin):
    formfield_overrides = {
        models.ImageField: {'widget': FileInput },
    }