{% extends ('base/index.html') %}
{% block titlebar %}MESSAGE{% endblock %}
{% block content %}
{% include 'messages/html/single.html' %}
{% if message.lasteditor %}
<h2>Edit History</h2>
<div class="pda-card pda-card__body pda-card__body--padded">
  {{message.edits|raw}}
</div>
{% endif %}
{% endblock %}
