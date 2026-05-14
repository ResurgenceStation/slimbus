{% extends "base/index.html"%}
{% block pagetitle %}Round #{{round.id}}{% endblock %}
{% block titlebar %}ROUND #{{round.id}}{% endblock %}
{% block content %}

{% if round.data.nuclear_challenge_mode %}
<div class="pda-alert pda-alert--err">
  <strong>ALERT!</strong> WAR WERE DECLARED!
</div>
{% endif %}

{% if round.userWasAntag %}
<div class="pda-alert pda-alert--ok">
  <strong>Hey, neat!</strong> Looks like you were an antagonist this round!
</div>
{% endif %}

{% include('rounds/html/basic.tpl') %}

{% if round.data %}
  {% for name, stat in round.data %}
  <div class="pda-card" id="prs">
    <div class="pda-card__title">
      <code>{{name}}</code>
    </div>
    <div class="pda-card__body">
      {% include ['stats/single/' ~ stat.key_name ~'-' ~ stat.version ~'.tpl', 'stats/single/' ~ stat.key_name ~'.tpl','stats/type/' ~ stat.key_type ~'.tpl', 'stats/generic.tpl'] %}
    </div>
  </div>
  {% endfor %}
{% endif %}

<h3>Round Stats</h3>
<ul class="pda-stat-list">
  {% for key, stat in round.stats %}
  <li>
    <a class="pda-link" href="{{path_for('round.single',{'id': round.id, 'stat':key})}}">
      <code>{{key}}</code>
    </a>
  </li>
  {% endfor %}
</ul>
{% endblock %}
