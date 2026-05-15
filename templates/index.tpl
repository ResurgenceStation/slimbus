{% extends 'base/index.html' %}
{% block pagetitle %} - Home{% endblock %}
{% block status_left %}{{numbers.rounds|number_format}} rounds tracked{% endblock %}
{% block content %}

<div class="win95-section">
  <div class="win95-section__title">
    <span>Welcome to {{statbus.app_name}}</span>
    {% if user.ckey and poly %}<small>Poly says hi</small>{% endif %}
  </div>
  <div class="win95-section__body">
    {% if user.ckey and poly %}
      <div class="win95-flex-between" style="margin-bottom:6px;">
        <div>
          <strong>[Poly]</strong> &ldquo;{{poly}}&rdquo;
        </div>
        <img src="https://atlantaned.space/statbus/icons/mob/animal/parrot_sit.png" height="48" width="48" alt="Poly the parrot" style="image-rendering:auto;">
      </div>
    {% endif %}
    <div class="win95-grid win95-grid--auto">
      <div class="jumbotron">
        <div class="text-muted"><small>Cataloging</small></div>
        <div class="display-4">{{numbers.deaths}}</div>
        <div class="text-muted"><small>Total <a href="{{path_for('death.index')}}">Deaths</a></small></div>
      </div>
      <div class="jumbotron">
        <div class="text-muted"><small>With Data From</small></div>
        <div class="display-4">{{numbers.rounds}}</div>
        <div class="text-muted"><small>Total <a href="{{path_for('round.index')}}">Rounds</a></small></div>
      </div>
      <div class="jumbotron">
        <div class="text-muted"><small>And</small></div>
        <div class="display-4">{{numbers.playtime}}</div>
        <div class="text-muted"><small>Total Minutes Played</small></div>
      </div>
      <div class="jumbotron">
        <div class="text-muted"><small>Check Out</small></div>
        <div class="display-4">{{numbers.books}}</div>
        <div class="text-muted"><small>Books In The <a href="{{path_for('library.index')}}">Library</a></small></div>
      </div>
    </div>
  </div>
</div>

<div class="win95-section">
  <div class="win95-section__title">
    <span>Quick Links</span>
  </div>
  <div class="win95-section__body">
    <a class="win95-button" href="{{path_for('round.index')}}">Browse Rounds</a>
    <a class="win95-button" href="{{path_for('death.index')}}">Browse Deaths</a>
    <a class="win95-button" href="{{path_for('library.index')}}">Library</a>
    <a class="win95-button" href="{{path_for('poll.index')}}">Polls</a>
    <a class="win95-button" href="{{path_for('round.stations')}}">Station Names</a>
    {% if settings.election_mode %}
      <a class="win95-button" href="{{path_for('election')}}">Elections</a>
    {% endif %}
  </div>
</div>

{% endblock %}
