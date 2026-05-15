{% extends 'base/index.html' %}
{% block pagetitle %} - Round #{{round.id}}{% endblock %}
{% block status_left %}Round #{{round.id}} &middot; {{round.duration}}{% endblock %}
{% block content %}

{% if round.data.nuclear_challenge_mode %}
<div class="alert alert-danger" style="margin-bottom:6px;">
  <strong>ALERT!</strong> WAR WERE DECLARED!
</div>
{% endif %}

{% if round.userWasAntag %}
<div class="alert alert-success" style="margin-bottom:6px;">
  <strong>Hey, neat!</strong> Looks like you were an antagonist this round!
</div>
{% endif %}

{% include('rounds/html/basic.tpl') %}

{% if round.data %}
  {% for name, stat in round.data %}
  <div class="win95-section" id="prs-{{name}}">
    <div class="win95-section__title">
      <code style="color:#fff;">{{name}}</code>
    </div>
    <div class="win95-section__body">
      {% include ['stats/single/' ~ stat.key_name ~'-' ~ stat.version ~'.tpl', 'stats/single/' ~ stat.key_name ~'.tpl','stats/type/' ~ stat.key_type ~'.tpl', 'stats/generic.tpl'] %}
    </div>
  </div>
  {% endfor %}
{% endif %}

<div class="win95-section">
  <div class="win95-section__title">
    <span>Round Stats</span>
  </div>
  <div class="win95-section__body">
    {% for key, stat in round.stats %}
      <a class="win95-button win95-button--sm win95-mono" href="{{path_for('round.single',{'id': round.id, 'stat':key})}}">{{key}}</a>
    {% endfor %}
  </div>
</div>

{% endblock %}
