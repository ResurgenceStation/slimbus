{% extends "index.tpl"%}
{% block titlebar %}STATION NAMES{% endblock %}
{% block content %}
<h2>Station Names</h2>
<p class="text-muted">A wall of famous (and infamous) Nanotrasen station designations.</p>
<ul class="pda-quote-list">
{% for word in names %}
  <li><a class="pda-link" href="{{path_for('round.single',{'id': word.id})}}"><code>{{word.station_name|raw}}</code></a></li>
{% endfor %}
</ul>
{% endblock %}
