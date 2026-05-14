{% extends "base/index.html"%}
{% block pagetitle %}Last Words{% endblock %}
{% block titlebar %}LAST WORDS{% endblock %}
{% block content %}
<h2>Last Words</h2>
<p class="text-muted">Selected final transmissions from the deceased.</p>

<ul class="pda-quote-list">
{% for death in deaths %}
  <li>
    <a class="pda-link" href="{{path_for('death.single',{'id': death.id})}}">
      <code>&ldquo;{{death.last_words|raw}}&rdquo;</code>
    </a>
  </li>
{% endfor %}
</ul>
{% endblock %}
