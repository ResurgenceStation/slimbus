{% extends "base/index.html"%}
{% block titlebar %}NAME RATER RESULTS{% endblock %}
{%block content %}
{% if not user %}
<h1>Hmm...</h1>
<p class="lead">You need to be logged in in order to vote on names</p>
<a href="{{path_for('auth')}}" class="pda-button pda-button--accent" style="display:block;">Authenticate</a>
{% else %}
<h1>Name Rater 5000</h1>

<div class="pda-namevote-nav">
  <a class="pda-button" href="{{path_for('nameVoter')}}">Vote on Names</a>
  <a class="pda-button" href="{{path_for('nameVoter.results',{'rank':'best'})}}">Best Names</a>
  <a class="pda-button" href="{{path_for('nameVoter.results',{'rank':'worst'})}}">Worst Names</a>
</div>

<table class="pda-table">
  <thead>
    <tr>
      <th>Name</th>
      <th>'No' Votes</th>
      <th>'Yes' Votes</th>
    </tr>
  </thead>
  <tbody>
    {% for r in ranking %}
      <tr>
        <td>{{r.name}}</td>
        <td>{{r.no}}</td>
        <td>{{r.yes}}</td>
      </tr>
    {% endfor %}
  </tbody>
</table>
{% endif %}
{% endblock %}
