{% extends "base/index.html"%}
{% block titlebar %}{% if user.ckey %}IDENTITY / {{user.ckey|upper}}{% else %}IDENTITY UNKNOWN{% endif %}{% endblock %}
{%block content %}
{% if user.ckey %}
<div class="pda-me-header">
  <h1><small class="text-muted">You are</small> {{user.label|raw}}</h1>
  {% if statbus.auth.remote_auth %}
  <a class="pda-button pda-button--accent" href="{{path_for('logout')}}">Logout</a>
  {% endif %}
</div>

<p class="lead">
  Between your first connection {{user.firstseen|timestamp}} and your most recent connection {{user.lastseen|timestamp}}, you have connected {{user.connections}} times.
</p>

<p class="lead">You have wasted <span title="About {{user.hours}}, since we started tracking time spent in roles" data-toggle="tooltip">0</span> hours playing Space Station 13, because time spent doing something you enjoy isn't wasted time.</p>

<div class="pda-me-links">
  <h3><a class="pda-link" href="{{path_for('me.roles')}}">&gt; Role Time</a></h3>
  <h3><a class="pda-link" href="{{path_for('me.rounds')}}">&gt; Your Rounds</a></h3>
  <h3><a class="pda-link" href="{{path_for('me.messages')}}">&gt; Your Notes and Messages</a></h3>
</div>

<div class="pda-card">
  <div class="pda-card__title">
    <a data-toggle="collapse" href="#lastwords" role="button" aria-expanded="false" aria-controls="lastwords">Your Last Words</a>
  </div>
  <div class="pda-card__body pda-card__body--padded collapse" id="lastwords">
    <ul class="pda-quote-list">
    {% for death in lastWords %}
      <li><a class="pda-link" href="{{path_for('death.single',{'id': death.id})}}"><code>&ldquo;{{death.last_words|raw}}&rdquo;</code></a></li>
    {% endfor %}
    </ul>
  </div>
</div>

{% else %}
<h1>Hmm...</h1>
<p class="lead">I'm not sure who you are. Can you please authenticate with the remote website for me?</p>
<a href="{{path_for('auth')}}" class="pda-button pda-button--accent" style="display:block;">Authenticate</a>
{% endif %}

{% endblock %}
