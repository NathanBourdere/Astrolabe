# Generated by Django 4.2.3 on 2023-10-25 08:21

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('API_festivals', '0003_configurationfestival_mode'),
    ]

    operations = [
        migrations.CreateModel(
            name='News',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('titre', models.CharField(max_length=254)),
                ('corps', models.CharField(max_length=254)),
                ('image', models.CharField(max_length=254)),
            ],
        ),
    ]