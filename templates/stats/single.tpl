{% extends "base/index.html"%}
{% block pagetitle %}Round #{{round.id}}{% endblock %}
{% block titlebar %}STAT / {{stat.key_name|upper}} / ROUND #{{round.id}}{% endblock %}
{% block content %}
<h2><code>{{stat.key_name}}</code>
  <small>
    <a class="pda-link" href="{{path_for('round.single',{'id':round.id})}}">
      <i class="fas fa-circle"></i> {{round.id}}
    </a>
  </small>
</h2>

{% if stat.label.splain %}
<div class="pda-alert pda-alert--info" role="alert">{{stat.label.splain}}</div>
{% endif %}

{% include ['stats/single/' ~ stat.key_name ~'-' ~ stat.version ~'.tpl', 'stats/single/' ~ stat.key_name ~'.tpl','stats/type/' ~ stat.key_type ~'.tpl', 'stats/generic.tpl'] %}

<h3>Stat Metadata</h3>
<table class="pda-table pda-table--keyvalue">
  <tbody>
    <tr><th>Stat ID</th><td>{{stat.id}}</td><th>Stat Type</th><td><code>{{stat.key_type}}</code></td></tr>
    <tr><th>Stat Name</th><td><code>{{stat.key_name}}</code></td><th>Timestamp Recorded</th><td>{{stat.datetime}}</td></tr>
    <tr><th>Stat Version</th><td>{{stat.version}}</td><th>Raw JSON</th><td><pre>{{stat.json}}</pre></td></tr>
  </tbody>
</table>

{% endblock %}
