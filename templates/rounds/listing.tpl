{% extends "base/index.html"%}
{% block pagetitle %}Round Index{% endblock %}
{% block titlebar %}ROUND INDEX{% endblock %}
{% block content %}
<div class="pda-listing-toolbar">
  {% set vars = {
    'nbPages': round.pages,
    'currentPage': round.page,
    'url': path_for('round.index')
    }
  %}
  {% include 'components/pagination.html' with vars %}

  <div class="pda-listing-toolbar__meta">
    <small>
      Showing rounds between {{round.firstListing}} UTC and {{round.lastListing}} UTC<br>
      <a class="pda-link" href="{{path_for('round.stations')}}">Some famous Nanotrasen Space Stations</a>
    </small>
  </div>
</div>

<table class="pda-table">
  <thead>
    <tr>
      <th>ID</th>
      <th>Mode</th>
      <th>Result</th>
      <th>Map</th>
      <th>Start</th>
      <th>Duration</th>
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
