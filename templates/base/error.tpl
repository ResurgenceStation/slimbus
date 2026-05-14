{% extends "base/index.html"%}
{% block titlebar %}ERROR {{code}}{% endblock %}
{% block content %}

<div class="pda-card pda-error">
  <div class="pda-error__code">
    <small>ERROR CODE</small> {{code}}
  </div>
  <p class="pda-error__message">{{message}}</p>
  <p class="pda-error__actions">
    {% if link %}
    <a class="pda-button pda-button--accent" href="{{link}}" role="button">{{linkText}}</a>
    {% endif %}
    <a class="pda-button" href="{{path_for('statbus')}}" role="button">Go Home</a>
  </p>
</div>

{% endblock %}
