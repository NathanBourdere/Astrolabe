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
        self.assertEqual(response.data["count"],1)  # Il doit y avoir un artiste dans la base de données

    def test_retrieve_artiste(self):
        response = self.client.get(f'/festivals/v0/artistes/{self.artiste.id}/')
        self.assertEqual(response.status_code, 200)
        expected_data = ArtisteSerializer(self.artiste).data
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
        self.assertEqual(response.data["count"],1)

    def test_retrieve_performance(self):
        response = self.client.get(f'/festivals/v0/performances/{self.performance.id}/')
        self.assertEqual(response.status_code, 200)
        expected_data = PerformanceSerializer(self.performance).data
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
        self.assertEqual(response.data["count"],1)  # Il doit y avoir une scène dans la base de données

    def test_retrieve_scene(self):
        response = self.client.get(f'/festivals/v0/scenes/{self.scene.id}/')
        self.assertEqual(response.status_code, 200)
        expected_data = SceneSerializer(self.scene).data
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
        }
        self.modification = Modification.objects.create(**self.modification_data)

    def test_list_modification(self):
        response = self.client.get('/festivals/v0/modifications/')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data["count"],1)  # Il doit y avoir une modification dans la base de données

    def test_retrieve_modification(self):
        response = self.client.get(f'/festivals/v0/modifications/{self.modification.id}/')
        self.assertEqual(response.status_code, 200)
        expected_data = ModificationSerializer(self.modification).data
        self.assertEqual(response.data, expected_data)

class ConfigurationFestivalViewSetTest(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.config_data = {
            'nomFestival': 'Festival Test',
            'logoFestival': 'logo.jpg',
            'descriptionFestival': 'Description du festival test',
            'siteWebFestival': 'http://festival-test.com',
            'youtubeFestival': 'http://youtube.com/festival-test',
            'facebookFestival': 'http://facebook.com/festival-test',
            'instagramFestival': 'http://instagram.com/festival-test',
            'mentionsLegales': 'Mentions légales du festival test',
            'policeEcriture': 'Arial',
            'couleurPrincipale': '#FF0000',
            'couleurSecondaire': '#00FF00',
            'couleurBackground': '#0000FF',
            'video_promo': 'http://videopromo.com/festival-test',
        }
        self.config_festival = ConfigurationFestival.objects.create(**self.config_data)

    def test_list_config_festival(self):
        response = self.client.get('/festivals/v0/festivals/')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data["count"],1)  # Il doit y avoir une configuration de festival dans la base de données

    def test_retrieve_config_festival(self):
        response = self.client.get(f'/festivals/v0/festivals/{self.config_festival.id}/')
        self.assertEqual(response.status_code, 200)
        expected_data = ConfigurationFestivalSerializer(self.config_festival).data
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
        self.assertEqual(response.data["count"],1)  # Il doit y avoir un partenaire dans la base de données

    def test_retrieve_partenaire(self):
        response = self.client.get(f'/festivals/v0/partenaires/{self.partenaire.id}/')
        self.assertEqual(response.status_code, 200)
        expected_data = PartenaireSerializer(self.partenaire).data
        self.assertEqual(response.data, expected_data)

class NewsViewSetTest(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.news_data = {
            'titre': 'News Test',
            'corps': 'News corps',
            'image': 'image.jpg',
        }
        self.news = News.objects.create(**self.news_data)

    def test_list_news(self):
        response = self.client.get('/festivals/v0/news/')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data["count"],1)  # Il doit y avoir un partenaire dans la base de données

    def test_retrieve_partenaire(self):
        response = self.client.get(f'/festivals/v0/news/{self.news.id}/')
        self.assertEqual(response.status_code, 200)
        expected_data = NewsSerializer(self.news).data
        self.assertEqual(response.data, expected_data)


