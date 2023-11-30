from .serializers import *
from .models import *
from .forms import *
from rest_framework import viewsets
from django.shortcuts import redirect, render
import os
from django.utils import timezone

# --------------------------------------------------------------- DECORATEURS ---------------------------------------------------------------------
def configuration_required(view_func):
    def wrapped_view(request, *args, **kwargs):
        if request.method == "GET":
            configuration = ConfigurationFestival.objects.all()
            if configuration.exists():
                return view_func(request, *args, **kwargs)
            else:
                configuration_form = ConfigurationFestivalForm()
                return redirect('API_festivals:configuration')

        # Si la méthode HTTP n'est pas GET, laissez la vue originale gérer la requête.
        return view_func(request, *args, **kwargs)

    return wrapped_view

# --------------------------------------------------------------- VIEWSETS ---------------------------------------------------------------------

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
    serializer_class = PartenaireSerializer

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
    
class TagsViewSet(viewsets.ReadOnlyModelViewSet):
    serializer_class = TagsSerializer

    def get_queryset(self):
        queryset = Tag.objects.all()
        id_tag = self.request.GET.get("id")
        if id_tag :
            queryset = queryset.filter(id=id_tag)
        return queryset
    

@configuration_required
def accueil(request):  
    festival = ConfigurationFestival.objects.all().first()
    performances_par_jour = dict()
    performances_jour = Performance.objects.all().order_by('date','heure_debut')
    for perf in performances_jour:
        artistes = Artiste.objects.filter(performance=perf)
        if perf.date not in performances_par_jour.keys():
            performances_par_jour[perf.date] = [(perf,artistes[0])]
        else :
            performances_par_jour[perf.date].append((perf,artistes[0]))
    return render(request, 'accueil.html', {'nom_festival':festival.nomFestival,'performances_par_jour':performances_par_jour,'logo':festival.logoFestival})

# CONFIGURATION
def configuration(request):
    """
    Renvoyer la création s'il n'y a pas de configuration d'enregistrée dans la base de données
    Renvoyer la page de détail sinon.
    """
    if request.method == "GET":
        configuration = ConfigurationFestival.objects.all()
        print(configuration.first())
        if configuration.exists():
            config_instance = configuration.first()
            partenaires = Partenaire.objects.filter(id__in=config_instance.partenaires.all()).all()
            return render(request,'configuration/configuration_detail.html',{'configuration':config_instance,'partenaires':partenaires})
        configuration_form = ConfigurationFestivalForm()
        return render(request,'configuration/configuration_create.html',{'configuration_form':configuration_form})
    elif request.method == "POST":
        configuration_form = ConfigurationFestivalForm(request.POST, request.FILES)
        print(configuration_form.errors)
        if configuration_form.is_valid():
            configuration_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_config = timezone.now()
            modif.save()
            return redirect('API_festivals:configuration')
    configuration_form = ConfigurationFestivalForm()
    return render(request, 'configuration/configuration_create.html', {'configuration_form': configuration_form})

@configuration_required
def configuration_update(request):
    configuration = ConfigurationFestival.objects.all().first()
    chemin_logo = str(configuration.logoFestival)
    if request.method == 'POST':
        configuration_form = ConfigurationFestivalForm(request.POST, request.FILES, instance=configuration)
        if configuration_form.has_changed() and configuration_form.is_valid():
            if "logoFestival" in configuration_form.changed_data:
                os.remove(chemin_logo)
            configuration_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_config = timezone.now()
            modif.save()
            return redirect('API_festivals:configuration')
    configuration_form = ConfigurationFestivalForm(instance=configuration)
    partenaire_form =PartenaireForm()
    return render(request, 'configuration/configuration_update.html', {'form': configuration_form, 'partenaire_form':partenaire_form, 'configuration': configuration})

@configuration_required
def configuration_delete(request):
    configuration = ConfigurationFestival.objects.all().first()
    try:
        os.remove(str(configuration.logoFestival))
        os.remove(str(configuration.video_promo))
    except FileNotFoundError:
        pass
    configuration.delete()
    modif = Modification.objects.all().first()
    modif.date_modif_config = timezone.now()
    modif.save()
    return redirect("API_festivals:configuration")

# ARTISTES
@configuration_required
def artistes(request,page):
    limit = 3
    artistes = Artiste.objects.all()
    logo = ConfigurationFestival.objects.all().first().logoFestival
    form = SearchForm(request.GET)
    if form.is_valid():
        search_term = form.cleaned_data['search']
        artistes = artistes.filter(nom__icontains=search_term)
    artistes = artistes[(page-1)*limit:]
    render_right_arrow = False
    render_left_arrow = False
    # on affiche les flèches de navig pour la navigation si on a plus de 50 artistes sinon on affiche pas
    if len(Artiste.objects.all()) > limit:
        # si on est à la première page, on affiche pas la flèche de gauche
        if page != 1:
            render_left_arrow = True
        # si on est a la dernière page, donc la requête contient moins de 50 artistes, on affiche pas la flèche de droite
        if (len(artistes)) > limit:
            render_right_arrow = True
    artistes = artistes[:limit]

    return render(request, 'artistes/artistes.html',{"logo":logo,"artistes": artistes,"form":form,
     "render_right_arrow":render_right_arrow,"render_left_arrow":render_left_arrow, "page_precedente": page-1, "page_suivante": page+1})

@configuration_required
def artiste_create(request):
    logo = ConfigurationFestival.objects.all().first().logoFestival
    if request.method == 'POST':
        artiste_form = ArtisteForm(request.POST, request.FILES)
        if artiste_form.is_valid():
            nom = artiste_form.cleaned_data['nom']
            nom_lowered = nom.lower()
            if Artiste.objects.filter(nom__iexact=nom_lowered).exists():
                # Si oui, affiche un message d'erreur à l'utilisateur
                error_message = f"L'artiste '{nom_lowered}' existe déjà. Veuillez enregistrer un artiste avec un nom différent."
                return render(request, 'artistes/artiste_create.html', {'logo':logo,'form': artiste_form, 'error_message': error_message})
            artiste_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_artiste = timezone.now()
            modif.save()
            return redirect('API_festivals:artistes', page=1)
    else:
        artiste_form = ArtisteForm()
    return render(request, 'artistes/artiste_create.html', {'form': artiste_form,'logo':logo})

@configuration_required
def artiste_detail(request, id):
    logo = ConfigurationFestival.objects.all().first().logoFestival
    artiste = Artiste.objects.get(id=id)
    artistes = artiste.recommendations.all()
    template = "artistes/artiste_detail.html"
    context = {'artiste': artiste,'logo':logo,'artistes':artistes}
    return render(request, template, context)

@configuration_required
def artiste_update(request, id):
    logo = ConfigurationFestival.objects.all().first().logoFestival
    artiste = Artiste.objects.get(id=id)
    chemin_image = str(artiste.image)
    if request.method == 'POST':
        artiste_form = ArtisteForm(request.POST, request.FILES, instance=artiste)
        if artiste_form.has_changed() and artiste_form.is_valid():
            if "image" in artiste_form.changed_data:
                os.remove(chemin_image)
            artiste_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_artiste = timezone.now()
            modif.save()
            return redirect('API_festivals:artiste_detail', id=id)
    artiste_form = ArtisteForm(instance=artiste)
    return render(request, 'artistes/artiste_update.html', {'logo':logo,'form': artiste_form, 'artiste': artiste})

@configuration_required
def artiste_delete(request, id):
    artiste = Artiste.objects.get(id=id)
    perfs = Performance.objects.filter(artistes=artiste)
    confirmation = request.GET.get('confirmation',False)
    print("here")
    if confirmation:
        for perf in perfs:
            perf.delete()
    if perfs.exists():
        # If there are performances, show a confirmation message
        error_message = f"L'artiste a déjà des performances enregistrées. Voulez-vous supprimer les performances associées ?"
        logo = ConfigurationFestival.objects.first().logoFestival
        artistes = artiste.recommendations.all()
        return render(request, 'artistes/artiste_detail.html', {'logo': logo, 'artistes': artistes, 'artiste': artiste, 'error_message': error_message})
    try :
        os.remove(str(artiste.image.path)) 
    except FileNotFoundError:
        pass
    finally:
        artiste.delete()
    # Update modification date
    modif = Modification.objects.first()
    modif.date_modif_artiste = timezone.now()
    modif.save()

    return redirect("API_festivals:artistes", page=1)

# PARTENAIRES
@configuration_required
def partenaires(request,page):
    limit = 2
    logo = ConfigurationFestival.objects.all().first().logoFestival
    partenaires = Partenaire.objects.all()
    form = SearchForm(request.GET)
    if form.is_valid():
        search_term = form.cleaned_data['search']
        partenaires = partenaires.filter(nom__icontains=search_term)
    partenaires = partenaires[(page-1)*limit:]
    render_right_arrow = False
    render_left_arrow = False
    # on affiche les flèches de navig pour la navigation si on a plus de 50 artistes sinon on affiche pas
    if len(Partenaire.objects.all()) > limit:
        # si on est à la première page, on affiche pas la flèche de gauche
        if page != 1:
            render_left_arrow = True
        # si on est a la dernière page, donc la requête contient moins de 50 artistes, on affiche pas la flèche de droite
        if (len(partenaires)) > limit:
            render_right_arrow = True
    partenaires = partenaires[:limit]
    

    return render(request, 'partenaires/partenaires.html',{'logo':logo,"partenaires": partenaires,"form":form,
     "render_right_arrow":render_right_arrow,"render_left_arrow":render_left_arrow, "page_precedente": page-1, "page_suivante": page+1})

@configuration_required
def partenaire_create(request):
    logo = ConfigurationFestival.objects.all().first().logoFestival
    if request.method == 'POST':
        partenaire_form = PartenaireForm(request.POST, request.FILES)
        if partenaire_form.is_valid():
            nom = partenaire_form.cleaned_data['nom']
            nom_lowered = nom.lower()
            if Partenaire.objects.filter(nom__iexact=nom_lowered).exists():
                # Si oui, affiche un message d'erreur à l'utilisateur
                error_message = f"Le partenaire '{nom_lowered}' existe déjà. Veuillez enregistrer un partenaire avec un nom différent."
                return render(request, 'partenaires/partenaire_create.html', {'logo':logo,'form': partenaire_form, 'error_message': error_message})
            partenaire_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_partenaire = timezone.now()
            modif.save()
            return redirect('API_festivals:partenaires', page=1)
    else:
        partenaire_form = PartenaireForm()
    return render(request, 'partenaires/partenaire_create.html', {'logo':logo,'form': partenaire_form})

@configuration_required
def partenaire_detail(request, id):
    logo = ConfigurationFestival.objects.all().first().logoFestival
    partenaire = Partenaire.objects.get(id=id)
    template = "partenaires/partenaire_detail.html"
    context = {'partenaire': partenaire,'logo':logo}
    return render(request, template, context)

@configuration_required
def partenaire_update(request, id):
    logo = ConfigurationFestival.objects.all().first().logoFestival
    partenaire = Partenaire.objects.get(id=id)
    chemin_banniere = str(partenaire.banniere)
    if request.method == 'POST':
        partenaire_form = PartenaireForm(request.POST, request.FILES, instance=partenaire)
        if partenaire_form.has_changed() and partenaire_form.is_valid():
            if "banniere" in partenaire_form.changed_data:
                os.remove(chemin_banniere)
            partenaire_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_partenaire = timezone.now()
            modif.save()
            return redirect('API_festivals:partenaire_detail', id=id)
    partenaire_form = PartenaireForm(instance=partenaire)
    return render(request, 'partenaires/partenaire_update.html', {'logo':logo,'form': partenaire_form, 'partenaire': partenaire})

@configuration_required
def partenaire_delete(request, id):
    partenaire = Partenaire.objects.get(id=id)
    os.remove(str(partenaire.banniere))
    partenaire.delete()
    modif = Modification.objects.all().first()
    modif.date_modif_partenaire = timezone.now()
    modif.save()
    return redirect("API_festivals:accueil")

# PERFORMANCES
@configuration_required
def performances(request,page):
    limit = 2
    logo = ConfigurationFestival.objects.all().first().logoFestival
    performances = Performance.objects.all().order_by('date')
    form = SearchForm(request.GET)
    if form.is_valid():
        search_term = form.cleaned_data['search']
        performances = performances.filter(nom__icontains=search_term).order_by('date')
    performances = performances[(page-1)*limit:]
    render_right_arrow = False
    render_left_arrow = False
    # on affiche les flèches de navig pour la navigation si on a plus de 50 artistes sinon on affiche pas
    if len(Performance.objects.all()) > limit:
        # si on est à la première page, on affiche pas la flèche de gauche
        if page != 1:
            render_left_arrow = True
        # si on est a la dernière page, donc la requête contient moins de 50 artistes, on affiche pas la flèche de droite
        if (len(performances)) > limit:
            render_right_arrow = True
    performances = performances[:limit]
    

    return render(request, 'performances/performances.html',{'logo':logo,"performances": performances,"form":form,
     "render_right_arrow":render_right_arrow,"render_left_arrow":render_left_arrow, "page_precedente": page-1, "page_suivante": page+1})

@configuration_required
def performance_detail(request, id):
    logo = ConfigurationFestival.objects.all().first().logoFestival
    performance = Performance.objects.get(id=id)
    artistes = Artiste.objects.filter(performance=performance)
    template = "performances/performance_detail.html"
    context = {'performance': performance, 'artistes': artistes,'logo':logo}
    return render(request, template, context)

@configuration_required
def performance_update(request, id):
    logo = ConfigurationFestival.objects.all().first().logoFestival
    performance = Performance.objects.get(id=id)
    if request.method == 'POST':
        performance_form = PerformanceForm(request.POST, instance=performance)
        print(performance_form.errors)
        if performance_form.has_changed() and performance_form.is_valid():
            performance_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_performance = timezone.now()
            modif.save()
            return redirect('API_festivals:performance_detail', id=id)
    performance_form = PerformanceForm(instance=performance)
    return render(request, 'performances/performance_update.html', {'logo':logo,'form': performance_form, 'performance': performance})

@configuration_required
def performance_delete(request, id):
    performance = Performance.objects.get(id=id)
    performance.delete()
    modif = Modification.objects.all().first()
    modif.date_modif_performance = timezone.now()
    modif.save()
    return redirect("API_festivals:accueil")

@configuration_required
def performance_create(request):
    logo = ConfigurationFestival.objects.all().first().logoFestival
    if request.method == 'POST':
        performance_form = PerformanceForm(request.POST)
        if performance_form.is_valid():#
            nom = performance_form.cleaned_data['nom']
            nom_lowered = nom.lower()
            if Performance.objects.filter(nom__iexact=nom_lowered).exists():
                # Si oui, affiche un message d'erreur à l'utilisateur
                error_message = f"Le performance '{nom_lowered}' existe déjà. Veuillez enregistrer un performance avec un nom différent."
                return render(request, 'performances/performance_create.html', {'logo':logo,'form': performance_form, 'error_message': error_message})
            performance_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_performance = timezone.now()
            modif.save()
            return redirect('API_festivals:performances', page=1)
    else:
        performance_form = PerformanceForm()
    return render(request, 'performances/performance_create.html', {'logo':logo,'form': performance_form})

# SCENES
@configuration_required
def scenes(request,page):
    limit = 2
    logo = ConfigurationFestival.objects.all().first().logoFestival
    scenes = Scene.objects.all()
    form = SearchForm(request.GET)
    if form.is_valid():
        search_term = form.cleaned_data['search']
        scenes = scenes.filter(nom__icontains=search_term)
    scenes = scenes[(page-1)*limit:]
    render_right_arrow = False
    render_left_arrow = False
    # on affiche les flèches de navig pour la navigation si on a plus de 50 artistes sinon on affiche pas
    if len(Scene.objects.all()) > limit:
        # si on est à la première page, on affiche pas la flèche de gauche
        if page != 1:
            render_left_arrow = True
        # si on est a la dernière page, donc la requête contient moins de 50 artistes, on affiche pas la flèche de droite
        if (len(scenes)) > limit:
            render_right_arrow = True
    scenes = scenes[:limit]
    return render(request, 'scenes/scenes.html',{'logo':logo,"scenes": scenes,"form":form,
     "render_right_arrow":render_right_arrow,"render_left_arrow":render_left_arrow, "page_precedente": page-1, "page_suivante": page+1})

@configuration_required
def scene_detail(request, id):
    logo = ConfigurationFestival.objects.all().first().logoFestival
    scene = Scene.objects.get(id=id)
    template = "scenes/scene_detail.html"
    context = {'scene': scene,'logo':logo}
    return render(request, template, context)

@configuration_required
def scene_update(request, id):
    logo = ConfigurationFestival.objects.all().first().logoFestival
    scene = Scene.objects.get(id=id)
    scene_image = str(scene.image)
    if request.method == 'POST':
        scene_form = SceneForm(request.POST, request.FILES, instance=scene)
        if scene_form.has_changed() and scene_form.is_valid():
            if "image" in scene_form.changed_data:
                os.remove(scene_image)
            scene_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_scene = timezone.now()
            modif.save()
            return redirect('API_festivals:scene_detail', id=id)
    scene_form = SceneForm(instance=scene)
    return render(request, 'scenes/scene_update.html', {'logo':logo,'form': scene_form, 'scene': scene})

@configuration_required
def scene_delete(request, id):
    scene = Scene.objects.get(id=id)
    os.remove(str(scene.image))
    scene.delete()
    modif = Modification.objects.all().first()
    modif.date_modif_scene = timezone.now()
    modif.save()
    return redirect("API_festivals:accueil")

@configuration_required
def scene_create(request):
    logo = ConfigurationFestival.objects.all().first().logoFestival
    if request.method == 'POST':
        scene_form = SceneForm(request.POST, request.FILES)
        if scene_form.is_valid():#
            nom = scene_form.cleaned_data['nom']
            nom_lowered = nom.lower()
            if Scene.objects.filter(nom__iexact=nom_lowered).exists():
                # Si oui, affiche un message d'erreur à l'utilisateur
                error_message = f"Le scene '{nom_lowered}' existe déjà. Veuillez enregistrer un scene avec un nom différent."
                return render(request, 'scenes/scene_create.html', {'logo':logo,'form': scene_form, 'error_message': error_message})
            scene_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_scene = timezone.now()
            modif.save()
            return redirect('API_festivals:scenes', page=1)
    else:
        scene_form = SceneForm()
    return render(request, 'scenes/scene_create.html', {'logo':logo,'form': scene_form})

# NEWS
@configuration_required
def news(request,page):
    limit = 2
    logo = ConfigurationFestival.objects.all().first().logoFestival
    news = News.objects.all()
    form = SearchForm(request.GET)
    if form.is_valid():
        search_term = form.cleaned_data['search']
        news = news.filter(titre__icontains=search_term)
    news = news[(page-1)*limit:]
    render_right_arrow = False
    render_left_arrow = False
    # on affiche les flèches de navig pour la navigation si on a plus de 50 artistes sinon on affiche pas
    if len(News.objects.all()) > limit:
        # si on est à la première page, on affiche pas la flèche de gauche
        if page != 1:
            render_left_arrow = True
        # si on est a la dernière page, donc la requête contient moins de 50 artistes, on affiche pas la flèche de droite
        if (len(news)) > limit:
            render_right_arrow = True
    news = news[:limit]
    

    return render(request, 'news/news.html',{'logo':logo,"news": news,"form":form,
     "render_right_arrow":render_right_arrow,"render_left_arrow":render_left_arrow, "page_precedente": page-1, "page_suivante": page+1})

@configuration_required
def news_detail(request, id):
    logo = ConfigurationFestival.objects.all().first().logoFestival
    news = News.objects.get(id=id)
    template = "news/news_detail.html"
    context = {'news': news,'logo':logo}
    return render(request, template, context)

@configuration_required
def news_update(request, id):
    logo = ConfigurationFestival.objects.all().first().logoFestival
    news = News.objects.get(id=id)
    news_image = str(news.image)
    if request.method == 'POST':
        news_form = NewsForm(request.POST, request.FILES, instance=news)
        if news_form.has_changed() and news_form.is_valid():
            if "image" in news_form.changed_data:
                os.remove(news_image)
            news_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_news = timezone.now()
            modif.save()
            return redirect('API_festivals:news_detail', id=id)
    news_form = NewsForm(instance=news)
    return render(request, 'news/news_update.html', {'logo':logo,'form': news_form, 'news': news})

@configuration_required
def news_delete(request, id):
    news = News.objects.get(id=id)
    os.remove(str(news.image))
    news.delete()
    modif = Modification.objects.all().first()
    modif.date_modif_news = timezone.now()
    modif.save()
    return redirect("API_festivals:news", page=1)

@configuration_required
def news_create(request):
    logo = ConfigurationFestival.objects.all().first().logoFestival
    if request.method == 'POST':
        news_form = NewsForm(request.POST, request.FILES)
        if news_form.is_valid():#
            nom = news_form.cleaned_data['titre']
            nom_lowered = nom.lower()
            if News.objects.filter(titre__iexact=nom_lowered).exists():
                # Si oui, affiche un message d'erreur à l'utilisateur
                error_message = f"Le news '{nom_lowered}' existe déjà. Veuillez enregistrer un news avec un nom différent."
                return render(request, 'news/news_create.html', {'logo':logo,'form': news_form, 'error_message': error_message})
            news_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_news = date.today()
            modif.save()
            return redirect('API_festivals:news', page=1)
    else:
        news_form = NewsForm()
    return render(request, 'news/news_create.html', {'logo':logo,'form': news_form})

@configuration_required
def tags(request):
    tags = Tag.objects.all()
    logo = ConfigurationFestival.objects.all().first().logoFestival
    form = SearchForm(request.GET)
    if form.is_valid():
        search_term = form.cleaned_data['search']
        tags = tags.filter(nom__icontains=search_term)
    return render(request, 'tags/tags.html', {'tags': tags, 'logo': logo, 'form': form})
    

@configuration_required
def tag_detail(request, id):
    logo = ConfigurationFestival.objects.all().first().logoFestival
    tag = Tag.objects.get(id=id)
    performances = Performance.objects.filter(tag=tag)
    template = "tags/tag_detail.html"
    context = {'tag': tag,'logo':logo, 'performances': performances}
    return render(request, template, context)

@configuration_required
def tag_create(request):
    logo = ConfigurationFestival.objects.all().first().logoFestival
    if request.method == 'POST':
        tags_form = TagsForm(request.POST, request.FILES)
        if tags_form.is_valid():
            nom = tags_form.cleaned_data['nom']
            nom_lowered = nom.lower()
            if Tag.objects.filter(nom__iexact=nom_lowered).exists():
                # Si oui, affiche un message d'erreur à l'utilisateur
                error_message = f"Le tag '{nom_lowered}' existe déjà. Veuillez enregistrer un tag avec un nom différent."
                return render(request, 'tags/tag_create.html', {'logo':logo,'form': tags_form, 'error_message': error_message})
            tags_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_tags = date.today()
            modif.save()
            return redirect('API_festivals:tags')
    else:
        tags_form = TagsForm()
    return render(request, 'tags/tag_create.html', {'logo':logo,'form': tags_form})

@configuration_required
def tag_update(request, id):
    logo = ConfigurationFestival.objects.all().first().logoFestival
    tag = Tag.objects.get(id=id)
    if request.method == 'POST':
        tags_form = TagsForm(request.POST, request.FILES, instance=tag)
        if tags_form.has_changed() and tags_form.is_valid():
            tags_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_tags = timezone.now()
            modif.save()
            return redirect('API_festivals:tag_detail', id=id)
    tags_form = TagsForm(instance=tag)
    return render(request, 'tags/tag_update.html', {'logo':logo,'form': tags_form, 'tag': tag})

@configuration_required
def tag_delete(request, id):
    tag = Tag.objects.get(id=id)
    tag.delete()
    modif = Modification.objects.all().first()
    modif.date_modif_tags = timezone.now()
    modif.save()
    return redirect("API_festivals:tags")
