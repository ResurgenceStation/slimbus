<h3>Crew Manifest</h3>
<p class="text-muted">In no particular order</p>
<table class="pda-table sort">
  <thead>
    <tr>
      <th>ckey</th>
      <th>Name</th>
      <th>Job</th>
      <th>Role</th>
      <th>Roundstart?</th>
    </tr>
  </thead>
  <tbody>
    {% for c in crew %}
      <tr class="{% if c.role %}pda-row--crashed{% endif %}">
        <td>
        {% if user.canAccessTGDB %}
          <a class="pda-link" href="tgdb/player.php?ckey={{c.ckey}}">{{c.ckey}}</a>
        {% else %}
          {{c.ckey}}
        {% endif %}
        </td>
        <td>{{c.name}}</td>
        <td>{{c.job}}</td>
        <td>{{c.role}}</td>
        <td>
          {% if c.roundstart %}
            <span class="pda-tag pda-tag--ok">Roundstart</span>
          {% else %}
            <span class="pda-tag pda-tag--warn">Latejoin</span>
          {% endif %}
        </td>
      </tr>
    {% endfor %}
  </tbody>
</table>
