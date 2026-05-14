<h3>Newscaster Logs</h3>

{% for channel in round.logs %}
<div class="pda-card pda-newscaster">
  <div class="pda-card__title">
    {{attribute(channel, 'channel name')}} <small class='text-muted'>{{channel.author}}</small>
  </div>
  <ul class="pda-list-group list-group">
  {% for m in channel.messages %}
    <li class="pda-list-group__item list-group-item pda-newscaster__post" id="{{m.id}}">
      <div class="pda-newscaster__post-header">
        <h5>{{m.author}}</h5>
        <small class="text-muted">
          <a class="pda-link" href="#{{m.id}}">{{attribute(m, 'time stamp')}}</a>
        </small>
      </div>
      {% if attribute(m, 'photo file') %}
      <img class="pda-newscaster__photo" width='256' height='256' src="data:image/png;base64,{{attribute(m, 'photo file')}}" />
      {% endif %}
      <p>{{m.body|raw}}</p>
      {% if m.comments %}
        <ul class="pda-bulletlist">
        {% for c in m.comments %}
          <li><strong>{{c.author}}</strong>: {{c.body}}</li>
        {% endfor %}
        </ul>
      {% endif %}
    </li>
  {% endfor %}
  </ul>
</div>
{% endfor %}
