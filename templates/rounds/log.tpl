{% extends "base/index.html" %}
{% import('components/macros.tpl') as m %}
{% block pagetitle %}Logs - Round #{{round.id}}{% endblock %}
{% block titlebar %}ROUND #{{round.id}} / {{filename|upper}}{% endblock %}
{% block content %}
{% include('rounds/html/header.tpl') %}

{% set gameLogs = ['game.txt','game.html','attack.txt','attack.html'] %}
<div class="pda-listing-toolbar">
  <h3 style="margin: 0;">Viewing <code>{{filename}}</code></h3>
  <div>
    {% if format == 'raw' %}
      <a href="{{path_for('round.log',{'id': round.id, 'file': filename})}}" class="pda-button">View Parsed</a>
    {% else %}
      {% if filename not in gameLogs %}
      <a href="{{path_for('round.log',{'id': round.id, 'file': filename, 'format': 'raw'})}}" class="pda-button">View Raw</a>
      {% endif %}
    {% endif %}
    <a href="{{round.remote_logs_dir}}/{{filename}}" target="_blank" rel="noopener noreferrer" class="pda-button">
      View Original <i class="fas fa-external-link-alt"></i>
    </a>
  </div>
</div>

<div class="pda-card pda-logfile">
  <div class="pda-card__title">[BEGIN LOG: {{filename}}]</div>
  <div class="pda-card__body pda-logfile__body">
    {% if format == 'raw' %}
      <pre>{{file}}</pre>
    {% else %}
      {% include ['rounds/logs/' ~ filename ~'.tpl', 'rounds/logs/generic.tpl'] %}
    {% endif %}
  </div>
</div>

{% endblock %}
