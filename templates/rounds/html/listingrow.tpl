<tr class="table-{{round.class}}">
  <td class="win95-nowrap">
    <a href="{{path_for('round.single',{'id': round.id})}}"><strong>#{{round.id}}</strong></a>
  </td>
  <td>
    {% if round.newscaster %}
      <span title="Has newscaster stories" style="float:right;">[news]</span>
    {% endif %}
    {{round.mode}}
  </td>
  <td>{{round.result}}</td>
  <td>{{round.map}}</td>
  <td class="win95-mono win95-nowrap">{{round.start_datetime}}</td>
  <td class="win95-nowrap">{{round.duration}}</td>
  <td class="win95-mono win95-nowrap">
    {# Three-tier end-time display, matching upstream Statbus. #}
    {% if round.end_datetime and round.shutdown_datetime %}
      {{round.end_datetime}}
      <small class="win95-muted">Shutdown: {{round.shutdown_datetime}}</small>
    {% elseif round.shutdown_datetime %}
      {{round.shutdown_datetime}}
    {% else %}
      <span class="win95-muted">Server crashed &mdash; no end timings</span>
    {% endif %}
  </td>
  <td>{{round.server}}</td>
</tr>
