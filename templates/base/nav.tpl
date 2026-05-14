{# PDA-themed top navigation (Stage 2 migration).

   Replaces the Bootstrap navbar-dark / fixed-top navbar with a
   horizontal PDA "menu bar" of section tabs. Sits inside the
   pda-frame body (under the statusbar+titlebar) and scrolls with
   the page rather than being viewport-fixed -- the frame's bezel
   is the persistent visual anchor, not the menu.

   Structure:
     [SECTION 1] [SECTION 2] [SECTION 3] [V INFO] [V EXTRA] ...
     |--------- left-aligned sections ---------|---- right side: user / search ----|

   Dropdowns (INFO, EXTRA) keep Bootstrap's data-toggle behaviour;
   pda.css already restyles .dropdown-menu in PDA aesthetic so the
   menus render correctly when opened.
#}
<nav class="pda-nav" aria-label="main navigation">
  <a class="pda-nav__brand" href="{{path_for('statbus')}}">
    {{statbus.app_name}}
  </a>

  <div class="pda-nav__sections">
    <a class="pda-nav__item" href="{{path_for('round.index')}}">
      <i class="fas fa-circle"></i> Rounds
    </a>
    <a class="pda-nav__item" href="{{path_for('death.index')}}">
      <i class="fas fa-user-times"></i> Deaths
    </a>
    <a class="pda-nav__item" href="{{path_for('library.index')}}">
      <i class="fas fa-book"></i> Library
    </a>
    <a class="pda-nav__item" href="{{path_for('poll.index')}}">
      <i class="fas fa-vote-yea"></i> Polls
    </a>

    <div class="pda-nav__dropdown dropdown">
      <a class="pda-nav__item dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
        <i class="fas fa-info-circle"></i> Info
      </a>
      <div class="dropdown-menu">
        <a class="dropdown-item" href="{{path_for('population')}}"><i class="fas fa-users"></i> Server Population</a>
        <a class="dropdown-item" href="{{path_for('playtime')}}"><i class="fas fa-chart-line"></i> Playtime</a>
        <a class="dropdown-item" href="{{path_for('winloss')}}"><i class="fas fa-percent"></i> Gamemode Win Loss Ratios</a>
        <a class="dropdown-item" href="{{path_for('admin_connections')}}"><i class="fas fa-user-clock"></i> Admin Activity</a>
        <a class="dropdown-item" href="{{path_for('admin_logs')}}"><i class="fas fa-user-times"></i> Admin Rank Activity</a>
      </div>
    </div>

    <div class="pda-nav__dropdown dropdown">
      <a class="pda-nav__item dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
        <i class="fas fa-globe"></i> Extra
      </a>
      <div class="dropdown-menu">
        <a class="dropdown-item" href="{{path_for('stat.rounds',{'stat': 'newscaster_stories'})}}"><i class="fas fa-newspaper"></i> Newscaster Stories</a>
      </div>
    </div>

    {% if settings.election_mode %}
    <a class="pda-nav__item pda-nav__item--accent" href="{{path_for('election')}}">
      <i class="fas fa-vote-yea"></i> Elections
    </a>
    {% endif %}

    {% if user.canAccessTGDB %}
    <a class="pda-nav__item pda-nav__item--danger" href="{{path_for('tgdb')}}">
      <i class="fas fa-shield-alt"></i> TGDB
    </a>
    {% endif %}
  </div>

  <div class="pda-nav__user">
    {% if user.canAccessTGDB %}
      <form class="pda-nav__search">
        <div class="typeahead__container">
          <input class="pda-input pda-input--sm js-typeahead" type="search" placeholder="ckey" aria-label="Search ckey" id="tgdbsearch">
        </div>
      </form>
    {% endif %}

    {% spaceless %}
    {% if user.ckey %}
      <a class="pda-nav__user-link" href="{{path_for('me')}}">{{user.label|raw}}</a>
    {% elseif statbus.auth.remote_auth %}
      <a class="pda-nav__user-link" href="{{path_for('auth')}}">
        <span class="pda-tag">AUTH</span>
      </a>
    {% endif %}

    {% if settings.debug %}
      <span class="pda-tag pda-tag--err">DEBUG</span>
    {% endif %}
    {% endspaceless %}
  </div>
</nav>
