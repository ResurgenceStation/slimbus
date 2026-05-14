{% extends "base/index.html"%}
{% block titlebar %}ADMIN PLAY ACTIVITY{% endblock %}
{% block content %}
<h2>Admin Play Activity</h2>

<form class="pda-card pda-card__body--padded pda-admins-form" method="GET" action="">
  <label class="pda-admins-form__label" for="interval">DAYS</label>
  <input type="number" max='{{maxRange}}' min='2' class="pda-input pda-input--sm" id="interval" placeholder="Days" value="{{interval}}" name="interval">
  <button type="submit" class="pda-button pda-button--accent">View Activity</button>
</form>

<style>
.perm-flag { font-size: 25%; }
.perm-flag:before { display: none; }
</style>
<table class="pda-table sort">
  <thead>
    <tr>
      <th>ckey</th>
      <th data-toggle="tooltip" title="Time spent as ghost is roughly equated with active adminning. Time spent living is time roughly equated with playing instead of adminning.">Play time</th>
      <th>Connections</th>
      <th>Rank</th>
      <th class="perm-flag">Feedback</th>
      {% for name, bits in perms %}
      <th class="perm-flag">{{name}}</th>
      {% endfor %}
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
        <td>{% if a.feedback %}<a class="pda-link" href="{{a.feedback}}" target="_blank" rel="noopener noreferrer">Thread</a>{% endif %}</td>
        {% for name, bits in perms %}
          {% if a.flags b-and bits %}
          <td class="pda-perm pda-perm--ok" data-toggle="tooltip" title="{{a.ckey}} has {{name}}"><i class="far fa-check-circle"></i></td>
          {% else %}
          <td class="pda-perm pda-perm--no" data-toggle="tooltip" title="{{a.ckey}} does not have {{name}}"><i class="far fa-times-circle"></i></td>
          {% endif %}
        {% endfor %}
      </tr>
    {% endfor %}
  </tbody>
</table>
{% endblock %}
