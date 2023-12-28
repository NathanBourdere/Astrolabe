from .models import *
from django.forms import ImageField, ModelForm, BooleanField,CheckboxSelectMultiple,CharField,ChoiceField,CheckboxInput ,Form, MultipleChoiceField, ValidationError, FileInput,FileField,TextInput, DateField, DateInput
from django.utils import timezone

class ArtisteForm(ModelForm):
    class Meta:
        model = Artiste
        fields = '__all__'
        widgets = {
            'recommendations': CheckboxSelectMultiple,
            'image' : FileInput,
        }
    def clean(self):
        recommendations = self.cleaned_data.get('recommendations')     
        if len(recommendations) > len(set(recommendations)) :
            self.add_error("recommendations","vous recommandez plusieurs fois le même artiste")

    def __init__(self, *args, **kwargs):
        super(ArtisteForm, self).__init__(*args, **kwargs)
        self.fields['site_web'].widget.attrs['placeholder'] = 'https://site-web.xyz'
        self.fields['youtube'].widget.attrs['placeholder'] = 'https://site-web.xyz'
        self.fields['instagram'].widget.attrs['placeholder'] = 'https://site-web.xyz'
        self.fields['facebook'].widget.attrs['placeholder'] = 'https://site-web.xyz'

class SearchForm(Form):
    search = CharField(label='Recherche', max_length=100, required=False)   

class BoolForm(Form):
    booleen = BooleanField(label="Destruction de toutes les données lors d'une suppression de la configuration (export automatique)",required=False)

class PerformanceForm(ModelForm):
    class Meta:
        model = Performance
        fields = '__all__'
        widgets = {
            'artistes': CheckboxSelectMultiple
        }

    def __init__(self, *args, **kwargs):
        super(PerformanceForm, self).__init__(*args, **kwargs)
        self.fields['date'].widget.attrs['placeholder'] = 'JJ/MM/AAAA'
        self.fields['heure_debut'].widget.attrs['placeholder'] = 'HH:MM'
        self.fields['heure_fin'].widget.attrs['placeholder'] = 'HH:MM'

    def clean(self, *args, **kwargs):
        date = self.cleaned_data.get('date')
        if date < timezone.now().date():
            self.add_error("date","Vous ne pouvez pas ajouter une performance dans le passé !")
        
        heure_debut = self.cleaned_data.get('heure_debut')
        if date == timezone.now().date() and heure_debut < timezone.now().time():
            self.add_error("heure_debut","Vous ne pouvez pas ajouter une performance dans le passé !")
        
        heure_fin = self.cleaned_data.get('heure_fin')
        if date == timezone.now().date() and heure_fin < timezone.now().time():
            self.add_error("heure_fin","Vous ne pouvez pas ajouter une performance dans le passé !")
        
        artistes = self.cleaned_data.get('artistes')
        # on vérifie si il n'y a aucun doublon d'artistes
        if len(artistes) > len(set(artistes)):
            self.add_error("artistes","Vous ne pouvez pas ajouter deux fois le même artiste pour la même performance ! ")
        
        if heure_debut.hour >= heure_fin.hour : 
            self.add_error("heure_fin","Vous ne pouvez pas ajouter une performance qui finit avant même qu'elle ne commence !")
        scene = self.cleaned_data.get('scene')
        perfs = Performance.objects.filter(date=date,scene=scene)
        if len(perfs) > 0:
            for perf in perfs:
                if perf.nom != self.cleaned_data.get("nom"):
                # on regarde si elles se chevauchent pas
                    print(self.cleaned_data.get("scene"))
                    if not(heure_debut.hour >= perf.heure_fin.hour or heure_fin.hour <= perf.heure_debut.hour) and perf.scene == scene :
                        self.add_error("scene","La scène est déjà occupée ce jour là (veuillez changer un de ces 4 champs)")
                        self.add_error("heure_fin","La scène est déjà occupée ce jour là (veuillez changer un de ces 4 champs)")
                        self.add_error("heure_debut","La scène est déjà occupée ce jour là (veuillez changer un de ces 4 champs)")
                        self.add_error("date","La scène est déjà occupée ce jour là (veuillez changer un de ces 4 champs)")
        return super().clean(*args, **kwargs)
            


class SceneForm(ModelForm):
    class Meta:
        model = Scene
        fields = '__all__'
        widgets = {
            'image' : FileInput,
        }
        
    def clean(self):
        nom = self.cleaned_data.get("nom")
        if Scene.objects.filter(nom__iexact=nom.lower()).all():
            self.add_error("nom",f"{nom} existe déjà dans la base de données")

class ConfigurationFestivalForm(ModelForm):
    class Meta:
        model = ConfigurationFestival
        fields = '__all__'
        widgets = {
            'logo' : FileInput,
            'partenaires' : CheckboxSelectMultiple,
            'video_promo' : FileInput
        }

class PartenaireForm(ModelForm):
    class Meta:
        model = Partenaire
        fields = '__all__'
        widgets = {
            'banniere' : FileInput,
        }
        
    def clean(self):
        nom = self.cleaned_data.get("nom")
        if Partenaire.objects.filter(nom__iexact=nom.lower()).exists() :
                self.add_error("nom",f"{nom} existe déjà dans la base de données")

    def __init__(self, *args, **kwargs):
        super(PartenaireForm, self).__init__(*args, **kwargs)
        self.fields['site'].widget.attrs['placeholder'] = 'https://site-web.xyz'

class NewsForm(ModelForm):
    class Meta:
        model = News
        fields = '__all__'
        widgets = {
            'image' : FileInput,
        }

    def __init__(self, *args, **kwargs):
        super(NewsForm, self).__init__(*args, **kwargs)
        self.fields['date'].widget.attrs['placeholder'] = 'JJ/MM/AAAA HH:MM:SS'

class TagsForm(ModelForm):
    class Meta:
        model = Tag
        fields = '__all__'
        widgets = {
            'performances' : CheckboxSelectMultiple
        }