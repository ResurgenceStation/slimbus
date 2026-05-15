<div class="win95-menubar">
  <ul class="win95-menubar__list">
    <li class="win95-menubar__item">
      <a class="win95-menubar__link" href="{{path_for('statbus')}}">Home</a>
    </li>
    <li class="win95-menubar__item">
      <a class="win95-menubar__link" href="{{path_for('round.index')}}">Rounds</a>
    </li>
    <li class="win95-menubar__item">
      <a class="win95-menubar__link" href="{{path_for('death.index')}}">Deaths</a>
    </li>
    <li class="win95-menubar__item">
      <a class="win95-menubar__link" href="{{path_for('library.index')}}">Library</a>
    </li>
    <li class="win95-menubar__item">
      <a class="win95-menubar__link" href="{{path_for('poll.index')}}">Polls</a>
    </li>
    <li class="win95-menubar__item">
      <a class="win95-menubar__link" href="#" aria-haspopup="true">Info</a>
      <ul class="win95-menubar__submenu">
        <li><a class="win95-menubar__link" href="{{path_for('population')}}">Server Population</a></li>
        <li><a class="win95-menubar__link" href="{{path_for('playtime')}}">Playtime</a></li>
        <li><a class="win95-menubar__link" href="{{path_for('winloss')}}">Gamemode Win/Loss</a></li>
        <li><a class="win95-menubar__link" href="{{path_for('admin_connections')}}">Admin Activity</a></li>
        <li><a class="win95-menubar__link" href="{{path_for('admin_logs')}}">Admin Rank Activity</a></li>
      </ul>
    </li>
    <li class="win95-menubar__item">
      <a class="win95-menubar__link" href="#" aria-haspopup="true">Extra</a>
      <ul class="win95-menubar__submenu">
        <li><a class="win95-menubar__link" href="{{path_for('round.stations')}}">Station Names</a></li>
        <li><a class="win95-menubar__link" href="{{path_for('stat.rounds',{'stat': 'newscaster_stories'})}}">Newscaster Stories</a></li>
      </ul>
    </li>
    {% if settings.election_mode %}
    <li class="win95-menubar__item">
      <a class="win95-menubar__link" href="{{path_for('election')}}">Elections</a>
    </li>
    {% endif %}
    {% if user.canAccessTGDB %}
    <li class="win95-menubar__item">
      <a class="win95-menubar__link" href="{{path_for('tgdb')}}">TGDB</a>
    </li>
    {% endif %}
  </ul>
  <div class="win95-menubar__right">
    {% if user.canAccessTGDB %}
      <form class="form-inline" style="display:inline;">
        <input type="search" name="q" placeholder="ckey" aria-label="Search" id="tgdbsearch" class="js-typeahead" style="width:120px;">
      </form>
    {% endif %}
    {% if user.ckey %}
      <a href="{{path_for('me')}}">{{user.label|raw}}</a>
    {% elseif statbus.auth.remote_auth %}
      <a href="{{path_for('auth')}}">[Authenticate]</a>
    {% endif %}
    {% if settings.debug %}
      <span class="win95-menubar__badge">DEBUG</span>
    {% endif %}
  </div>
</div>
