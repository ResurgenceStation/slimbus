{% extends "base/index.html"%}
{% block pagetitle %}Polls{% endblock %}
{% block titlebar %}POLLS{% endblock %}
{% block content %}
<div class="pda-listing-toolbar">
  {% set vars = {
    'nbPages': poll.pages,
    'currentPage': poll.page,
    'url': path_for('poll.index')
    }
  %}
  {% include 'components/pagination.html' with vars %}
</div>

<table class="pda-table">
  <thead>
    <tr>
      <th>ID</th>
      <th>Type</th>
      <th>Question</th>
      <th>Duration</th>
      <th>Responses</th>
    </tr>
  </thead>
  <tbody>
  {% for poll in polls %}
    <tr>
      <td><a class="pda-link" href="{{path_for('poll.single',{'id': poll.id})}}">{{poll.id}}</a></td>
      <td><span class="pda-tag">{{poll.type}}</span></td>
      <td>{{poll.question|raw}}</td>
      <td>{{poll.duration}}</td>
      <td>{{poll.totalVotes}}</td>
    </tr>
  {% endfor %}
  </tbody>
</table>
{% include 'components/pagination.html' with vars %}
{% endblock %}
