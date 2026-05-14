<tr class="table-{{round.class}}">
  <td>
      <a href="{{path_for('round.single',{'id': round.id})}}">
        <i class="fas fa-circle"></i> {{round.id}}
      </a>
  </td>
  <td>
    {% if round.newscaster %}
      <p class="float-right mb-0" data-toggle="tooltip" title="Newscaster stories!"><i class="far fa-newspaper"></i></p>
    {% endif %}
    <i class="fas fa-fw fa-{{round.icons.mode}}"></i> {{round.mode}}</td>
  <td><i class="fas fa-fw fa-{{round.icons.result}}"></i> {{round.result}}</td>
  <td>{{round.map}}</td>
  <td>{{round.start_datetime}}</td>
  <td>{{round.duration}}</td>
  <td>
    {# Three-tier end-time display, matching upstream Statbus.            #}
    {# end_datetime is written by SetRoundEnd during declare_completion;  #}
    {# shutdown_datetime is written by SSdbcore.Shutdown during           #}
    {# Master.Shutdown on world.Reboot. Both may be set, only one, or     #}
    {# neither -- the round-end DM path determines which.                 #}
    {% if round.end_datetime and round.shutdown_datetime %}
      {{round.end_datetime}}
      <small class="d-block text-muted">Shutdown: {{round.shutdown_datetime}}</small>
    {% elseif round.shutdown_datetime %}
      {{round.shutdown_datetime}}
    {% else %}
      <span class="text-muted"><i class="fas fa-skull-crossbones"></i> Server crashed - No end timings</span>
    {% endif %}
  </td>
  <td>{{round.server}}</td>
</tr>
