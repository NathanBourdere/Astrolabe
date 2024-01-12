from collections import OrderedDict
from django.test import TestCase
from rest_framework.test import APIClient
from .models import *
from .serializers import *
class ArtisteViewSetTest(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.artiste_data = {
            'nom': 'Artiste Test',
            'description': 'Description de l\'artiste test',
            'site_web': 'http://artiste-test.com',
        }
        self.artiste = Artiste.objects.create(**self.artiste_data)

    def test_list_artiste(self):
        response = self.client.get('/festivals/v0/artistes/')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(len(response.data),1)  # Il doit y avoir un artiste dans la base de données

    def test_retrieve_artiste(self):
        response = self.client.get(f'/festivals/v0/artistes/{self.artiste.id}/')
        self.assertEqual(response.status_code, 200)
        expected_data = {
            'id': 3, 
            'recommendations': [], 
            'nom': 'Artiste Test', 
            'description': "Description de l'artiste test", 
            'site_web': 'http://artiste-test.com', 
            'youtube': None, 
            'instagram': None, 
            'facebook': None, 
            'image': 'http://testserver/static/media/artistes/default.jpg'
        }
        self.assertEqual(response.data, expected_data)

    def test_delete_artiste(self):
        response = self.client.delete(f'/festivals/v0/artistes/{self.artiste.id}/')
        self.assertEqual(response.status_code, 405)  # 405 signifie que la suppression est interdite
        self.assertEqual(Artiste.objects.count(), 1)  # Il devrait toujours y avoir un artiste dans la base de données

class PerformanceViewSetTest(TestCase):

    def setUp(self):
        self.client = APIClient()
        self.scene = Scene.objects.create(nom="Scene de test")
        self.artiste = Artiste.objects.create(nom="Artiste de test")
        self.performance_data = {
            'nom': 'Performance Test',
            'date': '2023-09-28',
            'heure_debut': '10:00:00',
            'heure_fin': '12:00:00',
            'scene': self.scene,
        }
        self.performance = Performance.objects.create(**self.performance_data)

        # Utilisez la méthode set() pour ajouter des artistes à la performance
        self.performance.artistes.set([self.artiste])

    def test_list_performance(self):
        response = self.client.get('/festivals/v0/performances/')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(len(response.data),1)

    def test_retrieve_performance(self):
        response = self.client.get(f'/festivals/v0/performances/{self.performance.id}/')
        self.assertEqual(response.status_code, 200)
        expected_data = {
            'id': 4, 
            'artistes': [OrderedDict([
                ('id', 7), 
                ('recommendations', []), 
                ('nom', 'Artiste de test'), 
                ('description', ''), 
                ('site_web', None), 
                ('youtube', None), 
                ('instagram', None), 
                ('facebook', None), 
                ('image', 'http://testserver/static/media/artistes/default.jpg')
            ])], 
            'scene': OrderedDict([
                ('id', 4), 
                ('nom', 'Scene de test'), 
                ('image', 'http://testserver/static/media/scenes/default.jpg'), 
                ('lieu', 'Astrolabe')
            ]), 
            'nom': 'Performance Test', 
            'date': '2023-09-28', 
            'heure_debut': '10:00:00', 
            'heure_fin': '12:00:00'
        }
        self.assertEqual(response.data, expected_data)

    def test_create_performance_not_allowed(self):
        # Vérifiez que la création est bloquée (devrait renvoyer un statut 405)
        response = self.client.post('/festivals/v0/performances/', data=self.performance_data)
        self.assertEqual(response.status_code, 405)

    def test_update_performance_not_allowed(self):
        # Vérifiez que la mise à jour est bloquée (devrait renvoyer un statut 405)
        response = self.client.put(f'/festivals/v0/performances/{self.performance.id}/', data=self.performance_data)
        self.assertEqual(response.status_code, 405)

    def test_delete_performance_not_allowed(self):
        # Vérifiez que la suppression est bloquée (devrait renvoyer un statut 405)
        response = self.client.delete(f'/festivals/v0/performances/{self.performance.id}/')
        self.assertEqual(response.status_code, 405)

class SceneViewSetTest(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.scene_data = {
            'nom': 'Scene Test',
        }
        self.scene = Scene.objects.create(**self.scene_data)

    def test_list_scene(self):
        response = self.client.get('/festivals/v0/scenes/')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(len(response.data),1)  # Il doit y avoir une scène dans la base de données

    def test_retrieve_scene(self):
        response = self.client.get(f'/festivals/v0/scenes/{self.scene.id}/')
        self.assertEqual(response.status_code, 200)
        expected_data = {
            'id': 7, 
            'nom': 'Scene Test', 
            'image': 'http://testserver/static/media/scenes/default.jpg', 
            'lieu': 'Astrolabe'
        }
        self.assertEqual(response.data, expected_data)

class ModificationViewSetTest(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.modification_data = {
            'date_modif_artiste': '2023-09-01',
            'date_modif_performance': '2023-09-01',
            'date_modif_scene': '2023-09-01',
            'date_modif_config': '2023-09-01',
            'date_modif_partenaire': '2023-09-01',
            'date_modif_news': '2024-01-12T17:11:19.780813+01:00', 
            'date_modif_tags': '2024-01-12T17:11:19.780813+01:00'
        }
        self.modification = Modification.objects.create(**self.modification_data)

    def test_list_modification(self):
        response = self.client.get('/festivals/v0/modifications/')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(len(response.data),1)  # Il doit y avoir une modification dans la base de données

    def test_retrieve_modification(self):
        response = self.client.get(f'/festivals/v0/modifications/{self.modification.id}/')
        self.assertEqual(response.status_code, 200)
        expected_data = {
            'id': 2, 
            'date_modif_artiste': '2023-09-01T00:00:00+02:00', 
            'date_modif_performance': '2023-09-01T00:00:00+02:00', 
            'date_modif_scene': '2023-09-01T00:00:00+02:00', 
            'date_modif_config': '2023-09-01T00:00:00+02:00', 
            'date_modif_partenaire': '2023-09-01T00:00:00+02:00', 
            'date_modif_news': '2024-01-12T17:11:19.780813+01:00', 
            'date_modif_tags': '2024-01-12T17:11:19.780813+01:00'
        }
        self.assertEqual(response.data, expected_data)

class ConfigurationFestivalViewSetTest(TestCase):
    def setUp(self):
        self.client = APIClient()
        arial = PoliceEcriture.objects.create(nom="Arial")
        self.config_data = {
            'nom': 'Festival Test',
            'description': 'Description du festival test',
            'site_web': 'http://festival-test.com',
            'youtube': 'http://youtube.com/festival-test',
            'facebook': 'http://facebook.com/festival-test',
            'instagram': 'http://instagram.com/festival-test',
            'mentions_legales': 'Mentions légales du festival test',
            'police_ecriture': arial,
            'couleur_principale': '#FF0000',
            'couleur_secondaire': '#00FF00',
            'couleur_background': '#0000FF',
        }
        self.config_festival = ConfigurationFestival.objects.create(**self.config_data)

    def test_list_config_festival(self):
        response = self.client.get('/festivals/v0/configuration/')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(len(response.data),1)  # Il doit y avoir une configuration de festival dans la base de données

    def test_retrieve_config_festival(self):
        response = self.client.get(f'/festivals/v0/configuration/{self.config_festival.id}/')
        self.assertEqual(response.status_code, 200)
        expected_data = {
            'id': 2, 
            'partenaires': [], 
            'police_ecriture': OrderedDict([
                ('id', 2), 
                ('nom', 'Arial')
            ]), 
            'nom': 'Festival Test', 
            'logo': 'http://testserver/static/media/default.jpg', 
            'description': 'Description du festival test', 
            'site_web': 'http://festival-test.com', 
            'youtube': 'http://youtube.com/festival-test', 
            'facebook': 'http://facebook.com/festival-test', 
            'instagram': 'http://instagram.com/festival-test', 
            'mentions_legales': 'Mentions légales du festival test', 
            'couleur_principale': '#FF0000', 
            'couleur_secondaire': '#00FF00', 
            'couleur_background': '#0000FF', 
            'video_promo': None, 
            'mode_festival': True
        }
        self.assertEqual(response.data, expected_data)

class PartenaireViewSetTest(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.partenaire_data = {
            'nom': 'Partenaire Test',
            'banniere': 'banniere.jpg',
            'site': 'http://partenaire-test.com',
        }
        self.partenaire = Partenaire.objects.create(**self.partenaire_data)

    def test_list_partenaire(self):
        response = self.client.get('/festivals/v0/partenaires/')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(len(response.data),1)  # Il doit y avoir un partenaire dans la base de données

    def test_retrieve_partenaire(self):
        response = self.client.get(f'/festivals/v0/partenaires/{self.partenaire.id}/')
        self.assertEqual(response.status_code, 200)
        expected_data = {
            'id': 2, 
            'nom': 'Partenaire Test', 
            'banniere': 'http://testserver/banniere.jpg', 
            'site': 'http://partenaire-test.com'
        }
        self.assertEqual(response.data, expected_data)

class NewsViewSetTest(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.news_data = {
            'titre': 'News Test',
            'corps': 'News corps',
            'image': 'image.jpg',
            'date': '2024-01-12T17:05:56.378090+01:00'
        }
        self.news = News.objects.create(**self.news_data)

    def test_list_news(self):
        response = self.client.get('/festivals/v0/news/')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(len(response.data),1)  # Il doit y avoir un partenaire dans la base de données

    def test_retrieve_partenaire(self):
        response = self.client.get(f'/festivals/v0/news/{self.news.id}/')
        self.assertEqual(response.status_code, 200)
        expected_data = {
            'id': 2, 
            'titre': 'News Test', 
            'corps': 'News corps', 
            'image': 'http://testserver/image.jpg', 
            'date': '2024-01-12T17:05:56.378090+01:00'
        }
        self.assertEqual(response.data, expected_data)


