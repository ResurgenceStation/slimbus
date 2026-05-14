{% extends "base/index.html"%}
{% block pagetitle %}Round Index{% endblock %}
{% block titlebar %}YOUR ROUNDS{% endblock %}
{% block content %}
<h3>Rounds where your ckey was connected</h3>

<div class="pda-listing-toolbar">
  {% set vars = {
    'nbPages': round.pages,
    'currentPage': round.page,
    'url': path_for('me.rounds')
    }
  %}
  {% include 'components/pagination.html' with vars %}
</div>

<table class="pda-table">
  <thead>
    <tr>
      <th>ID</th>
      <th>Mode</th>
      <th>Result</th>
      <th>Map</th>
      <th>Duration</th>
      <th>Start</th>
      <th>End</th>
      <th>Server</th>
    </tr>
  </thead>
  <tbody>
  {% for round in rounds %}
    {% include('rounds/html/listingrow.tpl') %}
  {% endfor %}
  </tbody>
</table>
{% include 'components/pagination.html' with vars %}
{% endblock %}
