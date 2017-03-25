from django.conf.urls import include, url
from django.views import generic

from articles.models import Article


urlpatterns = [
    url(r'(?P<slug>[-\w]+)/$', generic.DetailView.as_view(model=Article),
        name='article-detail'),
]
