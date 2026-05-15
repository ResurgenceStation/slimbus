<tr class="table-{{round.class}}">
  <td class="win95-nowrap">
    <a href="{{path_for('round.single',{'id': round.id})}}"><i class="fas fa-circle"></i> <strong>#{{round.id}}</strong></a>
  </td>
  <td>
    {% if round.newscaster %}
      <span title="Has newscaster stories" style="float:right;"><i class="far fa-newspaper"></i></span>
    {% endif %}
    <i class="fas fa-fw fa-{{round.icons.mode}}"></i> {{round.mode}}
  </td>
  <td><i class="fas fa-fw fa-{{round.icons.result}}"></i> {{round.result}}</td>
  <td>{{round.map}}</td>
  <td class="win95-mono win95-nowrap">{{round.start_datetime}}</td>
  <td class="win95-nowrap">{{round.duration}}</td>
  <td class="win95-mono win95-nowrap">
    {# Three-tier end-time display, matching upstream Statbus. #}
    {% if round.end_datetime and round.shutdown_datetime %}
      {{round.end_datetime}}
      <div class="win95-muted" style="font-size:11px;">Shutdown: {{round.shutdown_datetime}}</div>
    {% elseif round.shutdown_datetime %}
      {{round.shutdown_datetime}}
    {% else %}
      <span class="win95-muted"><i class="fas fa-skull-crossbones"></i> Server crashed</span>
    {% endif %}
  </td>
  <td>{{round.server}}</td>
</tr>
