{% extends "base/index.html"%}
{% block pagetitle %}Messages for {{player.ckey}}{% endblock %}
{% block titlebar %}MESSAGES / {{player.ckey|upper}}{% endblock %}
{% block content %}
<h2>Messages for <code>{{player.ckey}}</code></h2>

<div class="pda-listing-toolbar">
  {% set vars = {
    'nbPages': message.pages,
    'currentPage': message.page,
    'url': message.url
    }
  %}
  {% include 'components/pagination.html' with vars %}
</div>

{% for message in messages %}
  {% include 'messages/html/single.html' %}
{% endfor %}

{% include 'components/pagination.html' with vars %}
{% endblock %}
