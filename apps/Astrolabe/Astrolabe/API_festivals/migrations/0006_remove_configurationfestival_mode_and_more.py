# Generated by Django 4.1.12 on 2023-11-16 15:14

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('API_festivals', '0005_auto_20231108_1701'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='configurationfestival',
            name='mode',
        ),
        migrations.AddField(
            model_name='configurationfestival',
            name='mode_festival',
            field=models.BooleanField(default=True),
        ),
        migrations.CreateModel(
            name='Tag',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('visible', models.BooleanField(default=True)),
                ('nom', models.CharField(max_length=50)),
                ('performances', models.ManyToManyField(to='API_festivals.performance')),
            ],
        ),
    ]
