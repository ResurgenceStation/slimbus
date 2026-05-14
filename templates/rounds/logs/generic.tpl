<table class="pda-table">
  <thead>
    <tr>
      <th>Timestamp</th>
      <th>uid</th>
      <th>X</th>
      <th>Y</th>
      <th>Z</th>
      <th>Content</th>
    </tr>
  </thead>
  <tbody>
  {% for line in file %}
    <tr>
      <td>{{line.timestamp}}</td>
      <td style="background: #{{line.color}}"><code class="bg">{{line.device}}</code></td>
      <td>{{line.x}}</td>
      <td>{{line.y}}</td>
      <td>{{line.z}}</td>
      <td>{{line.text|raw}}</td>
    </tr>
  {% endfor %}
  </tbody>
</table>
