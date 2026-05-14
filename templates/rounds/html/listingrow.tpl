{# PDA-themed round listing row (Stage 3 migration).
   Built on top of the Stage 0 three-tier end-time display.
   Row class hints at round state:
     * round.class is set by Round::parseRound() in the model
       (legacy Bootstrap colour name -- danger / success / warning).
       Mapped to pda-row--crashed / pda-row--ongoing / default below
       via a small switch so the row colour reads as PDA state. #}
{% set rowclass = '' %}
{% if not round.end_datetime and not round.shutdown_datetime %}
  {% set rowclass = 'pda-row--crashed' %}
{% elseif round.class == 'danger' %}
  {% set rowclass = 'pda-row--crashed' %}
{% elseif round.class == 'warning' %}
  {% set rowclass = 'pda-row--ongoing' %}
{% endif %}
<tr class="{{rowclass}}">
  <td>
    <a class="pda-link" href="{{path_for('round.single',{'id': round.id})}}">
      <i class="fas fa-circle"></i> {{round.id}}
    </a>
  </td>
  <td>
    {% if round.newscaster %}
      <span class="pda-tag pda-tag--ok" title="Newscaster stories!"><i class="far fa-newspaper"></i> NEWS</span>
    {% endif %}
    <i class="fas fa-fw fa-{{round.icons.mode}}"></i> {{round.mode}}
  </td>
  <td><i class="fas fa-fw fa-{{round.icons.result}}"></i> {{round.result}}</td>
  <td>{{round.map}}</td>
  <td>{{round.start_datetime}}</td>
  <td>{{round.duration}}</td>
  <td>
    {# Three-tier end-time display, matching upstream Statbus (Stage 0). #}
    {% if round.end_datetime and round.shutdown_datetime %}
      {{round.end_datetime}}
      <small class="d-block text-muted">Shutdown: {{round.shutdown_datetime}}</small>
    {% elseif round.shutdown_datetime %}
      {{round.shutdown_datetime}}
    {% else %}
      <span class="pda-tag pda-tag--err"><i class="fas fa-skull-crossbones"></i> CRASHED</span>
    {% endif %}
  </td>
  <td>{{round.server}}</td>
</tr>
