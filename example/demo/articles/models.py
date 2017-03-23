from django.db import models

from prosemirror.fields import ProseMirrorField


class Article(models.Model):
    title = models.CharField(max_length=128)
    slug = models.SlugField()
    abstract = models.TextField()
    body = ProseMirrorField(prosemirror_profile="maxi")

