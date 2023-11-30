from .models import *
from django.forms import ModelForm, CharField,ChoiceField,CheckboxInput ,Form, MultipleChoiceField, ValidationError, FileInput,FileField,TextInput, DateField, DateInput
from datetime import date
from django_select2.forms import Select2MultipleWidget
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Layout, Submit, Row, Column,Fieldset,Div,Field,ButtonHolder,HTML
from django.utils import timezone

class ArtisteForm(ModelForm):
    class Meta:
        model = Artiste
        fields = '__all__'
    
    def clean(self):
        recommendations = self.cleaned_data.get('recommendations')     
        if len(recommendations) > len(set(recommendations)) :
            raise ValidationError("vous recommandez plusieurs fois le même artiste")
                

class SearchForm(Form):
    search = CharField(label='Recherche', max_length=100, required=False)   

class PerformanceForm(ModelForm):
    class Meta:
        model = Performance
        fields = '__all__'
    date = DateField(widget=DateInput)
        
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

class ConfigurationFestivalForm(ModelForm):
    class Meta:
        model = ConfigurationFestival
        fields = '__all__'

    def __init__(self, *args, **kwargs):
        super(ConfigurationFestivalForm, self).__init__(*args, **kwargs)
        self.helper = FormHelper(self)
        self.helper.form_method = 'post'
        self.helper.layout = Layout(
    Fieldset(
        '',
        'nomFestival',
        'logoFestival',
        'descriptionFestival',
        'siteWebFestival',
        'youtubeFestival',
        'facebookFestival',
        'instagramFestival',
        'mentionsLegales',
        'policeEcriture',
        'couleurPrincipale',
        'couleurSecondaire',
        'couleurBackground',
        'video_promo',
        'partenaires',
        HTML("""
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createPartnerModal">
                    Ajouter un nouveau partenaire
                </button>
                """),
        'mode_festival',
    ),
    ButtonHolder(
        Submit('submit','Confirmer', css_class='btn-primary btn-lg mx-auto mt-3'),
        css_class="text-center"
    ),
        )

class PartenaireForm(ModelForm):
    class Meta:
        model = Partenaire
        fields = '__all__'

class NewsForm(ModelForm):
    class Meta:
        model = News
        fields = '__all__'

class TagsForm(ModelForm):
    class Meta:
        model = Tag
        fields = '__all__'