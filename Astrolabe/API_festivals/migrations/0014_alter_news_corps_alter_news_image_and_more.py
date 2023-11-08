# Generated by Django 4.2.6 on 2023-11-08 09:01

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('API_festivals', '0013_alter_partenaire_banniere'),
    ]

    operations = [
        migrations.AlterField(
            model_name='news',
            name='corps',
            field=models.TextField(max_length=254),
        ),
        migrations.AlterField(
            model_name='news',
            name='image',
            field=models.ImageField(max_length=254, upload_to=''),
        ),
        migrations.AlterField(
            model_name='partenaire',
            name='banniere',
            field=models.ImageField(unique=True, upload_to='static/model/partenaires/'),
        ),
        migrations.AlterField(
            model_name='scene',
            name='image',
            field=models.ImageField(blank=True, null=True, upload_to='static/model/scenes/'),
        ),
    ]
