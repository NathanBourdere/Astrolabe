import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'Astrolabe.settings')
django.setup()

from API_festivals.models import Artiste, Performance, Scene, ConfigurationFestival, Partenaire, Modification

hellfest = ConfigurationFestival()
hellfest.nomFestival = "Hellfest"
hellfest.logoFestival = "http://hellfest.fr/img/logo.png"
hellfest.descriptionFestival = """
    Le Hellfest est un festival de musique français spécialisé dans les musiques extrêmes, 
    annuellement organisé au mois de juin à Clisson en Loire-Atlantique. Il est l'un des plus 
    importants festivals de son genre en Europe et le premier en France.
"""
hellfest.siteWebFestival = "http://hellfest.fr"
hellfest.youtubeFestival = "https://www.youtube.com/user/HellfestFestival"
hellfest.facebookFestival = "https://www.facebook.com/hellfest"
hellfest.instagramFestival = "https://www.instagram.com/hellfestopenair/"
hellfest.mentionsLegales = "Hellfest est une marque déposée de Hellfest Productions."
hellfest.policeEcriture = "Arial"
hellfest.couleurPrincipale = "#000000"
hellfest.couleurSecondaire = "#FFFFFF"
hellfest.couleurBackground = "#000000"
hellfest.video_promo = "https://www.youtube.com/watch?v=VevuTQoTsSU"
hellfest.mode = "festival"
hellfest.save()

slipknot = Artiste()
slipknot.nom = "Slipknot"
slipknot.description = """
    Slipknot est un groupe de heavy metal américain, originaire de Des Moines, dans l'Iowa. 
    Formé en 1995, le groupe est actuellement composé de huit membres, ayant tous des pseudonymes : 
    Sid Wilson, Joey Jordison, Paul Gray, Chris Fehn, Jim Root, Craig Jones, Shawn Crahan et Mick Thomson.
"""
slipknot.site_web = "https://slipknot1.com/"
slipknot.youtube = "https://www.youtube.com/user/slipknot"
slipknot.instagram = "https://www.instagram.com/slipknot/"
slipknot.facebook = "https://www.facebook.com/slipknot"
slipknot.image = "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8b/Slipknot_-_Rock_am_Ring_2015-8722.jpg/330px-Slipknot_-_Rock_am_Ring_2015-8722.jpg"
slipknot.save()

behemoth = Artiste()
behemoth.nom = "Behemoth"
behemoth.description = """
    Behemoth est un groupe de blackened death metal polonais, originaire de Gdańsk. 
    Formé en 1991 par Nergal, le groupe est considéré comme l'un des plus importants de la scène metal extrême polonaise.
"""
behemoth.site_web = "https://behemoth.pl/"
behemoth.youtube = "https://www.youtube.com/user/Behemothofficial"
behemoth.instagram = "https://www.instagram.com/behemothofficial/"
behemoth.facebook = "https://www.facebook.com/behemoth"
behemoth.image = "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Behemoth_-_Rock_am_Ring_2014-8727.jpg/330px-Behemoth_-_Rock_am_Ring_2014-8727.jpg"
behemoth.save()

slayer = Artiste()
slayer.nom = "Slayer"
slayer.description = """
    Slayer est un groupe de thrash metal américain, originaire de Huntington Park, en Californie. 
    Formé en 1981 par les guitaristes Jeff Hanneman et Kerry King, le groupe connaît le succès 
    international à la fin des années 1980 et au début des années 1990. 
"""
slayer.site_web = "http://www.slayer.net/"
slayer.youtube = "https://www.youtube.com/user/slayer"
slayer.instagram = "https://www.instagram.com/slayerbandofficial/"
slayer.facebook = "https://www.facebook.com/slayer"
slayer.image = "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9e/Slayer_-_Rock_am_Ring_2014-8721.jpg/330px-Slayer_-_Rock_am_Ring_2014-8721.jpg"
slayer.save()

cannibal_corpse = Artiste()
cannibal_corpse.nom = "Cannibal Corpse"
cannibal_corpse.description = """
    Cannibal Corpse est un groupe de death metal américain, originaire de Buffalo, dans l'État de New York. 
    Il est formé en 1988 par le chanteur Chris Barnes, le guitariste Bob Rusay, le bassiste Alex Webster et le batteur Paul Mazurkiewicz. 
    Le groupe est connu pour ses paroles violentes et controversées.
"""
cannibal_corpse.site_web = "https://cannibalcorpse.net/"
cannibal_corpse.youtube = "https://www.youtube.com/user/cannibalcorpse"
cannibal_corpse.instagram = "https://www.instagram.com/cannibalcorpseofficial/"
cannibal_corpse.facebook = "https://www.facebook.com/cannibalcorpse"
cannibal_corpse.image = "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/Cannibal_Corpse_-_Rock_am_Ring_2015-8726.jpg/330px-Cannibal_Corpse_-_Rock_am_Ring_2015-8726.jpg"
cannibal_corpse.save()

kvelertak = Artiste()
kvelertak.nom = "Kvelertak"
kvelertak.description = """
    Kvelertak est un groupe de punk hardcore et de black metal norvégien, originaire de Stavanger. 
    Formé en 2007, le groupe est composé de Erlend Hjelvik, Vidar Landa, Bjarte Lund Rolland, Maciek Ofstad, Marvin Nygaard et Kjetil Gjermundrød.
"""
kvelertak.site_web = "https://www.kvelertak.com/"
kvelertak.youtube = "https://www.youtube.com/user/KvelertakOfficial"
kvelertak.instagram = "https://www.instagram.com/kvelertakofficial/"
kvelertak.facebook = "https://www.facebook.com/Kvelertak"
kvelertak.image = "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/Kvelertak_-_Rock_am_Ring_2015-8737.jpg/330px-Kvelertak_-_Rock_am_Ring_2015-8737.jpg"
kvelertak.save()

yeps = Partenaire()
yeps.nom = "Yeps"
yeps.banniere = "https://www.yeps.fr/wp-content/uploads/2019/05/logo-yeps-1.png"
yeps.site = "https://www.yeps.fr/"
yeps.save()

redbull = Partenaire()
redbull.nom = "Redbull"
redbull.banniere = "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Red_Bull_logo.svg/langfr-330px-Red_Bull_logo.svg.png"
redbull.site = "https://www.redbull.com/fr-fr/"
redbull.save()

passculture = Partenaire()
passculture.nom = "Pass Culture"
passculture.banniere = "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/Pass_Culture_Logo.png/330px-Pass_Culture_Logo.png"
passculture.site = "https://pass.culture.fr/"
passculture.save()

hellfest.partenaires.add(yeps)
hellfest.partenaires.add(redbull)
hellfest.partenaires.add(passculture)

scene1 = Scene()
scene1.nom = "Mainstage 1"
scene1.image = "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Hellfest_2017_-_Mainstage_1.jpg/330px-Hellfest_2017_-_Mainstage_1.jpg"
scene1.save()

performance1 = Performance()
performance1.nom = "Slipknot"
performance1.date = "2024-06-18"
performance1.heure_debut = "21:00:00"
performance1.heure_fin = "22:30:00"
performance1.scene = scene1
performance1.save()

performance2 = Performance()
performance2.nom = "Behemoth"
performance2.date = "2024-06-18"
performance2.heure_debut = "19:30:00"
performance2.heure_fin = "20:30:00"
performance2.scene = scene1
performance2.save()

performance3 = Performance()
performance3.nom = "Slayer"
performance3.date = "2024-06-18"
performance3.heure_debut = "18:00:00"
performance3.heure_fin = "19:00:00"
performance3.scene = scene1
performance3.save()

performance4 = Performance()
performance4.nom = "Cannibal Corpse"
performance4.date = "2024-06-19"
performance4.heure_debut = "21:00:00"
performance4.heure_fin = "22:30:00"
performance4.scene = scene1
performance4.save()

performance5 = Performance()
performance5.nom = "Kvelertak"
performance5.date = "2024-06-19"
performance5.heure_debut = "19:30:00"
performance5.heure_fin = "20:30:00"
performance5.scene = scene1
performance5.save()

modif = Modification()
modif.date_modif_artiste = "2023-10-25"
modif.date_modif_performance = "2023-10-25"
modif.date_modif_scene = "2023-10-25"
modif.date_modif_config = "2023-10-25"
modif.date_modif_partenaire = "2023-10-25"
modif.date_modif_news = "2023-10-25"
modif.save()
