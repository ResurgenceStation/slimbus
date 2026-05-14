{% set data = round.logs %}
<h2>Nanotrasen End Of Shift Report</h2>

{% set additional = attribute(data, 'additional data') %}
{% set integrity  = attribute(additional, 'station integrity') %}

<h3>Station Integrity: <code>{{integrity}}</code></h3>
{% if integrity < 90 %}
<div class="pda-alert pda-alert--err"><strong>Station Destroyed</strong> Loss Of Hull Accident Reported To Insurance Company - Terminate All Remaining Witnesses</div>
{% else %}
<div class="pda-alert pda-alert--ok"><strong>Station Intact</strong> Reassign Surviving Crewmembers After Debrief - Arrest Warrants Issued For Surviving Command Staff</div>
{% endif %}

{% if data.escapees %}
  <h3>Survivor Manifest</h3>
  <h4>Sapient Group</h4>
  <ul class="pda-list-group list-group">
  {% for index, human in data.escapees.humans %}
    <li class="pda-list-group__item list-group-item{% if 'Human' != human.species %} list-group-item-warning{% endif %}">
      <strong>{{human.name}}</strong>/<code>{{human.ckey}}</code> at {{human.location}}<br>
      <strong>Rank:</strong> {{human.job}} | <strong>Overall Health:</strong> {{human.health}}
      {% if human.health <= 0 %}<span class="pda-tag pda-tag--err">DOA - DELIVERED TO CLONING</span>{% endif %}
      {% if 'Human' != human.species %}<br><em>{{human.species|title}} Crewmember - Contract Terminated</em>{% endif %}
    </li>
  {% else %}
    <li class="pda-list-group__item list-group-item">No Survivors</li>
  {% endfor %}
  </ul>

  <h4>Silicon Group</h4>
  <ul class="pda-list-group list-group">
  {% for index, robot in data.escapees.silicons %}
    <li class="pda-list-group__item list-group-item">
      <strong>{{robot.name}}</strong>/<code>{{robot.ckey}}</code> at {{robot.location}}<br>
      <strong>Module:</strong> {{robot.module}} | <strong>Overall Health:</strong> {{robot.health}}
    </li>
  {% else %}
    <li class="pda-list-group__item list-group-item">No Survivors</li>
  {% endfor %}
  </ul>

  <h4>Other Group</h4>
  <ul class="pda-list-group list-group">
  {% for index, other in data.escapees.npcs %}
    <li class="pda-list-group__item list-group-item">{{index|title}} - {{other}}</li>
  {% else %}
    <li class="pda-list-group__item list-group-item">No Survivors</li>
  {% endfor %}
  </ul>
{% endif %}

{% if data.abandoned %}
<h3>Search And Rescue Report</h3>
  <h4>Sapient Group</h4>
  <ul class="pda-list-group list-group">
  {% for index, human in data.abandoned.humans %}
    <li class="pda-list-group__item list-group-item{% if 'Human' != human.species %} list-group-item-warning{% endif %}">
      <strong>{{human.name}}</strong>/<code>{{human.ckey}}</code> at {{human.location}}<br>
      <strong>Rank:</strong> {{human.job}} | <strong>Overall Health:</strong> {{human.health}}
      {% if human.health <= 0 %}<span class="pda-tag pda-tag--err">DECEASED</span>{% endif %}
      {% if 'Human' != human.species %}<br><em>Non-Human Crewmember - Contract Terminated</em>{% endif %}
    </li>
  {% else %}
    <li class="pda-list-group__item list-group-item">No Survivors</li>
  {% endfor %}
  </ul>

  <h4>Silicon Group</h4>
  <ul class="pda-list-group list-group">
  {% for index, robot in data.abandoned.silicons %}
    <li class="pda-list-group__item list-group-item">
      <strong>{{robot.name}}</strong>/<code>{{robot.ckey}}</code> at {{robot.location}}<br>
      <strong>Module:</strong> {{robot.module}} | <strong>Overall Health:</strong> {{robot.health}}
    </li>
  {% else %}
    <li class="pda-list-group__item list-group-item">No Survivors</li>
  {% endfor %}
  </ul>

  <h4>Other Group</h4>
  <ul class="pda-list-group list-group">
  {% for index, other in data.abandoned.npcs %}
    <li class="pda-list-group__item list-group-item">{{index|title}} - {{other}}</li>
  {% else %}
    <li class="pda-list-group__item list-group-item">No Survivors</li>
  {% endfor %}
  </ul>

  <h4>Additional Lifeforms Detected</h4>
  <ul class="pda-list-group list-group">
  {% for index, other in data.abandoned.others %}
    <li class="pda-list-group__item list-group-item">
      <strong>{{other.name}}</strong>/<code>{{other.ckey}}</code> at {{other.location}}<br>
      <strong>Rank:</strong> {{other.typepath}} | <strong>Overall Health:</strong> {{other.health}}
    </li>
  {% else %}
    <li class="pda-list-group__item list-group-item">No Survivors</li>
  {% endfor %}
  </ul>
{% endif %}

{% if data.ghosts %}
<h3>Supernatural Affairs Report</h3>
<ul class="pda-list-group list-group">
{% for ghost in data.ghosts %}
<li class="pda-list-group__item list-group-item">
   <strong>{{ghost.name}}</strong>/<code>{{ghost.ckey}}</code>
</li>
{% endfor %}
</ul>
{% endif %}
