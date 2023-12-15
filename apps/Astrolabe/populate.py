import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'Astrolabe.settings')
django.setup()

from API_festivals.models import *

hellfest = ConfigurationFestival()
hellfest.nomFestival = "Hellfest"
hellfest.logoFestival = "static/model/configuration/logo/hellfest.png"
hellfest.descriptionFestival = "Le Hellfest est un festival de musique français spécialisé dans les musiques extrêmes, annuellement organisé au mois de juin à Clisson en Loire-Atlantique. Il est l'un des plus importants festivals de son genre en Europe et le premier en France."
hellfest.siteWebFestival = "http://hellfest.fr"
hellfest.youtubeFestival = "https://www.youtube.com/user/HellfestFestival"
hellfest.facebookFestival = "https://www.facebook.com/hellfest"
hellfest.instagramFestival = "https://www.instagram.com/hellfestopenair/"
hellfest.mentionsLegales = "Hellfest est une marque déposée de Hellfest Productions."
hellfest.couleurPrincipale = "#000000"
hellfest.couleurSecondaire = "#FF00FF"
hellfest.couleurBackground = "#FF0000"
hellfest.video_promo = "static/model/configuration/video/HELLFEST 2024.mp4"
hellfest.mode = True

arial = PoliceEcriture()
arial.nom = "Roboto"
arial.save()

hellfest.policeEcriture = arial
hellfest.save()

open_sans = PoliceEcriture()
open_sans.nom = "Open Sans"
open_sans.save()

lato = PoliceEcriture()
lato.nom = "Lato"
lato.save()

monserrat = PoliceEcriture()
monserrat.nom = "Montserrat"
monserrat.save()

poppins = PoliceEcriture()
poppins.nom = "Poppins"
poppins.save()

noto_sans = PoliceEcriture()
noto_sans.nom = "Noto Sans"
noto_sans.save()

source_sans_pro = PoliceEcriture()
source_sans_pro.nom = "Source Sans Pro"
source_sans_pro.save()

merriweather = PoliceEcriture()
merriweather.nom = "Merriweather"
merriweather.save()

crimson_text = PoliceEcriture()
crimson_text.nom = "Crimson Text"
crimson_text.save()

raleway = PoliceEcriture()
raleway.nom = "Raleway"
raleway.save()

playfair_display = PoliceEcriture()
playfair_display.nom = "Playfair Display"
playfair_display.save()

ubuntu = PoliceEcriture()
ubuntu.nom = "Ubuntu"
ubuntu.save()

cabin = PoliceEcriture()
cabin.nom = "Cabin"
cabin.save()

incosolata = PoliceEcriture()
incosolata.nom = "Incosolata"
incosolata.save()

quick_sand = PoliceEcriture()
quick_sand.nom = "Quicksand"
quick_sand.save()

droit_sans = PoliceEcriture()
droit_sans.nom = "Droit Sans"
droit_sans.save()

fira_sans = PoliceEcriture()
fira_sans.nom = "Fira Sans"
fira_sans.save()

pacifico = PoliceEcriture()
pacifico.nom = "Pacifico"
pacifico.save()

arimo = PoliceEcriture()
arimo.nom = "Arimo"
arimo.save()

cormorrant_garamond = PoliceEcriture()
cormorrant_garamond.nom = "Cormorant Garamond"
cormorrant_garamond.save()

batards = Artiste()
batards.nom = "Les Bâtards du Roi"
batards.description = """
Groupe orléanais de melodic black metal, au thème médiéval
"""
batards.youtube = "https://www.youtube.com/@lesbatardsduroi"
batards.facebook = "https://www.facebook.com/profile.php?id=100083761466407"
batards.instagram = "https://www.instagram.com/lesbatardsduroi/"
batards.image = "static/model/artistes/les_batards_du_roi.png"
batards.save()

slipknot = Artiste()
slipknot.nom = "Slipknot"
slipknot.description = "Slipknot est un groupe de heavy metal américain, originaire de Des Moines, dans l'Iowa. Formé en 1995, le groupe est actuellement composé de huit membres, ayant tous des pseudonymes : Sid Wilson, Joey Jordison, Paul Gray, Chris Fehn, Jim Root, Craig Jones, Shawn Crahan et Mick Thomson."
slipknot.site_web = "https://slipknot1.com/"
slipknot.youtube = "https://www.youtube.com/user/slipknot"
slipknot.instagram = "https://www.instagram.com/slipknot/"
slipknot.facebook = "https://www.facebook.com/slipknot"
slipknot.image = "static/model/artistes/slipknot.jpg"
slipknot.save()

behemoth = Artiste()
behemoth.nom = "Behemoth"
behemoth.description = "Behemoth est un groupe de blackened death metal polonais, originaire de Gdansk. Formé en 1991 par Nergal, le groupe est considéré comme l'un des plus importants de la scène metal extrême polonaise."
behemoth.site_web = "https://behemoth.pl/"
behemoth.youtube = "https://www.youtube.com/user/Behemothofficial"
behemoth.instagram = "https://www.instagram.com/behemothofficial/"
behemoth.facebook = "https://www.facebook.com/behemoth"
behemoth.image = "static/model/artistes/behemoth.jpg"
behemoth.save()

slayer = Artiste()
slayer.nom = "Slayer"
slayer.description = "Slayer est un groupe de thrash metal américain, originaire de Huntington Park, en Californie. Formé en 1981 par les guitaristes Jeff Hanneman et Kerry King, le groupe connaît le succès international à la fin des années 1980 et au début des années 1990."
slayer.site_web = "http://www.slayer.net/"
slayer.youtube = "https://www.youtube.com/user/slayer"
slayer.instagram = "https://www.instagram.com/slayerbandofficial/"
slayer.facebook = "https://www.facebook.com/slayer"
slayer.image = "static/model/artistes/slayer.jpg"
slayer.save()

cannibal_corpse = Artiste()
cannibal_corpse.nom = "Cannibal Corpse"
cannibal_corpse.description = "Cannibal Corpse est un groupe de death metal américain, originaire de Buffalo, dans l'État de New York. Il est formé en 1988 par le chanteur Chris Barnes, le guitariste Bob Rusay, le bassiste Alex Webster et le batteur Paul Mazurkiewicz. Le groupe est connu pour ses paroles violentes et controversées."
cannibal_corpse.site_web = "https://cannibalcorpse.net/"
cannibal_corpse.youtube = "https://www.youtube.com/user/cannibalcorpse"
cannibal_corpse.instagram = "https://www.instagram.com/cannibalcorpseofficial/"
cannibal_corpse.facebook = "https://www.facebook.com/cannibalcorpse"
cannibal_corpse.image = "static/model/artistes/cannibal corpse.jpg"
cannibal_corpse.save()

kvelertak = Artiste()
kvelertak.nom = "Kvelertak"
kvelertak.description = "Kvelertak est un groupe de punk hardcore et de black metal norvégien, originaire de Stavanger. Formé en 2007, le groupe est composé de Erlend Hjelvik, Vidar Landa, Bjarte Lund Rolland, Maciek Ofstad, Marvin Nygaard et Kjetil Gjermundrød."
kvelertak.site_web = "https://www.kvelertak.com/"
kvelertak.youtube = "https://www.youtube.com/user/KvelertakOfficial"
kvelertak.instagram = "https://www.instagram.com/kvelertakofficial/"
kvelertak.facebook = "https://www.facebook.com/Kvelertak"
kvelertak.image = "static/model/artistes/kvelertak.jpg"
kvelertak.save()

slipknot.recommendations.add(batards,slayer)
behemoth.recommendations.add(slipknot,batards)
cannibal_corpse.recommendations.add(kvelertak,batards)
slayer.recommendations.add(slipknot,batards)
kvelertak.recommendations.add(slayer,cannibal_corpse)
batards.recommendations.add(slipknot,slayer)

yeps = Partenaire()
yeps.nom = "Yeps"
yeps.banniere = "static/model/partenaires/yeps.png"
yeps.site = "https://www.yeps.fr/"
yeps.save()

redbull = Partenaire()
redbull.nom = "Redbull"
redbull.banniere = "static/model/partenaires/redbull.jpg"
redbull.site = "https://www.redbull.com/fr-fr/"
redbull.save()

passculture = Partenaire()
passculture.nom = "Pass Culture"
passculture.banniere = "static/model/partenaires/pass culture.png"
passculture.site = "https://pass.culture.fr/"
passculture.save()

hellfest.partenaires.add(yeps)
hellfest.partenaires.add(redbull)
hellfest.partenaires.add(passculture)

scene1 = Scene()
scene1.nom = "Mainstage 1"
scene1.image = "static/model/scenes/scene1.png"
scene1.lieu = "Astrolabe"
scene1.save()

performance0 = Performance()
performance0.nom = "Les Bâtards Du Roi"
performance0.date = "2024-06-18"
performance0.heure_debut = "11:00:00"
performance0.heure_fin = "13:00:00"
performance0.scene = scene1
performance0.save()
performance0.artistes.add(batards)

performance1 = Performance()
performance1.nom = "Slipknot"
performance1.date = "2024-06-18"
performance1.heure_debut = "21:00:00"
performance1.heure_fin = "22:30:00"
performance1.scene = scene1
performance1.save()
performance1.artistes.add(slipknot)


performance2 = Performance()
performance2.nom = "Behemoth"
performance2.date = "2024-06-18"
performance2.heure_debut = "19:30:00"
performance2.heure_fin = "20:30:00"
performance2.scene = scene1
performance2.save()
performance2.artistes.add(behemoth)


performance3 = Performance()
performance3.nom = "Slayer"
performance3.date = "2024-06-18"
performance3.heure_debut = "18:00:00"
performance3.heure_fin = "19:00:00"
performance3.scene = scene1
performance3.save()
performance3.artistes.add(slayer)


performance4 = Performance()
performance4.nom = "Cannibal Corpse"
performance4.date = "2024-06-19"
performance4.heure_debut = "21:00:00"
performance4.heure_fin = "22:30:00"
performance4.scene = scene1
performance4.save()
performance4.artistes.add(cannibal_corpse)


performance5 = Performance()
performance5.nom = "Kvelertak"
performance5.date = "2024-06-19"
performance5.heure_debut = "19:30:00"
performance5.heure_fin = "20:30:00"
performance5.scene = scene1
performance5.save()
performance5.artistes.add(kvelertak)

metal = Tag()
metal.nom = "Metal"
metal.visible = True
metal.save()
metal.performances.add(performance0,performance1,performance2,performance3,performance4,performance5)


modif = Modification()
modif.save()

news = News()
news.titre = "Le hellfest va sûrement battre ses records d'audiences en 2024"
news.corps = "Le hellfest, grand festival de hardrock et métal, va sûrement battre ses records d'audiences en 2024, s'expliquant par le fait qu'elle accueille des groupes plus connus"
news.image = "static/model/news/news1.png"
news.save()

