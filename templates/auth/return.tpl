{% extends "base/index.html"%}
{% block titlebar %}AUTHENTICATED{% endblock %}
{%block content %}
<div class="pda-card pda-card__body pda-card__body--padded" style="text-align:center;">
  <h2>Success!</h2>
  <p><h1>{{user.label|raw}}</h1></p>
  <p><code>{{statbus.app_name}}</code> now recognizes you!</p>
  {% if return_uri %}
  <a class="pda-button pda-button--accent" href="{{return_uri}}">Continue</a>
  {% else %}
  <a class="pda-button pda-button--accent" href="{{path_for('statbus')}}">Continue</a>
  {% endif %}
</div>
{% endblock %}
