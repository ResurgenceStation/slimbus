{% extends "base/index.html"%}
{% block pagetitle %}Logs - Round #{{round.id}}{% endblock %}
{% block titlebar %}ROUND #{{round.id}} / LOGS{% endblock %}
{% block content %}
{% include('rounds/html/header.tpl') %}

{% set gameLogs = ['game.txt','game.html','attack.txt','attack.html','game.log','attack.log'] %}
<div class="pda-listing-toolbar">
  <h3 style="margin: 0;">Available log files</h3>
  <a class="pda-button" href="{{round.remote_logs_dir}}" target="_blank" rel="noopener noreferrer">
    Original <i class="fas fa-external-link-alt"></i>
  </a>
</div>

<div class="pda-grid pda-grid--2">
  <div class="pda-card">
    <div class="pda-card__title">Parsed</div>
    <ul class="pda-list-group list-group">
    {% for file in logs %}
      {% if file.fileName in gameLogs %}
      <a class="pda-list-group__item list-group-item" href="{{path_for('round.gamelogs',{'id': round.id})}}">{{file.fileName}}</a>
      {% else %}
      <a class="pda-list-group__item list-group-item" href="{{path_for('round.log',{'id': round.id, 'file': file.fileName})}}">{{file.fileName}}</a>
      {% endif %}
    {% endfor %}
    </ul>
  </div>
  <div class="pda-card">
    <div class="pda-card__title">Raw</div>
    <ul class="pda-list-group list-group">
    {% for file in logs %}
      {% if file.fileName not in gameLogs %}
      <a class="pda-list-group__item list-group-item" href="{{path_for('round.log',{'id': round.id, 'file': file.fileName, 'format':'raw'})}}">{{file.fileName}}</a>
      {% endif %}
    {% endfor %}
    </ul>
  </div>
</div>
{% endblock %}
