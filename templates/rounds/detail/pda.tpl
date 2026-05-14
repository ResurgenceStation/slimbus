<h3>PDA Logs</h3>
<p class="text-muted">In no particular order</p>
<table class="pda-table sort">
  <thead>
    <tr>
      <th>Timestamp</th>
      <th>Sender</th>
      <th>Device</th>
      <th>Message</th>
      <th>Recipient</th>
    </tr>
  </thead>
  <tbody>
    {% for d in round.logs %}
      <tr id="{{d.id}}">
        <td>
          <a class="pda-link" href="#{{d.id}}">{{d.date}}</a><br>
          <small>{{d.coords.x}},{{d.coords.y}},{{d.coords.z}}</small>
        </td>
        <td>{{d.sender.name}}<br>
          <small>{{d.sender.ckey}}</small>
        </td>
        <td>{{d.sender.device}}</td>
        <td>{{d.message|raw}}</td>
        <td>{{d.recipient.name}}<br>
          <small>{{d.recipient.job}}</small></td>
      </tr>
    {% endfor %}
  </tbody>
</table>
