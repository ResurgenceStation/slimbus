{% extends "base/index.html"%}
{% block titlebar %}AUTHORIZE REMOTE ACCESS{% endblock %}
{%block content %}
<h2>Authorize remote access</h2>

<div class="pda-card pda-card__body pda-card__body--padded">
  <p>
    <code>{{statbus.app_name}}</code> would like to access the following account information from <code>{{statbus.auth.remote_auth}}</code>:
  </p>
  <ul class="pda-bulletlist">
    <li>Your PhpBB Username</li>
    <li>Your Byond key, if set</li>
    <li>Your Github username, if set</li>
  </ul>

  <p>No other information, <em>including your password(s)</em> will be shared with <code>{{statbus.app_name}}</code>.</p>

  <p><small>When you click proceed, you will be directed to <code>{{statbus.auth.remote_auth}}</code> to complete the authentication process.</small></p>

  <p>
    <a class="pda-button pda-button--accent" href="{{path_for('auth_redirect')}}">Proceed</a>
    <a class="pda-button" href="{{path_for('statbus')}}">Cancel</a>
  </p>
</div>
{% endblock %}
