{% extends 'base/index.html' %}
{% block pagetitle %} - Round #{{round.id}}{% endblock %}
{% block status_left %}<i class="fas fa-circle"></i> Round #{{round.id}} &middot; {{round.duration}}{% endblock %}
{% block content %}

{% if round.data.nuclear_challenge_mode %}
<div class="alert alert-danger" style="margin-bottom:8px;">
  <strong><i class="fas fa-radiation"></i> ALERT!</strong> WAR WERE DECLARED!
</div>
{% endif %}

{% if round.userWasAntag %}
<div class="alert alert-success" style="margin-bottom:8px;">
  <strong><i class="fas fa-mask"></i> Hey, neat!</strong> Looks like you were an antagonist this round!
</div>
{% endif %}

{% include('rounds/html/basic.tpl') %}

{% if round.data %}
  {% for name, stat in round.data %}
  <div class="win95-section" id="prs-{{name}}">
    <div class="win95-section__title">
      <span><i class="fas fa-chart-bar"></i> <code>{{name}}</code></span>
    </div>
    <div class="win95-section__body">
      {% include ['stats/single/' ~ stat.key_name ~'-' ~ stat.version ~'.tpl', 'stats/single/' ~ stat.key_name ~'.tpl','stats/type/' ~ stat.key_type ~'.tpl', 'stats/generic.tpl'] %}
    </div>
  </div>
  {% endfor %}
{% endif %}

<div class="win95-section">
  <div class="win95-section__title">
    <span><i class="fas fa-list-ul"></i> Round Stats</span>
  </div>
  <div class="win95-section__body win95-flex-row">
    {% for key, stat in round.stats %}
      <a class="win95-button win95-button--sm win95-mono" href="{{path_for('round.single',{'id': round.id, 'stat':key})}}">{{key}}</a>
    {% endfor %}
  </div>
</div>

{% endblock %}
