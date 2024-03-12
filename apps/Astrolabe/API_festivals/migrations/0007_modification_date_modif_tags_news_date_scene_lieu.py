# Generated by Django 4.1.12 on 2023-11-21 13:19

from django.db import migrations, models
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('API_festivals', '0006_remove_configurationfestival_mode_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='modification',
            name='date_modif_tags',
            field=models.DateTimeField(default=django.utils.timezone.now),
        ),
        migrations.AddField(
            model_name='news',
            name='date',
            field=models.DateTimeField(default=django.utils.timezone.now),
        ),
        migrations.AddField(
            model_name='scene',
            name='lieu',
            field=models.CharField(default='Astrolabe', max_length=200),
        ),
    ]