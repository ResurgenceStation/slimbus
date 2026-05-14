{% extends "index.tpl"%}
{% block titlebar %}PLAYER {{player.ckey|upper}}{% endblock %}
{% block content %}
<h2>{{player.ckey}}
  <small class="text-muted"> | <a class="pda-link" href="http://www.byond.com/members/{{player.ckey}}" target="_blank" rel="noopener noreferrer"><i class="fas fa-external-link-alt"></i> Byond</a></small>
</h2>

<h3>Achievements</h3>
{% for a in player.achievements %}
  <div class="pda-alert pda-alert--{% if a.type == 'achievement' %}warn{% else %}ok{% endif %}">
    <strong>{{a.key}}</strong>{% if a.type == 'score' %} - {{a.value}}{% endif %}
  </div>
  {% else %}
  <p class="text-muted">No achievements yet</p>
{% endfor %}
{% endblock %}
