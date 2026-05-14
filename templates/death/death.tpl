{% extends "base/index.html"%}
{% import('components/macros.tpl') as macros %}
{% block pagetitle %}Death #{{death.id}}{% endblock %}
{% block titlebar %}DEATH RECORD #{{death.id}}{% endblock %}
{% block content %}
<h2>
  <small class='text-muted'><i class='fas fa-user-times'></i> {{death.id}}</small> {{macros.ckey(death.name, death.byondkey)}}
</h2>

{% if death.lakey %}
<div class="pda-card pda-card--alert" style="border-color: var(--pda-danger);">
  <div class="pda-card__title" style="color: var(--pda-danger);">Murder Suspect</div>
  <div class="pda-card__body" style="font-size: var(--pda-size-lg); padding: 14px 18px;">
    {{macros.ckey(death.laname, death.lakey)}}
  </div>
</div>
{% endif %}

{% if death.suicide %}
<div class="pda-card pda-card--alert">
  <div class="pda-card__title">Suicide</div>
</div>
{% endif %}

<div class="pda-grid pda-grid--3">
  <div class="pda-card">
    <div class="pda-card__title">Cause of Death</div>
    <div class="pda-card__body pda-card__body--padded pda-readout">
      {{death.cause}}
    </div>
  </div>
  <div class="pda-card">
    <div class="pda-card__title">Vital Signs</div>
    <div class="pda-card__body pda-card__body--padded pda-readout">
      {% include 'death/html/vitals.html' %}
    </div>
  </div>
  <div class="pda-card">
    <div class="pda-card__title">Rank</div>
    <div class="pda-card__body pda-card__body--padded pda-readout">
      {{death.job}}
      {% if death.special %}
      <span class="pda-tag pda-tag--err">{{death.special}}</span>
      {% endif %}
    </div>
  </div>
</div>

<div class="pda-grid pda-grid--2">
  <div class="pda-card">
    <div class="pda-card__title">Location</div>
    <div class="pda-card__body pda-card__body--padded pda-readout">
      {{death.mapname}} - {{death.pod}} ({{death.x}}, {{death.y}}, {{death.z}})
      {% if death.z == 2 %}
      <iframe class="pda-iframe" src="https://atlantaned.space/renderbus/#5/{{death.x}}/{{death.y}}/{{death.map_url}}"></iframe><br>
      <a class="pda-link" href="https://atlantaned.space/renderbus/#5/{{death.x}}/{{death.y}}/{{death.map_url}}" target="_blank" rel="noopener noreferrer">Full view</a>
      {% endif %}
    </div>
  </div>
  <div class="pda-card">
    <div class="pda-card__title">Time of Death</div>
    <div class="pda-card__body pda-card__body--padded pda-readout">
      {{death.tod}}
      <small>{{death.server}} - <a class="pda-link" href="{{path_for('round.single',{'id': death.round})}}">
        <i class="fas fa-circle"></i> {{death.round}}</a>
      </small>
    </div>
    <div style="padding: 0 18px 14px;">
      <a class="pda-button pda-button--accent" href="https://demo.hippiestation.com/?demo_url=https://logs.hippiestation.com/hippie_station/data/logs/{{death.demo_round_date}}/round-{{death.round_id}}/demo.txt.gz#{{death.ticktod}};{{death.x}}.50;{{death.y}}.50;{{death.x}},{{death.y}},{{death.z}};{{death.byondkey}}" target="_blank" rel="noopener noreferrer">
        Watch Replay <i class="fas fa-external-link-alt"></i>
      </a>
    </div>
  </div>
</div>

{% if death.last_words %}
<div class="pda-card">
  <div class="pda-card__title">Last Words</div>
  <div class="pda-card__body pda-card__body--padded">
    <blockquote class="pda-blockquote">
      <p>{{death.last_words}}</p>
      <footer>&mdash; {{macros.ckey(death.name, death.byondkey)}}, {{death.last_line}}</footer>
    </blockquote>
  </div>
</div>
{% endif %}

{% endblock %}
