{% extends ('base/index.html') %}
{% block titlebar %}{{statbus.app_name|upper}}{% endblock %}
{% block content %}
  <h1>Welcome to {{statbus.app_name}}!<span class="pda-cursor"></span>
    {% if user.ckey and poly %}
      <div id="poly" class="engradio pda-poly">
        [Poly] &ldquo;{{poly}}&rdquo;
        <img src="https://atlantaned.space/statbus/icons/mob/animal/parrot_sit.png" height="64" width="64" alt="And now a word from Poly" />
      </div>
    {% endif %}
  </h1>

  <div class="pda-jumbotron-grid">
    <div class="pda-card pda-jumbotron">
      <div class="pda-jumbotron__label">CATALOGING</div>
      <div class="pda-jumbotron__count">{{numbers.deaths}}</div>
      <div class="pda-jumbotron__caption">Total <a class="pda-link" href="{{path_for('death.index')}}">Deaths</a></div>
    </div>
    <div class="pda-card pda-jumbotron">
      <div class="pda-jumbotron__label">WITH DATA FROM</div>
      <div class="pda-jumbotron__count">{{numbers.rounds}}</div>
      <div class="pda-jumbotron__caption">Total <a class="pda-link" href="{{path_for('round.index')}}">Rounds</a></div>
    </div>
    <div class="pda-card pda-jumbotron">
      <div class="pda-jumbotron__label">AND</div>
      <div class="pda-jumbotron__count">{{numbers.playtime}}</div>
      <div class="pda-jumbotron__caption">Total Minutes Played</div>
    </div>
  </div>

  <div class="pda-jumbotron-grid pda-jumbotron-grid--single">
    <div class="pda-card pda-jumbotron">
      <div class="pda-jumbotron__label">CHECK OUT</div>
      <div class="pda-jumbotron__count">{{numbers.books}}</div>
      <div class="pda-jumbotron__caption">Books In The <a class="pda-link" href="{{path_for('library.index')}}">Library</a></div>
    </div>
  </div>
{% endblock %}
