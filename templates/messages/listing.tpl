{% extends "base/index.html"%}
{% block pagetitle %}Message Index{% endblock %}
{% block titlebar %}MESSAGES{% endblock %}
{% block content %}
{% include 'tgdb/html/nav.html' ignore missing %}

<div class="pda-listing-toolbar">
  {% set vars = {
    'nbPages': message.pages,
    'currentPage': message.page,
    'url': path_for('message.index')
    }
  %}
  {% include 'components/pagination.html' with vars %}
</div>

{% for message in messages %}
  {% include 'messages/html/single.html' %}
{% endfor %}

{% include 'components/pagination.html' with vars %}
{% endblock %}
