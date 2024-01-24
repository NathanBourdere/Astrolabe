from .models import *
from django.forms import (
    ChoiceField,
    DateField,
    DateInput,
    DateTimeField,
    DateTimeInput,
    ModelChoiceField,
    ModelForm,
    BooleanField,
    CheckboxSelectMultiple,
    CharField,
    Form,
    FileInput,
    Select,
    TimeField,
    TimeInput,
)
from Astrolabe.settings import DATE_INPUT_FORMATS
from django.utils import timezone


class ArtisteForm(ModelForm):
    class Meta:
        model = Artiste
        fields = "__all__"
        widgets = {
            "recommendations": CheckboxSelectMultiple,
            "image": FileInput,
        }

    def clean(self, *args, **kwargs):
        cleaned_data = super().clean(*args,**kwargs)
        nom = cleaned_data.get("nom")
        instance = self.instance
        if Artiste.objects.filter(nom__iexact=nom.lower()).exclude(pk=instance.pk).exists():
            self.add_error("nom", f"{nom} existe déjà dans la base de données")
        recommendations = cleaned_data.get("recommendations")
        if len(recommendations) > len(set(recommendations)):
            self.add_error(
                "recommendations", "vous recommandez plusieurs fois le même artiste"
            )
        return cleaned_data

    def __init__(self, *args, **kwargs):
        super(ArtisteForm, self).__init__(*args, **kwargs)
        self.fields["site_web"].widget.attrs["placeholder"] = "https://site-web.xyz"
        self.fields["youtube"].widget.attrs["placeholder"] = "https://youtube.xyz"
        self.fields["instagram"].widget.attrs["placeholder"] = "https://instagram.xyz"
        self.fields["facebook"].widget.attrs["placeholder"] = "https://facebook.xyz"


class PerformanceForm(ModelForm):
    class Meta:
        model = Performance
        fields = "__all__"
        widgets = {"artistes": CheckboxSelectMultiple,
                   "date": DateTimeInput(format="%d/%m/%Y"),
                   "heure_debut":TimeInput(format="HH:MM"),
                   "heure_fin":TimeInput(format="HH:MM")}

    def __init__(self, *args, **kwargs):
        super(PerformanceForm, self).__init__(*args, **kwargs)
        self.fields["date"].widget.attrs["placeholder"] = "JJ/MM/AAAA"
        self.fields["heure_debut"].widget.attrs["placeholder"] = "HH:MM"
        self.fields["heure_fin"].widget.attrs["placeholder"] = "HH:MM"

    def clean(self, *args, **kwargs):
        cleaned_data = super().clean(*args,**kwargs)
        instance = self.instance
        nom = cleaned_data.get("nom")
        if Performance.objects.filter(nom__iexact=nom.lower()).exclude(pk=instance.pk).exists():
                self.add_error("nom", f"{nom} existe déjà dans la base de données")

        date = cleaned_data.get("date")
        if date < timezone.now().date():
            self.add_error(
                "date", "Vous ne pouvez pas ajouter une performance dans le passé !"
            )

        heure_debut = cleaned_data.get("heure_debut")
        if date == timezone.now().date() and heure_debut < timezone.now().time():
            self.add_error(
                "heure_debut",
                "Vous ne pouvez pas ajouter une performance dans le passé !",
            )

        heure_fin = cleaned_data.get("heure_fin")
        if date == timezone.now().date() and heure_fin < timezone.now().time():
            self.add_error(
                "heure_fin",
                "Vous ne pouvez pas ajouter une performance dans le passé !",
            )

        artistes = cleaned_data.get("artistes")
        # on vérifie si il n'y a aucun doublon d'artistes
        if len(artistes) > len(set(artistes)):
            self.add_error(
                "artistes",
                "Vous ne pouvez pas ajouter deux fois le même artiste pour la même performance ! ",
            )

        if heure_debut.hour >= heure_fin.hour:
            self.add_error(
                "heure_fin",
                "Vous ne pouvez pas ajouter une performance qui finit avant même qu'elle ne commence !",
            )
        scene = cleaned_data.get("scene")
        perfs = Performance.objects.filter(date=date, scene=scene)
        if len(perfs) > 0:
            for perf in perfs:
                if perf.nom != cleaned_data.get("nom"):
                    # on regarde si elles se chevauchent pas
                    if (
                        not (
                            heure_debut.hour >= perf.heure_fin.hour
                            or heure_fin.hour <= perf.heure_debut.hour
                        )
                        and perf.scene == scene
                    ):
                        self.add_error(
                            "scene",
                            "La scène est déjà occupée ce jour là (veuillez changer un de ces 4 champs)",
                        )
                        self.add_error(
                            "heure_fin",
                            "La scène est déjà occupée ce jour là (veuillez changer un de ces 4 champs)",
                        )
                        self.add_error(
                            "heure_debut",
                            "La scène est déjà occupée ce jour là (veuillez changer un de ces 4 champs)",
                        )
                        self.add_error(
                            "date",
                            "La scène est déjà occupée ce jour là (veuillez changer un de ces 4 champs)",
                        )
        return cleaned_data


class SceneForm(ModelForm):
    class Meta:
        model = Scene
        fields = "__all__"
        widgets = {
            "image": FileInput,
        }

    def clean(self, *args, **kwargs):
        cleaned_data = super().clean(*args,**kwargs)
        nom = cleaned_data.get("nom")
        instance = self.instance
        if Scene.objects.filter(nom__iexact=nom.lower()).exclude(pk=instance.pk).exists():
            self.add_error("nom", f"{nom} existe déjà dans la base de données")
        return cleaned_data


class ConfigurationFestivalForm(ModelForm):
    class Meta:
        model = ConfigurationFestival
        fields = "__all__"
        widgets = {
            "logo": FileInput,
            "partenaires": CheckboxSelectMultiple,
            "video_promo": FileInput(attrs={"accept": "video/*"}),
            'date_debut': DateInput(format="%d/%m/%Y"),
            'date_fin': DateInput(format="%d/%m/%Y"),
            "artistes": CheckboxSelectMultiple,
        }
    
    def clean(self, *args, **kwargs):

        cleaned_data = super().clean(*args,**kwargs)
        date_debut= cleaned_data.get("date_debut")
        date_fin = cleaned_data.get("date_fin")
        if date_debut < timezone.now().date():
            self.add_error(
                "date_debut", "Vous ne pouvez pas ajouter une performance dans le passé !"
            )
        if date_fin < timezone.now().date():
            self.add_error(
                "date_fin", "Vous ne pouvez pas ajouter une performance dans le passé !"
            )
        if date_debut > date_fin:
            self.add_error(
                "date_debut", "La date de début ne peut pas être après la date de fin."
            )
        
            
        return cleaned_data

    def __init__(self, *args, **kwargs):
        super(ConfigurationFestivalForm, self).__init__(*args, **kwargs)
        self.fields["site_web"].widget.attrs["placeholder"] = "https://site-web.xyz"
        self.fields["youtube"].widget.attrs["placeholder"] = "https://youtube.xyz"
        self.fields["instagram"].widget.attrs["placeholder"] = "https://instagram.xyz"
        self.fields["facebook"].widget.attrs["placeholder"] = "https://facebook.xyz"
        self.fields["couleur_principale"].widget.attrs["placeholder"] = "#00AAFF"
        self.fields["couleur_secondaire"].widget.attrs["placeholder"] = "#00AAFF"
        self.fields["couleur_background"].widget.attrs["placeholder"] = "#00AAFF"
        self.fields["date_debut"].widget.attrs["placeholder"] = "JJ/MM/AAAA"
        self.fields["date_fin"].widget.attrs["placeholder"] = "JJ/MM/AAAA"


class PartenaireForm(ModelForm):
    class Meta:
        model = Partenaire
        fields = "__all__"
        widgets = {
            "banniere": FileInput,
        }

    def clean(self, *args, **kwargs):
        cleaned_data = super().clean(*args,**kwargs)
        nom = cleaned_data.get("nom")
        instance = self.instance
        if Partenaire.objects.filter(nom__iexact=nom.lower()).exclude(pk=instance.pk).exists():
            self.add_error("nom", f"{nom} existe déjà dans la base de données")
        return cleaned_data

    def __init__(self, *args, **kwargs):
        super(PartenaireForm, self).__init__(*args, **kwargs)
        self.fields["site"].widget.attrs["placeholder"] = "https://site-web.xyz"


class NewsForm(ModelForm):
    class Meta:
        model = News
        fields = "__all__"
        widgets = {
            "image": FileInput,
        }

    def __init__(self, *args, **kwargs):
        super(NewsForm, self).__init__(*args, **kwargs)
        self.fields["date"].widget.attrs["placeholder"] = "JJ/MM/AAAA HH:MM:SS"


class TagsForm(ModelForm):
    class Meta:
        model = Tag
        fields = "__all__"
        widgets = {"performances": CheckboxSelectMultiple}

    def clean(self, *args, **kwargs):
        cleaned_data = super().clean(*args,**kwargs)
        nom = cleaned_data.get("nom")
        instance = self.instance
        if Tag.objects.filter(nom__iexact=nom.lower()).exclude(pk=instance.pk).exists():
            self.add_error("nom", f"{nom} existe déjà dans la base de données")
        return cleaned_data


class TagsFilterForm(Form):
    search = CharField(label="Recherche", max_length=100, required=False)
    trier_par_tags = ModelChoiceField(
        queryset=Tag.objects.all(),
        empty_label="Trier par tag",
        widget=Select(attrs={"onchange": "this.form.submit();"}),
        required=False,
    )

    def __init__(self, *args, **kwargs):
        super(TagsFilterForm, self).__init__(*args, **kwargs)
        for visible in self.visible_fields():
            visible.field.widget.attrs["class"] = "form-control"


class SearchForm(Form):
    search = CharField(label="Recherche", max_length=100, required=False)


class BoolForm(Form):
    booleen = BooleanField(
        label="Destruction de toutes les données lors d'une suppression de la configuration (export automatique)",
        required=False,
    )
