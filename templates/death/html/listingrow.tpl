{% set rowclass = '' %}
{% if death.class == 'danger' %}{% set rowclass = 'pda-row--crashed' %}{% elseif death.class == 'warning' %}{% set rowclass = 'pda-row--ongoing' %}{% endif %}
<tr class="{{rowclass}}" data-id="{{death.id}}">
  <td>
    <a class="pda-link" href="{{path_for('death.single',{'id': death.id})}}">
      <i class="fas fa-skull-crossbones"></i> {{death.id}}
    </a>
  </td>
  <td>
    {{death.name}} - {{death.job}}
    {% if death.special %}<span class="pda-tag pda-tag--err">{{death.special}}</span>{% endif %}
    <br>
    <small>
    {% if user.level >= 2 %}
      <a class="pda-link" href="{{app.url}}tgdb/player.php?ckey={{death.byondkey}}">{{death.byondkey}}</a>
    {% else %}
      {{death.byondkey}}
    {% endif %}
    </small>
  </td>
  <td>
    {{death.mapname}} - {{death.pod}} ({{death.x}}, {{death.y}}, {{death.z}})<br>
    {% if death.last_words %} <small><em>{{death.last_words}}</em></small> {% endif %}
  </td>
  <td>
    {{death.tod|timestamp}}<br>
    <small><a class="pda-link" href="{{path_for('round.single',{'id': death.round})}}"><i class="far fa-circle"></i> {{death.round}}</a> - {{death.server}}</small>
  </td>
  <td>
    {% include 'death/html/vitals.html' %}
  </td>
</tr>
