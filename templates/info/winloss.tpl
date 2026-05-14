{% extends "index.tpl"%}
{% block titlebar %}WIN / LOSS RATIOS{% endblock %}
{% block content %}
<h2>Historical Gamemode Win/Loss Ratios</h2>
<p>Current range: <strong><code>{{start}} - {{end}}</code></strong></p>

<form class="pda-card pda-card__body--padded pda-winloss-form">
  <div id="slider" class="pda-slider"></div>

  <div class="pda-grid pda-grid--2" style="margin-top: 12px;">
    <input type="text" class="pda-input" placeholder="Start Date" id="start" name="start">
    <input type="text" class="pda-input" placeholder="End Date" id="end" name="end">
  </div>

  <button type="submit" class="pda-button" style="margin-top: 12px;">Apply Range</button>
</form>

{% set current = '' %}
<div class="pda-card">
{% for m in modes %}
  {% if current != m.game_mode %}
  {% set current = m.game_mode %}
    </ul>
  </div>
  <div class="pda-card" id="{{m.game_mode}}">
    <div class="pda-card__title">
      <a class="pda-link" href="#{{m.game_mode}}">{{m.game_mode|title}}</a>
    </div>
    <ul class="pda-list-group list-group">
  {% endif %}

    {% if 'halfwin' in m.game_mode_result %}
      <li class="pda-list-group__item list-group-item list-group-item-warning">
    {% elseif 'loss' in m.game_mode_result %}
      <li class="pda-list-group__item list-group-item list-group-item-danger">
    {% elseif 'win' in m.game_mode_result %}
      <li class="pda-list-group__item list-group-item list-group-item-success">
    {% else %}
      <li class="pda-list-group__item list-group-item list-group-item-warning">
    {% endif %}
      <span class="pda-tag">{{m.rounds}}</span> {{m.game_mode_result|title}} | Average duration: {{m.duration}} minutes
    </li>
{% endfor %}
</ul>
</div>
{% endblock %}
{% block js %}
<script src="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/11.1.0/nouislider.min.js" integrity="sha256-IB524Svhneql+nv1wQV7OKsccHNhx8OvsGmbF6WCaM0=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/11.1.0/nouislider.min.css" integrity="sha256-tkYpq+Xdq4PQNNGRDPtH3G55auZB4+kh/RA80Abngaw=" crossorigin="anonymous" />
<script>
  function timestamp(str){ return new Date(str).getTime(); }
  function formatToYMD(date) {
    var d = new Date(date), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear();
    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;
    return [year, month, day].join('-');
  }
  min = timestamp('{{min}}')
  max = timestamp('{{max}}')
  start = timestamp('{{start}}')
  end   = timestamp('{{end}}')
  noUiSlider.create(slider, {
    start: [start, end], connect: true,
    range: { 'min': min, 'max': max },
  });
  slider.noUiSlider.on('update', function( values, handle ) {
    var dateValues = [ document.getElementById('start'), document.getElementById('end') ];
    var start = Number(values[0]); var end = Number(values[1]);
    dateValues[handle].value = formatToYMD(new Date(+values[handle]));
  });
</script>
{% endblock %}
