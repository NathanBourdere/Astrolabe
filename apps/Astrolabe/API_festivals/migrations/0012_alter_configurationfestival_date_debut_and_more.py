# Generated by Django 4.2.6 on 2024-01-24 12:20

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('API_festivals', '0011_alter_configurationfestival_date_debut_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='configurationfestival',
            name='date_debut',
            field=models.DateField(default=datetime.datetime(2024, 1, 24, 12, 20, 10, 546348, tzinfo=datetime.timezone.utc)),
        ),
        migrations.AlterField(
            model_name='configurationfestival',
            name='date_fin',
            field=models.DateField(default=datetime.datetime(2024, 1, 25, 12, 20, 10, 546348, tzinfo=datetime.timezone.utc)),
        ),
    ]
