import json
from .serializers import *
from .views_tools import *
from .models import *
from .forms import *
from django.shortcuts import redirect, render, get_object_or_404
import os
from datetime import date
from django.utils import timezone
from django.http import JsonResponse

# --------------------------------------------------------------- DECORATEURS ---------------------------------------------------------------------
def configuration_required(view_func):
    def wrapped_view(request, *args, **kwargs):
        if request.method == "GET":
            configuration = ConfigurationFestival.objects.all()
            if configuration.exists():
                return view_func(request, *args, **kwargs)
            else:
                return redirect('API_festivals:configuration')

        # Si la méthode HTTP n'est pas GET, laissez la vue originale gérer la requête.
        return view_func(request, *args, **kwargs)

    return wrapped_view

# --------------------------------------------------------------- CONTROLLEURS ---------------------------------------------------------------------

@configuration_required
def accueil(request):
    festival = ConfigurationFestival.objects.all().first()
    performances_par_jour = dict()
    performances_jour = Performance.objects.filter(date__gte=timezone.now()).order_by('date', 'heure_debut')
    tag_form = TagsFilterForm(request.GET)
    
    if 'tags' in request.GET:
        tag_id = request.GET.getlist('tags')[0]
        if tag_id != '-1' :
            tag = Tag.objects.get(pk=tag_id)
            performances_jour = tag.performances.filter(date__gte=timezone.now()).order_by('date')
        

    for perf in performances_jour:
        artistes = Artiste.objects.filter(performance=perf)
        if perf.date not in performances_par_jour.keys():
            performances_par_jour[perf.date] = [(perf,artistes)]
        else :
            performances_par_jour[perf.date].append((perf,artistes))
    news_par_jours = dict()
    news_jour = News.objects.filter(date__gte=timezone.now()).order_by('date')
    for news in news_jour:
        if news.date not in news_par_jours.keys():
            news_par_jours[news.date] = [news]
        else :
            news_par_jours[news.date].append(news)
    return render(request, 'accueil.html', {'tag_form':tag_form,'tag_data': Tag.objects.filter(visible=True),'nom_festival':festival.nom,'performances_par_jour':performances_par_jour,'logo':festival.logo, 'news_par_jours':news_par_jours})

# CONFIGURATION
def configuration(request):
    """
    Renvoyer la création s'il n'y a pas de configuration d'enregistrée dans la base de données
    Renvoyer la page de détail sinon.
    """
    form = ConfigurationFestivalForm()
    partenaire_form = PartenaireForm()
    artiste_form = ArtisteForm()
    if request.method == "GET":
        configuration = ConfigurationFestival.objects.all()
        if configuration.exists():
            config_instance = configuration.first()
            partenaires = Partenaire.objects.filter(id__in=config_instance.partenaires.all()).all()
            return render(request,'configuration/configuration_detail.html',{'configuration':config_instance,'partenaires':partenaires})
        return render(request,'configuration/configuration_create.html',{'form':form,'partenaire_form':partenaire_form,"artiste_form":artiste_form,})
    elif request.method == "POST":
        form = ConfigurationFestivalForm(request.POST, request.FILES)
        if form.is_valid():
            Tag.objects.all().delete()
            generer_tags_date_festival(form.cleaned_data['date_debut'],form.cleaned_data['date_fin'])
            form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_config = timezone.now()
            modif.save()
            return redirect('API_festivals:configuration')
    return render(request,'configuration/configuration_create.html',{'form':form,'partenaire_form':partenaire_form,"artiste_form":artiste_form})

@configuration_required
def configuration_update(request):
    configuration = ConfigurationFestival.objects.all().first()
    chemin_logo = str(configuration.logo)
    configuration_form = ConfigurationFestivalForm(instance=configuration)
    artistes = Artiste.objects.all()

    if request.method == 'POST':
        configuration_form = ConfigurationFestivalForm(request.POST, request.FILES, instance=configuration)
        if configuration_form.has_changed() and configuration_form.is_valid():
            if "logo" in configuration_form.changed_data:
                try :
                    os.remove(chemin_logo)
                except FileNotFoundError :
                    pass
            configuration_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_config = timezone.now()
            modif.save()
            return redirect('API_festivals:configuration')
    partenaire_form =PartenaireForm()
    artiste_form = ArtisteForm()
    return render(request, 'configuration/configuration_update.html', {
        'tag_data': Tag.objects.all(),
        'form': configuration_form, 
        'partenaire_form':partenaire_form, 
        "artiste_form":artiste_form,
        'configuration': configuration,
        'artistes': artistes
    })

@configuration_required
def configuration_delete(request):
    configuration = ConfigurationFestival.objects.all().first()
    try:
        os.remove(str(configuration.logo))
        os.remove(str(configuration.video_promo))
    except FileNotFoundError:
        pass
    if get_parameters("Delete_all_on_configuration_delete") == True:
        export_data()
        delete_all_data()
    configuration.delete()
    modif = Modification.objects.all().first()
    modif.date_modif_config = timezone.now()
    modif.save()
    return redirect("API_festivals:configuration")

# ARTISTES
@configuration_required
def artistes(request,page):
    artistes = Artiste.objects.all()
    logo = ConfigurationFestival.objects.all().first().logo
    form = SearchForm(request.GET)
    if form.is_valid():
        search_term = form.cleaned_data['search']
        artistes = artistes.filter(nom__icontains=search_term)
    render_left_arrow,render_right_arrow,artistes = pagination(artistes,page,Artiste.objects.all())
    return render(request, 'artistes/artistes.html',{"logo":logo,"artistes": artistes,"form":form,
     "render_right_arrow":render_right_arrow,"render_left_arrow":render_left_arrow, "page_precedente": page-1, "page_suivante": page+1})

@configuration_required
def artiste_create(request):
    modal = request.GET.get('modal',False)
    logo = ConfigurationFestival.objects.all().first().logo
    referer = request.META.get('HTTP_REFERER')
    if request.method == 'POST':
        artiste_form = ArtisteForm(request.POST, request.FILES)
        if artiste_form.is_valid():
            artiste_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_artiste = timezone.now()
            modif.save()
            if not modal : 
                return redirect('API_festivals:artistes', page=1)
            elif 'configuration' in referer:
                if 'update' in referer:
                    return redirect('API_festivals:configuration_update')
                elif 'create' in referer :
                    return redirect('API_festivals:configuration')
            else : 
                if 'update' in referer:
                    return redirect('API_festivals:performance_update')
                elif 'create' in referer :
                    return redirect('API_festivals:performance_create')
    else:
        artiste_form = ArtisteForm()
    return render(request, 'artistes/artiste_create.html', {'form': artiste_form,'logo':logo})

@configuration_required
def artiste_detail(request, id):
    perf_exist = False
    logo = ConfigurationFestival.objects.all().first().logo
    artiste = get_object_or_404(Artiste,id=id)
    perfs = Performance.objects.filter(artistes=artiste)
    if perfs.exists():
        perf_exist = True
    artistes = artiste.recommendations.all()
    template = "artistes/artiste_detail.html"
    context = {'artiste': artiste,'logo':logo,'artistes':artistes,'perf_exist':perf_exist}
    return render(request, template, context)

@configuration_required
def artiste_update(request, id):
    if Artiste.objects.all().exists():
        logo = ConfigurationFestival.objects.all().first().logo
        artiste = get_object_or_404(Artiste,id=id)
        chemin_image = str(artiste.image)
        artiste_form = ArtisteForm(instance=artiste)
        if request.method == 'POST':
            artiste_form = ArtisteForm(request.POST, request.FILES, instance=artiste)
            if artiste_form.has_changed() and artiste_form.is_valid():
                try : 
                    if "image" in artiste_form.changed_data:
                        os.remove(chemin_image)
                except FileNotFoundError :
                    pass
                finally :
                    artiste_form.save()
                    modif = Modification.objects.all().first()
                    modif.date_modif_artiste = timezone.now()
                    modif.save()
                    return redirect('API_festivals:artiste_detail', id=id)
        return render(request, 'artistes/artiste_update.html', {'logo':logo,'form': artiste_form, 'artiste': artiste})
    else :
        return redirect('API_festivals:artiste_create')

@configuration_required
def artiste_delete(request, id):
    artiste = get_object_or_404(Artiste,id=id)
    confirmation = request.GET.get('confirmation',False)
    perfs = Performance.objects.filter(artistes=artiste)
    if confirmation:
        for perf in perfs:
            perf.delete()
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
    logo = ConfigurationFestival.objects.all().first().logo
    partenaires = Partenaire.objects.all()
    form = SearchForm(request.GET)
    if form.is_valid():
        search_term = form.cleaned_data['search']
        partenaires = partenaires.filter(nom__icontains=search_term)
    render_left_arrow,render_right_arrow,partenaires = pagination(partenaires,page,Partenaire.objects.all())
    return render(request, 'partenaires/partenaires.html',{'logo':logo,"partenaires": partenaires,"form":form,
     "render_right_arrow":render_right_arrow,"render_left_arrow":render_left_arrow, "page_precedente": page-1, "page_suivante": page+1})

@configuration_required
def partenaire_create(request):
    if ConfigurationFestival.objects.all().exists():
        logo = ConfigurationFestival.objects.all().first().logo
    else :
        logo = None
    configuration = ConfigurationFestival.objects.all().first()
    modal = request.GET.get('modal',False)
    partenaire_form = PartenaireForm()
    if request.method == 'POST':
        partenaire_form = PartenaireForm(request.POST, request.FILES)
        if partenaire_form.is_valid():
            partenaire_form.save()
            try :
                modif = Modification.objects.all().first()
                modif.date_modif_partenaire = timezone.now()
                modif.save()
            except AttributeError :
                pass

            if not modal : 
                return redirect('API_festivals:partenaires', page=1)
            return redirect('API_festivals:configuration_update')
        
    if not modal :  
        return render(request, 'partenaires/partenaire_create.html', {'logo':logo,'form': partenaire_form})
    return redirect('API_festivals:configuration_update')
    
@configuration_required
def partenaire_detail(request, id):
    logo = ConfigurationFestival.objects.all().first().logo
    partenaire = get_object_or_404(Partenaire,id=id)
    template = "partenaires/partenaire_detail.html"
    context = {'partenaire': partenaire,'logo':logo}
    return render(request, template, context)

@configuration_required
def partenaire_update(request, id):
    logo = ConfigurationFestival.objects.all().first().logo
    partenaire = get_object_or_404(Partenaire,id=id)
    chemin_banniere = str(partenaire.banniere)
    partenaire_form = PartenaireForm(instance=partenaire)
    if request.method == 'POST':
        partenaire_form = PartenaireForm(request.POST, request.FILES, instance=partenaire)
        if partenaire_form.has_changed() and partenaire_form.is_valid():
            try : 
                if "banniere" in partenaire_form.changed_data:
                    os.remove(chemin_banniere)
            except FileNotFoundError : 
                pass
            finally : 
                partenaire_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_partenaire = timezone.now()
            modif.save()
            return redirect('API_festivals:partenaire_detail', id=id)
    return render(request, 'partenaires/partenaire_update.html', {'logo':logo,'form': partenaire_form, 'partenaire': partenaire})

@configuration_required
def partenaire_delete(request, id):
    partenaire = get_object_or_404(Partenaire,id=id)
    try :
        os.remove(str(partenaire.banniere))
    except FileNotFoundError:
        pass
    finally : 
        partenaire.delete()
    modif = Modification.objects.all().first()
    modif.date_modif_partenaire = timezone.now()
    modif.save()
    return redirect("API_festivals:partenaires",page=1)

# PERFORMANCES
@configuration_required
def performances(request, page):
    performances_artistes = dict()
    
    logo = ConfigurationFestival.objects.first().logo
    
    performances = Performance.objects.all().order_by('date')
    
    if 'tags' in request.GET:
        tag_id = request.GET.getlist('tags')[0]
        print(tag_id)
        if tag_id != '-1' :
            tag = Tag.objects.get(pk=tag_id)
            performances = tag.performances.all().order_by('date')

    
    render_left_arrow, render_right_arrow, performances = pagination(performances, page, Performance.objects.all())
    for performance in performances:
        performances_artistes[performance] = Artiste.objects.filter(performance=performance)
    
    return render(request, 'performances/performances.html', {
        'tag_data': Tag.objects.filter(visible=True),
        'logo': logo,
        'performances': performances_artistes,
        'render_right_arrow': render_right_arrow,
        'render_left_arrow': render_left_arrow,
        'page_precedente': page - 1,
        'page_suivante': page + 1,
    })

@configuration_required
def performance_detail(request, id):
    logo = ConfigurationFestival.objects.all().first().logo
    performance = get_object_or_404(Performance,id=id)
    artistes = Artiste.objects.filter(performance=performance)
    template = "performances/performance_detail.html"
    context = {'performance': performance, 'artistes': artistes,'logo':logo}
    return render(request, template, context)

@configuration_required
def performance_update(request, id):
    logo = ConfigurationFestival.objects.all().first().logo
    performance = get_object_or_404(Performance,id=id)
    performance_form = PerformanceForm(instance=performance)
    if request.method == 'POST':
        performance_form = PerformanceForm(request.POST, instance=performance)
        if performance_form.has_changed() and performance_form.is_valid():
            performance_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_performance = timezone.now()
            modif.save()
            return redirect('API_festivals:performance_detail', id=id)
    artiste_form = ArtisteForm()
    return render(request, 'performances/performance_update.html', {'artiste_form':artiste_form,'logo':logo,'form': performance_form, 'performance': performance})

@configuration_required
def performance_delete(request, id):
    performance = get_object_or_404(Performance,id=id)
    performance.delete()
    modif = Modification.objects.all().first()
    modif.date_modif_performance = timezone.now()
    modif.save()
    return redirect("API_festivals:performances",page=1)

@configuration_required
def performance_create(request):
    logo = ConfigurationFestival.objects.all().first().logo
    performance_form = PerformanceForm()
    if request.method == 'POST':
        performance_form = PerformanceForm(request.POST)
        if performance_form.is_valid():
            performance_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_performance = timezone.now()
            modif.save()
            return redirect('API_festivals:performances', page=1)
    artiste_form = ArtisteForm()
    return render(request, 'performances/performance_create.html', {'artiste_form':artiste_form,'logo':logo,'form': performance_form})

# SCENES
@configuration_required
def scenes(request,page):
    logo = ConfigurationFestival.objects.all().first().logo
    scenes = Scene.objects.all()
    form = SearchForm(request.GET)
    if form.is_valid():
        search_term = form.cleaned_data['search']
        scenes = scenes.filter(nom__icontains=search_term)
    render_left_arrow,render_right_arrow,scenes = pagination(scenes,page,Scene.objects.all())
    return render(request, 'scenes/scenes.html',{'logo':logo,"scenes": scenes,"form":form,
     "render_right_arrow":render_right_arrow,"render_left_arrow":render_left_arrow, "page_precedente": page-1, "page_suivante": page+1})

@configuration_required
def scene_detail(request, id):
    logo = ConfigurationFestival.objects.all().first().logo
    scene = get_object_or_404(Scene,id=id)
    performances = Performance.objects.filter(scene=scene)
    template = "scenes/scene_detail.html"
    context = {'scene': scene,'logo':logo, 'performances': performances}
    return render(request, template, context)

@configuration_required
def scene_update(request, id):
    logo = ConfigurationFestival.objects.all().first().logo
    scene = get_object_or_404(Scene,id=id)
    scene_image = str(scene.image)
    scene_form = SceneForm(instance=scene)
    if request.method == 'POST':
        scene_form = SceneForm(request.POST, request.FILES, instance=scene)
        if scene_form.has_changed() and scene_form.is_valid():
            try :
                if "image" in scene_form.changed_data:
                    os.remove(scene_image)
            except FileNotFoundError:
                pass
            finally :
                scene_form.save()
                modif = Modification.objects.all().first()
                modif.date_modif_scene = timezone.now()
                modif.save()
                return redirect('API_festivals:scene_detail', id=id)
    return render(request, 'scenes/scene_update.html', {'logo':logo,'form': scene_form, 'scene': scene})

@configuration_required
def scene_delete(request, id):
    scene = get_object_or_404(Scene,id=id)
    try : 
        os.remove(str(scene.image))
    except FileNotFoundError : 
        pass
    finally : 
        scene.delete()
    modif = Modification.objects.all().first()
    modif.date_modif_scene = timezone.now()
    modif.save()
    return redirect("API_festivals:scenes", page=1)

@configuration_required
def scene_create(request):
    logo = ConfigurationFestival.objects.all().first().logo
    if request.method == 'POST':
        scene_form = SceneForm(request.POST, request.FILES)
        if scene_form.is_valid():
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
    logo = ConfigurationFestival.objects.all().first().logo
    news = News.objects.all()
    form = SearchForm(request.GET)
    if form.is_valid():
        search_term = form.cleaned_data['search']
        news = news.filter(titre__icontains=search_term)
    render_left_arrow,render_right_arrow,news = pagination(news,page,News.objects.all())
    return render(request, 'news/news.html',{'logo':logo,"news": news,"form":form,
     "render_right_arrow":render_right_arrow,"render_left_arrow":render_left_arrow, "page_precedente": page-1, "page_suivante": page+1})

@configuration_required
def news_detail(request, id):
    logo = ConfigurationFestival.objects.all().first().logo
    news = get_object_or_404(News,id=id)
    template = "news/news_detail.html"
    context = {'news': news,'logo':logo}
    return render(request, template, context)

@configuration_required
def news_update(request, id):
    logo = ConfigurationFestival.objects.all().first().logo
    news = get_object_or_404(News,id=id)
    news_image = str(news.image)
    news_form = NewsForm(instance=news)
    if request.method == 'POST':
        news_form = NewsForm(request.POST, request.FILES, instance=news)
        if news_form.has_changed() and news_form.is_valid():
            try :
                if "image" in news_form.changed_data:
                    os.remove(news_image)
            except FileNotFoundError : 
                pass
            finally :
                news_form.save()
                modif = Modification.objects.all().first()
                modif.date_modif_news = timezone.now()
                modif.save()
                return redirect('API_festivals:news_detail', id=id)
    return render(request, 'news/news_update.html', {'logo':logo,'form': news_form, 'news': news})

@configuration_required
def news_delete(request, id):
    news = get_object_or_404(News,id=id)
    try : 
        os.remove(str(news.image))
    except FileNotFoundError : 
        pass
    finally : 
        news.delete()
    modif = Modification.objects.all().first()
    modif.date_modif_news = timezone.now()
    modif.save()
    return redirect("API_festivals:news", page=1)

@configuration_required
def news_create(request):
    logo = ConfigurationFestival.objects.all().first().logo
    if request.method == 'POST':
        news_form = NewsForm(request.POST, request.FILES)
        if news_form.is_valid():
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
    logo = ConfigurationFestival.objects.all().first().logo
    form = SearchForm(request.GET)
    if form.is_valid():
        search_term = form.cleaned_data['search']
        tags = tags.filter(nom__icontains=search_term)
    return render(request, 'tags/tags.html', {'tags': tags, 'logo': logo, 'form': form})
    

@configuration_required
def tag_detail(request, id):
    logo = ConfigurationFestival.objects.all().first().logo
    tag = get_object_or_404(Tag,id=id)
    performances = Performance.objects.filter(tag=tag)
    template = "tags/tag_detail.html"
    context = {'tag': tag,'logo':logo, 'performances': performances}
    return render(request, template, context)

@configuration_required
def tag_create(request):
    logo = ConfigurationFestival.objects.all().first().logo
    if request.method == 'POST':
        tags_form = TagsForm(request.POST, request.FILES)
        if tags_form.is_valid():
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
    logo = ConfigurationFestival.objects.all().first().logo
    tag = get_object_or_404(Tag,id=id)
    tags_form = TagsForm(instance=tag)
    if request.method == 'POST':
        tags_form = TagsForm(request.POST, request.FILES, instance=tag)
        if tags_form.has_changed() and tags_form.is_valid():
            tags_form.save()
            modif = Modification.objects.all().first()
            modif.date_modif_tags = timezone.now()
            modif.save()
            return redirect('API_festivals:tag_detail', id=id)
    return render(request, 'tags/tag_update.html', {'logo':logo,'form': tags_form, 'tag': tag})

@configuration_required
def tag_delete(request, id):
    tag = get_object_or_404(Tag,id=id)
    tag.delete()
    modif = Modification.objects.all().first()
    modif.date_modif_tags = timezone.now()
    modif.save()
    return redirect("API_festivals:tags")

@configuration_required
def parametres(request):
        logo = ConfigurationFestival.objects.all().first().logo
        changement = request.GET.get("changement",False)
        form = BoolForm({"booleen":get_parameters("Delete_all_on_configuration_delete")})
        if changement :
            try :
                if request.method == 'POST' and request.FILES.get('json_file'):
                    json_file = request.FILES['json_file']
                    import_data = json.loads(json_file.read())
                    parse_json(import_data)
                    return render(request,"parametres.html",{"logo":logo,"form":form})
                else:
                    return export_data()
            except Exception :
                return redirect("API_festivals:parametres")
        else :
            if request.method == 'POST':
                form = BoolForm(request.POST)
                if form.data.get("booleen") == "on":
                    set_parameters(Delete_all_on_configuration_delete=True)
                else :
                    set_parameters(Delete_all_on_configuration_delete=False)
            return render(request,"parametres.html",{"logo":logo,"form":form})

def not_found(request,exception):
    return render(request,"errors/not_found.html",status=404)

def rechercher_artistes_par_tag(request):
    tag_id = request.GET.get('tag_id', '')
    if tag_id == '-1':
        artistes = Artiste.objects.all()
        artistes_list = [{'id': artiste.id, 'nom': artiste.nom} for artiste in artistes]
        return JsonResponse({
            'artistes': artistes_list
        })
    else:
        tag_obj = Tag.objects.get(pk=tag_id)
        artistes = []
        for performance in Performance.objects.filter(tag=tag_obj):
            for artiste in Artiste.objects.filter(performance=performance):
                artistes.append(artiste)
        artistes_list = [{'id': artiste.id, 'nom': artiste.nom} for artiste in artistes]
        return JsonResponse({
            "artistes": artistes_list
        })