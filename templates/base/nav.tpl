<div class="win95-menubar">
  <ul class="win95-menubar__list">
    <li class="win95-menubar__item">
      <a class="win95-menubar__link" href="{{path_for('statbus')}}"><i class="fas fa-home"></i> Home</a>
    </li>
    <li class="win95-menubar__item">
      <a class="win95-menubar__link" href="{{path_for('round.index')}}"><i class="fas fa-circle"></i> Rounds</a>
    </li>
    <li class="win95-menubar__item">
      <a class="win95-menubar__link" href="{{path_for('death.index')}}"><i class="fas fa-user-times"></i> Deaths</a>
    </li>
    <li class="win95-menubar__item">
      <a class="win95-menubar__link" href="{{path_for('library.index')}}"><i class="fas fa-book"></i> Library</a>
    </li>
    <li class="win95-menubar__item">
      <a class="win95-menubar__link" href="{{path_for('poll.index')}}"><i class="fas fa-vote-yea"></i> Polls</a>
    </li>
    <li class="win95-menubar__item">
      <a class="win95-menubar__link" href="#" aria-haspopup="true"><i class="fas fa-info-circle"></i> Info</a>
      <ul class="win95-menubar__submenu">
        <li><a class="win95-menubar__link" href="{{path_for('population')}}"><i class="fas fa-users"></i> Server Population</a></li>
        <li><a class="win95-menubar__link" href="{{path_for('playtime')}}"><i class="fas fa-chart-line"></i> Playtime</a></li>
        <li><a class="win95-menubar__link" href="{{path_for('winloss')}}"><i class="fas fa-percent"></i> Gamemode Win/Loss</a></li>
        <li><a class="win95-menubar__link" href="{{path_for('admin_connections')}}"><i class="fas fa-user-clock"></i> Admin Activity</a></li>
        <li><a class="win95-menubar__link" href="{{path_for('admin_logs')}}"><i class="fas fa-user-times"></i> Admin Rank Activity</a></li>
      </ul>
    </li>
    <li class="win95-menubar__item">
      <a class="win95-menubar__link" href="#" aria-haspopup="true"><i class="fas fa-globe"></i> Extra</a>
      <ul class="win95-menubar__submenu">
        <li><a class="win95-menubar__link" href="{{path_for('round.stations')}}"><i class="fas fa-globe"></i> Station Names</a></li>
        <li><a class="win95-menubar__link" href="{{path_for('stat.rounds',{'stat': 'newscaster_stories'})}}"><i class="far fa-newspaper"></i> Newscaster Stories</a></li>
      </ul>
    </li>
    {% if settings.election_mode %}
    <li class="win95-menubar__item">
      <a class="win95-menubar__link" href="{{path_for('election')}}"><i class="fas fa-vote-yea"></i> Elections</a>
    </li>
    {% endif %}
    {% if user.canAccessTGDB %}
    <li class="win95-menubar__item">
      <a class="win95-menubar__link" href="{{path_for('tgdb')}}"><i class="fas fa-shield-alt"></i> TGDB</a>
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
      <a href="{{path_for('me')}}"><i class="fas fa-user"></i> {{user.label|raw}}</a>
    {% elseif statbus.auth.remote_auth %}
      <a href="{{path_for('auth')}}"><i class="fas fa-sign-in-alt"></i> Authenticate</a>
    {% endif %}
    {% if settings.debug %}
      <span class="win95-menubar__badge">DEBUG</span>
    {% endif %}
  </div>
</div>
