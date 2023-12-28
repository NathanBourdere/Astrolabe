from .models import *
from django.forms import ImageField, ModelForm, CheckboxSelectMultiple,CharField,ChoiceField,CheckboxInput ,Form, MultipleChoiceField, ValidationError, FileInput,FileField,TextInput, DateField, DateInput
from django.utils import timezone

class ArtisteForm(ModelForm):
    class Meta:
        model = Artiste
        fields = '__all__'
        widgets = {
            'recommendations': CheckboxSelectMultiple
        }
    def clean(self):
        recommendations = self.cleaned_data.get('recommendations')     
        if len(recommendations) > len(set(recommendations)) :
            raise ValidationError("vous recommandez plusieurs fois le même artiste")

    def __init__(self, *args, **kwargs):
        super(ArtisteForm, self).__init__(*args, **kwargs)
        self.fields['site_web'].widget.attrs['placeholder'] = 'https://site-web.xyz'
        self.fields['youtube'].widget.attrs['placeholder'] = 'https://site-web.xyz'
        self.fields['instagram'].widget.attrs['placeholder'] = 'https://site-web.xyz'
        self.fields['facebook'].widget.attrs['placeholder'] = 'https://site-web.xyz'

class SearchForm(Form):
    search = CharField(label='Recherche', max_length=100, required=False)   

class PerformanceForm(ModelForm):
    class Meta:
        model = Performance
        fields = '__all__'
    date = DateField(widget=DateInput)

    def __init__(self, *args, **kwargs):
        super(PerformanceForm, self).__init__(*args, **kwargs)
        self.fields['date'].widget.attrs['placeholder'] = 'JJ/MM/AAAA'
        self.fields['heure_debut'].widget.attrs['placeholder'] = 'HH:MM'
        self.fields['heure_fin'].widget.attrs['placeholder'] = 'HH:MM'

    def clean(self):
        date = self.cleaned_data.get('date')
        if self.is_valid():
            if date < timezone.now().date():
                raise ValidationError("Vous ne pouvez pas ajouter une performance dans le passé !")
            
            heure_debut = self.cleaned_data.get('heure_debut').hour
            if date == timezone.now().date() and heure_debut < timezone.now().time().hour:
                raise ValidationError("Vous ne pouvez pas ajouter une performance dans le passé !")
            
            heure_fin = self.cleaned_data.get('heure_fin').hour
            if date == timezone.now().date() and heure_fin < timezone.now().time().hour:
                raise ValidationError("Vous ne pouvez pas ajouter une performance dans le passé !")
            
            artistes = self.cleaned_data.get('artistes')
            # on vérifie si il n'y a aucun doublon d'artistes
            if len(artistes) > len(set(artistes)):
                raise ValidationError("Vous ne pouvez pas ajouter deux fois le même artiste pour la même performance ! ")
            
            scene = self.cleaned_data.get('scene')
            perfs = Performance.objects.filter(date=date,scene=scene)
            if len(perfs) > 0:
                for perf in perfs:
                    # on regarde si elles se chevauchent pas
                    if not(heure_debut >= perf.heure_fin.hour or heure_fin <= perf.heure_debut.hour):
                        raise ValidationError("La scène est déjà occupée ce jour là")

class SceneForm(ModelForm):
    class Meta:
        model = Scene
        fields = '__all__'
        
    def clean(self):
        nom = self.cleaned_data.get("nom")
        query_nom = Partenaire.objects.filter(nom__iexact=nom).all()
        if len(query_nom) >=1 :
            for partenaire in query_nom:
                if partenaire.id != self.cleaned_data.get("id"):
                    raise ValidationError(f"{nom} existe déjà dans la base de données")

class ConfigurationFestivalForm(ModelForm):
    class Meta:
        model = ConfigurationFestival
        fields = '__all__'
    logo = ImageField(widget=FileInput)


class PartenaireForm(ModelForm):
    class Meta:
        model = Partenaire
        fields = '__all__'
        
    def clean(self):
        nom = self.cleaned_data.get("nom")
        query_nom = Partenaire.objects.filter(nom__iexact=nom).all()
        if len(query_nom) >=1 :
            for partenaire in query_nom:
                if partenaire.id != self.cleaned_data.get("id"):
                    raise ValidationError(f"{nom} existe déjà dans la base de données")

    def __init__(self, *args, **kwargs):
        super(PartenaireForm, self).__init__(*args, **kwargs)
        self.fields['site'].widget.attrs['placeholder'] = 'https://site-web.xyz'

class NewsForm(ModelForm):
    class Meta:
        model = News
        fields = '__all__'

    def __init__(self, *args, **kwargs):
        super(NewsForm, self).__init__(*args, **kwargs)
        self.fields['date'].widget.attrs['placeholder'] = 'JJ/MM/AAAA HH:MM:SS'

class TagsForm(ModelForm):
    class Meta:
        model = Tag
        fields = '__all__'