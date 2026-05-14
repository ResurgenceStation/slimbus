{% extends "base/index.html"%}
{% block titlebar %}ADMIN RANK LOGS{% endblock %}
{% block content %}
<h2>Admin Rank Logs</h2>
<p class="text-muted">Logs of changes to admin ranks</p>

<div class="pda-listing-toolbar">
  {% set vars = {
    'nbPages': info.pages,
    'currentPage': info.page,
    'url': path_for('admin_logs')
    }
  %}
  {% include 'components/pagination.html' with vars %}
</div>

<table class="pda-table">
  <thead>
    <tr>
      <th>ID</th>
      <th>Date</th>
      <th>Admin</th>
      <th>Action</th>
      <th>Target</th>
      <th>Log Entry</th>
    </tr>
  </thead>
  <tbody>
    {% for l in logs %}
      <tr id="{{l.id}}"{% if l.class == 'danger' %} class="pda-row--crashed"{% elseif l.class == 'warning' %} class="pda-row--ongoing"{% endif %}>
        <td class="nw"><a class="pda-link" href="#{{l.id}}">{{l.id}}</a></td>
        <td class="nw">{{l.datetime|timestamp}}</td>
        <td class="nw">{{l.admin.label|raw}}</td>
        <td class="nw"><i class="fas fa-{{l.icon}}"></i> {{l.operation}}</td>
        <td class="nw">{{l.target}}</td>
        <td>{{l.log}}</td>
      </tr>
    {% endfor %}
  </tbody>
</table>
{% include 'components/pagination.html' with vars %}
{% endblock %}
