{% extends "base/index.html"%}
{% block titlebar %}HEADMIN CANDIDATES{% endblock %}
{% block content %}
<h2>Candidate Activity</h2>

<form class="pda-admins-form" method="GET" action="">
  <label class="pda-admins-form__label" for="interval">DAYS</label>
  <input type="number" max='180' min='2' class="pda-input pda-input--sm" id="interval" placeholder="Days" value="{{interval}}" name="interval">
  <button type="submit" class="pda-button pda-button--accent">View Activity</button>
</form>

<p>This page shows the time spent as a ghost and time spent living for the Headmin Candidates listed below, along with the number of times their ckey has connected to the servers.</p>

<table class="pda-table sort">
  <thead>
    <tr>
      <th>ckey</th>
      <th>Play time</th>
      <th>Connections</th>
      <th>Rank</th>
    </tr>
  </thead>
  <tbody>
    {% for a in admins %}
      <tr>
        <td>{{a.label|raw}}</td>
        <td>
          {% if a.total %}
          <div class="progress" data-toggle="tooltip" title="Ghost: {{a.ghost}}m / Living: {{a.living}}m">
            <div class="progress-bar bg-info" role="progressbar" style="width: {{a.ghost/a.total * 100}}%"></div>
            <div class="progress-bar bg-success" role="progressbar" style="width: {{a.living/a.total * 100}}%"></div>
          </div>
          {% else %}
          <small class="text-muted">[Data Unavailable]</small>
          {% endif %}
        </td>
        <td>{{a.connections}}</td>
        <td>{{a.rank}}</td>
      </tr>
    {% endfor %}
  </tbody>
</table>

{% if settings.election_officer == user.ckey %}
<div class="pda-card">
  <div class="pda-card__title">Election Officer Controls</div>
  <div class="pda-card__body pda-card__body--padded">
    <p class="text-muted">Paste in a list of ckeys to show on the board above. Each ckey should match <code>[a-zA-Z0-9]</code> and should be separated by a comma (<code>,</code>)</p>
    <form action="{{path_for('election')}}" method="POST">
      <input type='text' class="pda-input" name="candidates" value="{{list}}" style="width: 100%;">
      <button type="submit" class="pda-button pda-button--accent" style="margin-top: 8px;">Update Candidate Listing</button>
    </form>
  </div>
</div>
{% endif %}
{% endblock %}
