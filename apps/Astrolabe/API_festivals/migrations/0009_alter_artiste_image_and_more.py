# Generated by Django 4.2.6 on 2024-01-02 13:32

import django.core.validators
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('API_festivals', '0008_rename_couleurbackground_configurationfestival_couleur_background_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='artiste',
            name='image',
            field=models.ImageField(default='static/media/artistes/default.jpg', upload_to='static/media/artistes/'),
        ),
        migrations.AlterField(
            model_name='configurationfestival',
            name='couleur_background',
            field=models.CharField(max_length=7, validators=[django.core.validators.RegexValidator(message='La couleur doit être au format hexadécimal.', regex='^#[0-9a-fA-F]{6}$')]),
        ),
        migrations.AlterField(
            model_name='configurationfestival',
            name='couleur_principale',
            field=models.CharField(max_length=7, validators=[django.core.validators.RegexValidator(message='La couleur doit être au format hexadécimal.', regex='^#[0-9a-fA-F]{6}$')]),
        ),
        migrations.AlterField(
            model_name='configurationfestival',
            name='couleur_secondaire',
            field=models.CharField(max_length=7, validators=[django.core.validators.RegexValidator(message='La couleur doit être au format hexadécimal.', regex='^#[0-9a-fA-F]{6}$')]),
        ),
        migrations.AlterField(
            model_name='configurationfestival',
            name='logo',
            field=models.ImageField(default='static/media/default.jpg', upload_to='static/media/configuration/logo/'),
        ),
        migrations.AlterField(
            model_name='configurationfestival',
            name='video_promo',
            field=models.FileField(blank=True, null=True, upload_to='static/media/configuration/video/'),
        ),
        migrations.AlterField(
            model_name='news',
            name='image',
            field=models.ImageField(max_length=254, upload_to='static/media/news'),
        ),
        migrations.AlterField(
            model_name='partenaire',
            name='banniere',
            field=models.ImageField(unique=True, upload_to='static/media/partenaires/'),
        ),
        migrations.AlterField(
            model_name='scene',
            name='image',
            field=models.ImageField(default='static/media/scenes/default.jpg', upload_to='static/media/scenes/'),
        ),
    ]