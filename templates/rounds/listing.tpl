{% extends 'base/index.html' %}
{% block pagetitle %} - Round Index{% endblock %}
{% block status_left %}Page {{round.page}} of {{round.pages}} &middot; rounds {{round.firstListing}} &rarr; {{round.lastListing}} UTC{% endblock %}
{% block content %}

<div class="win95-section">
  <div class="win95-section__title">
    <span>Round Index</span>
    <small><a href="{{path_for('round.stations')}}" style="color:#fff;">Famous Nanotrasen Stations</a></small>
  </div>
  <div class="win95-section__body">
    {% set vars = {
      'nbPages': round.pages,
      'currentPage': round.page,
      'url': path_for('round.index')
    } %}
    <div class="win95-flex-between">
      {% include 'components/pagination.html' with vars %}
      <small class="win95-muted">Showing rounds {{round.firstListing}} UTC &mdash; {{round.lastListing}} UTC</small>
    </div>

    <table class="win95-table win95-table--compact">
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
  </div>
</div>

{% endblock %}
