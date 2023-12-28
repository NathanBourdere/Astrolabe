from .models import *
from django.core.serializers import serialize,deserialize
from django.http import HttpResponse
import json

def pagination(query,page,query_all,limit=50):
    query = query[(page-1)*limit:]
    render_right_arrow = False
    render_left_arrow = False
    # on affiche les flèches de navig pour la navigation si on a plus de 50 données sinon on affiche pas
    if len(query_all) > limit:
        # si on est à la première page, on affiche pas la flèche de gauche
        if page != 1:
            render_left_arrow = True
        # si on est a la dernière page, donc la requête contient moins de 50 données, on affiche pas la flèche de droite
        if (len(query)) > limit:
            render_right_arrow = True
    query = query[:limit]
    return render_left_arrow,render_right_arrow,query

def parse_json(data):
    for _, json_data in data.items():
        instances = deserialize('json', json_data)
        for instance in instances:
            instance.object.save()
            
def export_data():
    artistes = Artiste.objects.all()
    partenaires = Partenaire.objects.all()
    policeEcriture = PoliceEcriture.objects.all()
    configurationFestival = ConfigurationFestival.objects.all()
    performances = Performance.objects.all()
    tag = Tag.objects.all()
    scene = Scene.objects.all()
    modifications = Modification.objects.all()
    news = News.objects.all()   
    data_to_export = {
    "Artiste": serialize('json', artistes),
    "Partenaire": serialize('json', partenaires),
    "PoliceEcriture": serialize('json', policeEcriture),
    "ConfigurationFestival": serialize('json', configurationFestival),
    "Performance": serialize('json', performances),
    "Tag": serialize('json', tag),
    "Scene": serialize('json', scene),
    "Modification": serialize('json', modifications),
    "News": serialize('json', news),
    }   
    json_data = json.dumps(data_to_export, indent=8)    
    response = HttpResponse(json_data, content_type='application/json')
    response['Content-Disposition'] = 'attachment; filename="data.json"'    
    return response

def set_parameters(**kwargs):
    for key,value in kwargs.items():
        with open("static/data/parameters.json","r+") as jsonFile:
            data = json.load(jsonFile)
            data[key] = value
            jsonFile.seek(0)
            json.dump(data, jsonFile) 
            jsonFile.truncate()
            jsonFile.close()

def get_parameters(*args):
    for param in args:
        with open("static/data/parameters.json","r") as jsonFile:
            data = json.load(jsonFile)
            res = data[param]
            jsonFile.close()
            return res

def delete_all_data():
    Artiste.objects.all().delete()
    Performance.objects.all().delete()
    Partenaire.objects.all().delete()
    Tag.objects.all().delete()
    Scene.objects.all().delete()
    News.objects.all().delete()