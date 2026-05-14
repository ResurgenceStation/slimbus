{% extends "base/index.html"%}
{% block titlebar %}LOGGED OUT{% endblock %}
{%block content %}
<div class="pda-card pda-card__body pda-card__body--padded" style="text-align:center;">
  <h2>You have logged out</h2>
  <p><a class="pda-button" href="{{path_for('statbus')}}">Continue</a></p>
</div>
{% endblock %}
