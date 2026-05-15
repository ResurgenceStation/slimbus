{% extends 'base/index.html' %}
{% block pagetitle %} - Home{% endblock %}
{% block status_left %}{{numbers.rounds|number_format}} rounds tracked{% endblock %}
{% block content %}

{% if user.ckey and poly %}
<div class="alert alert-info win95-flex-row" style="margin-bottom:14px;">
  <img src="https://atlantaned.space/statbus/icons/mob/animal/parrot_sit.png" width="48" height="48" alt="Poly the parrot" style="image-rendering:auto;flex-shrink:0;">
  <div><strong>[Poly]</strong> &ldquo;{{poly}}&rdquo;</div>
</div>
{% endif %}

<div class="win95-section">
  <div class="win95-section__title">
    <span><i class="fas fa-database"></i> Database Snapshot</span>
    <small>Live counters from the statbus database</small>
  </div>
  <div class="win95-section__body">
    <div class="win95-grid win95-grid--auto">
      <div class="win95-kpi">
        <div class="win95-kpi__label"><i class="fas fa-user-times"></i> Deaths Catalogued</div>
        <div class="win95-kpi__value">{{numbers.deaths}}</div>
        <div class="win95-kpi__sub"><a href="{{path_for('death.index')}}">Browse deaths &raquo;</a></div>
      </div>
      <div class="win95-kpi">
        <div class="win95-kpi__label"><i class="fas fa-circle"></i> Rounds Tracked</div>
        <div class="win95-kpi__value">{{numbers.rounds}}</div>
        <div class="win95-kpi__sub"><a href="{{path_for('round.index')}}">Browse rounds &raquo;</a></div>
      </div>
      <div class="win95-kpi">
        <div class="win95-kpi__label"><i class="fas fa-clock"></i> Minutes Played</div>
        <div class="win95-kpi__value">{{numbers.playtime}}</div>
        <div class="win95-kpi__sub">Across all servers</div>
      </div>
      <div class="win95-kpi">
        <div class="win95-kpi__label"><i class="fas fa-book"></i> Library Books</div>
        <div class="win95-kpi__value">{{numbers.books}}</div>
        <div class="win95-kpi__sub"><a href="{{path_for('library.index')}}">Read &raquo;</a></div>
      </div>
    </div>
  </div>
</div>

<div class="win95-section">
  <div class="win95-section__title"><span><i class="fas fa-bolt"></i> Quick Links</span></div>
  <div class="win95-section__body">
    <a class="win95-button" href="{{path_for('round.index')}}"><i class="fas fa-circle"></i> Browse Rounds</a>
    <a class="win95-button" href="{{path_for('death.index')}}"><i class="fas fa-user-times"></i> Browse Deaths</a>
    <a class="win95-button" href="{{path_for('library.index')}}"><i class="fas fa-book"></i> Library</a>
    <a class="win95-button" href="{{path_for('poll.index')}}"><i class="fas fa-vote-yea"></i> Polls</a>
    <a class="win95-button" href="{{path_for('round.stations')}}"><i class="fas fa-globe"></i> Station Names</a>
    {% if settings.election_mode %}
      <a class="win95-button" href="{{path_for('election')}}"><i class="fas fa-vote-yea"></i> Elections</a>
    {% endif %}
  </div>
</div>

{% endblock %}
