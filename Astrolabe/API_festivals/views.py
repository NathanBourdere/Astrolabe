from .serializers import *
from .models import *
from rest_framework import viewsets,decorators
from django.shortcuts import redirect, render
from django.db import transaction  
from datetime import date,timedelta
from django.forms import ModelForm

# --------------------------------------------------------------- DECORATEURS ---------------------------------------------------------------------
def configuration_required(view_func):
    def wrapped_view(request, *args, **kwargs):
        if request.method == "GET":
            configuration = ConfigurationFestival.objects.all()
            if configuration.exists():
                return view_func(request, *args, **kwargs)
            else:
                configuration_form = ConfigurationFestivalForm()
                return render(request, 'configuration/configuration_create.html', {'configuration_form': configuration_form, 'nom_festival': "Ajouter le festival"})

        # Si la méthode HTTP n'est pas GET, laissez la vue originale gérer la requête.
        return view_func(request, *args, **kwargs)

    return wrapped_view

# --------------------------------------------------------------- FORMULAIRES ---------------------------------------------------------------------

class ArtisteForm(ModelForm):
    class Meta:
        model = Artiste
        fields = '__all__'

class PerformanceForm(ModelForm):
    class Meta:
        model = Performance
        fields = '__all__'

class SceneForm(ModelForm):
    class Meta:
        model = Scene
        fields = '__all__'

class ConfigurationFestivalForm(ModelForm):
    class Meta:
        model = ConfigurationFestival
        fields = '__all__'

class PartenaireForm(ModelForm):
    class Meta:
        model = Partenaire
        fields = '__all__'

class NewsForm(ModelForm):
    class Meta:
        model = News
        fields = '__all__'


class ArtisteViewSet(viewsets.ReadOnlyModelViewSet):
    serializer_class = ArtisteSerializer

    def get_queryset(self):
        queryset = Artiste.objects.all()
        id_artiste = self.request.GET.get("id")
        if id_artiste is not None:
            queryset = queryset.filter(id=id_artiste)
        return queryset

class PerformanceViewSet(viewsets.ReadOnlyModelViewSet):
    serializer_class = PerformanceSerializer

    def get_queryset(self):
        queryset =  Performance.objects.all()
        id_performance = self.request.GET.get("id")
        if id_performance is not None:
            queryset = queryset.filter(id=id_performance)
        return queryset

class SceneViewSet(viewsets.ReadOnlyModelViewSet):
    serializer_class = SceneSerializer

    def get_queryset(self):
        queryset =  Scene.objects.all()
        id_scene = self.request.GET.get("id")
        if id_scene is not None:
            queryset = queryset.filter(id=id_scene)
        return queryset

class ConfigurationFestivalViewSet(viewsets.ReadOnlyModelViewSet):
    serializer_class = ConfigurationFestivalSerializer

    def get_queryset(self):
        queryset = ConfigurationFestival.objects.all()
        id_festival = self.request.GET.get("id")
        if id_festival :
            queryset = queryset.filter(id=id_festival)
        return queryset

class PartenaireViewSet(viewsets.ReadOnlyModelViewSet):
    serializer_class = PartenaireSerializer()

    def get_queryset(self):
        queryset = Partenaire.objects.all()
        id_partenaire = self.request.GET.get("id")
        if id_partenaire :
            queryset = queryset.filter(id=id_partenaire)
        return queryset

class ModificationViewSet(viewsets.ReadOnlyModelViewSet):
    serializer_class = ModificationSerializer

    def get_queryset(self):
        queryset = Modification.objects.all()
        id_modification = self.request.GET.get("id")
        if id_modification :
            queryset = queryset.filter(id=id_modification)
        return queryset
      
class NewsViewSet(viewsets.ReadOnlyModelViewSet):
    serializer_class = NewsSerializer

    def get_queryset(self):
        queryset = News.objects.all()
        id_news = self.request.GET.get("id")
        if id_news :
            queryset = queryset.filter(id=id_news)
        return queryset

        
@configuration_required
def accueil(request):
    
    festival = ConfigurationFestival.objects.all()
    if festival.exists():
        festival = festival.first()
    else :
        configuration_form = ConfigurationFestivalForm()
        return render(request,'configuration/configuration_create.html',{'configuration_form':configuration_form})
    # liste de listes des 10 prochaines perfs du jour actuel jusqu'à la semaine prochaine
    # exemple : [[perfaujourdhui1,perfaujourdhui2],[perfdemain1,perfdemain2],...]
    performances_par_jour = []
    for i in range(7):
        date_recherchee = date.today() + timedelta(days=i)
        performances_jour = Performance.objects.filter(date=date_recherchee).order_by('-date').limit(10)
        performances_par_jour.append((date_recherchee, performances_jour))
    return render(request, 'accueil.html', {'nom_festival':festival.nomFestival,'performances_par_jour':performances_par_jour})

# CONFIGURATION
def configuration(request):
    """
    Renvoyer la création s'il n'y a pas de configuration d'enregistrée dans la base de données
    Renvoyer la page de détail sinon.
    """
    if request.method == "GET":
        configuration = ConfigurationFestival.objects.all()
        if configuration.exists():
            return render(request,'configuration/configuration_detail.html',{'configuration':configuration})
        configuration_form = ConfigurationFestivalForm()
        return render(request,'configuration/configuration_create.html',{'configuration_form':configuration_form})
    elif request.method == "POST":
        configuration_form = ConfigurationFestivalForm(request.POST)
        if configuration_form.is_valid():
            configuration_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_config = date.today()
            modif.save()
            return redirect('API_festivals:configuration_create')

@configuration_required
def configuration_update(request):
    configuration = configuration.objects.all().first()
    if request.method == 'POST':
        configuration_form = ConfigurationFestivalForm(request.POST, instance=configuration)
        if configuration_form.has_changed() and configuration_form.is_valid():
            configuration_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_config = date.today()
            modif.save()
            return redirect('API_festivals:configuration_detail', id=1)
    configuration_form = ConfigurationFestivalForm(instance=configuration)
    return render(request, 'configurations/configuration_update.html', {'form': configuration_form, 'configuration': configuration})
    
@configuration_required
def configuration_delete(request):
    configuration = ConfigurationFestival.objects.get(id=1)
    configuration.delete()
    modif = Modification.objects.all().first()
    modif.date_modif_config = date.today()
    modif.save()
    return redirect("API_festivals:configuration_create")

# ARTISTES
@configuration_required
def artistes(request,page):
    artistes = Artiste.objects.all()[page:50*page]
    return render(request, 'artistes/artistes.html',{"artistes": artistes})

@configuration_required
def artiste_create(request):
    if request.method == 'POST':
        artiste_form = ArtisteForm(request.POST)
        if artiste_form.is_valid():
            nom = artiste_form.cleaned_data['nom']
            nom_lowered = nom.lower()
            if Artiste.objects.filter(nom__iexact=nom_lowered).exists():
                # Si oui, affiche un message d'erreur à l'utilisateur
                error_message = f"L'artiste '{nom_lowered}' existe déjà. Veuillez enregistrer un artiste avec un nom différent."
                return render(request, 'artistes/artiste_create.html', {'form': artiste_form, 'error_message': error_message})
            artiste_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_artiste = date.today()
            modif.save()
            return redirect('API_festivals:artiste_create')
    else:
        artiste_form = ArtisteForm()
    return render(request, 'artistes/artiste_create.html', {'form': artiste_form})

@configuration_required
def artiste_detail(request, id):
    artiste = artiste.objects.get(id=id)
    template = "artistes/artiste_detail.html"
    context = {'artiste': artiste}
    return render(request, template, context)

@configuration_required
def artiste_update(request, id):
    artiste = artiste.objects.get(id=id)
    if request.method == 'POST':
        artiste_form = ArtisteForm(request.POST, instance=artiste)
        if artiste_form.has_changed() and artiste_form.is_valid():
            artiste_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_artiste = date.today()
            modif.save()
            return redirect('API_festivals:artiste_detail', id=id)
        else:
            artiste_form = ArtisteForm(instance=artiste)
            return render(request, 'artistes/artiste_update.html', {'form': artiste_form, 'artiste': artiste})
    else:
        artiste_form = ArtisteForm(instance=artiste)
        return render(request, 'artistes/artiste_update.html', {'form': artiste_form, 'artiste': artiste})

@configuration_required
def artiste_delete(request, id):
    artiste = artiste.objects.get(id=id)
    artiste.delete()
    modif = Modification.objects.all().first()
    modif.date_modif_artiste = date.today()
    modif.save()
    return redirect("API_festivals:accueil")

# PARTENAIRES
@configuration_required
def partenaires(request,page):
    partenaires = Partenaire.objects.all()[page:50*page]
    return render(request, 'partenaires/partenaires.html',{"partenaires":partenaires})#

@configuration_required
def partenaire_create(request):
    if request.method == 'POST':
        partenaire_form = PartenaireForm(request.POST)
        if partenaire_form.is_valid():#
            nom = partenaire_form.cleaned_data['nom']
            nom_lowered = nom.lower()
            if Partenaire.objects.filter(nom__iexact=nom_lowered).exists():
                # Si oui, affiche un message d'erreur à l'utilisateur
                error_message = f"Le partenaire '{nom_lowered}' existe déjà. Veuillez enregistrer un partenaire avec un nom différent."
                return render(request, 'partenaires/partenaire_create.html', {'form': partenaire_form, 'error_message': error_message})
            partenaire_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_partenaire = date.today()
            modif.save()
            return redirect('API_festivals:partenaire_create')
    else:
        partenaire_form = PartenaireForm()
    return render(request, 'partenaires/partenaire_create.html', {'form': partenaire_form})

@configuration_required
def partenaire_detail(request, id):
    partenaire = Partenaire.objects.get(id=id)
    template = "partenaires/partenaire_detail.html"
    context = {'partenaire': partenaire}
    return render(request, template, context)

@configuration_required
def partenaire_update(request, id):
    partenaire = partenaire.objects.get(id=id)
    if request.method == 'POST':
        partenaire_form = PartenaireForm(request.POST, instance=partenaire)
        if partenaire_form.has_changed() and partenaire_form.is_valid():
            partenaire_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_partenaire = date.today()
            modif.save()
            return redirect('API_festivals:partenaire_detail', id=id)
    partenaire_form = PartenaireForm(instance=partenaire)
    return render(request, 'partenaires/partenaire_update.html', {'form': partenaire_form, 'partenaire': partenaire})

@configuration_required
def partenaire_delete(request, id):
    partenaire = partenaire.objects.get(id=id)
    partenaire.delete()
    modif = Modification.objects.all().first()
    modif.date_modif_partenaire = date.today()
    modif.save()
    return redirect("API_festivals:accueil")

# PERFORMANCES
@configuration_required
def performances(request,page):
    performances = Performance.objects.all()[page:50*page]
    return render(request, 'performances/performances.html',{"performances": performances})

@configuration_required
def performance_detail(request, id):
    performance = Performance.objects.get(id=id)
    template = "performances/performance_detail.html"
    context = {'performance': performance}
    return render(request, template, context)

@configuration_required
def performance_update(request, id):
    performance = Performance.objects.get(id=id)
    if request.method == 'POST':
        performance_form = PerformanceForm(request.POST, instance=performance)
        if performance_form.has_changed() and performance_form.is_valid():
            performance_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_performance = date.today()
            modif.save()
            return redirect('API_festivals:performance_detail', id=id)
    performance_form = PerformanceForm(instance=performance)
    return render(request, 'performances/performance_update.html', {'form': performance_form, 'performance': performance})

@configuration_required
def performance_delete(request, id):
    performance = Performance.objects.get(id=id)
    performance.delete()
    modif = Modification.objects.all().first()
    modif.date_modif_performance = date.today()
    modif.save()
    return redirect("API_festivals:accueil")

@configuration_required
def performance_create(request):
    if request.method == 'POST':
        performance_form = PerformanceForm(request.POST)
        if performance_form.is_valid():#
            nom = performance_form.cleaned_data['nom']
            nom_lowered = nom.lower()
            if Performance.objects.filter(nom__iexact=nom_lowered).exists():
                # Si oui, affiche un message d'erreur à l'utilisateur
                error_message = f"Le performance '{nom_lowered}' existe déjà. Veuillez enregistrer un performance avec un nom différent."
                return render(request, 'performances/performance_create.html', {'form': performance_form, 'error_message': error_message})
            performance_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_performance = date.today()
            modif.save()
            return redirect('API_festivals:performance_create')
    else:
        performance_form = PerformanceForm()
    return render(request, 'performances/performance_create.html', {'form': performance_form})

# SCENES
@configuration_required
def scenes(request,page):
    scenes = Scene.objects.all()[page:50*page]
    return render(request, 'scenes/scenes.html',{"scenes": scenes})

@configuration_required
def scene_detail(request, id):
    scene = scene.objects.get(id=id)
    template = "scenes/scene_detail.html"
    context = {'scene': scene}
    return render(request, template, context)

@configuration_required
def scene_update(request, id):
    scene = Scene.objects.get(id=id)
    if request.method == 'POST':
        scene_form = SceneForm(request.POST, instance=scene)
        if scene_form.has_changed() and scene_form.is_valid():
            scene_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_scene = date.today()
            modif.save()
            return redirect('API_festivals:scene_detail', id=id)
    scene_form = SceneForm(instance=scene)
    return render(request, 'scenes/scene_update.html', {'form': scene_form, 'scene': scene})

@configuration_required
def scene_delete(request, id):
    scene = Scene.objects.get(id=id)
    scene.delete()
    modif = Modification.objects.all().first()
    modif.date_modif_scene = date.today()
    modif.save()
    return redirect("API_festivals:accueil")

@configuration_required
def scene_create(request):
    if request.method == 'POST':
        scene_form = SceneForm(request.POST)
        if scene_form.is_valid():#
            nom = scene_form.cleaned_data['nom']
            nom_lowered = nom.lower()
            if Scene.objects.filter(nom__iexact=nom_lowered).exists():
                # Si oui, affiche un message d'erreur à l'utilisateur
                error_message = f"Le scene '{nom_lowered}' existe déjà. Veuillez enregistrer un scene avec un nom différent."
                return render(request, 'scenes/scene_create.html', {'form': scene_form, 'error_message': error_message})
            scene_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_scene = date.today()
            modif.save()
            return redirect('API_festivals:scene_create')
    else:
        scene_form = SceneForm()
    return render(request, 'scenes/scene_create.html', {'form': scene_form})

# NEWS
@configuration_required
def news(request,page):
    news = news.objects.all()[page:50*page]
    return render(request, 'news/news.html',{"news": news})

@configuration_required
def news_detail(request, id):
    news = news.objects.get(id=id)
    template = "news/news_detail.html"
    context = {'news': news}
    return render(request, template, context)

@configuration_required
def news_update(request, id):
    news = news.objects.get(id=id)
    if request.method == 'POST':
        news_form = NewsForm(request.POST, instance=news)
        if news_form.has_changed() and news_form.is_valid():
            news_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_news = date.today()
            modif.save()
            return redirect('API_festivals:news_detail', id=id)
    news_form = NewsForm(instance=news)
    return render(request, 'news/news_update.html', {'form': news_form, 'news': news})

@configuration_required
def news_delete(request, id):
    news = News.objects.get(id=id)
    news.delete()
    modif = Modification.objects.all().first()
    modif.date_modif_news = date.today()
    modif.save()
    return redirect("API_festivals:accueil")

@configuration_required
def news_create(request):
    if request.method == 'POST':
        news_form = NewsForm(request.POST)
        if news_form.is_valid():#
            nom = news_form.cleaned_data['titre']
            nom_lowered = nom.lower()
            if News.objects.filter(titre__iexact=nom_lowered).exists():
                # Si oui, affiche un message d'erreur à l'utilisateur
                error_message = f"Le news '{nom_lowered}' existe déjà. Veuillez enregistrer un news avec un nom différent."
                return render(request, 'news/news_create.html', {'form': news_form, 'error_message': error_message})
            news_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_news = date.today()
            modif.save()
            return redirect('API_festivals:news_create')
    else:
        news_form = NewsForm()
    return render(request, 'news/news_create.html', {'form': news_form})

