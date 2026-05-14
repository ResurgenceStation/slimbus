{% extends "index.tpl"%}
{% block titlebar %}ROLES / {{player.ckey|upper}}{% endblock %}
{% block content %}
<h2>{{player.label|raw}}</h2>
<p>Current range: <strong><code>{{start}} - {{end}}</code></strong></p>

<form class="pda-card pda-roles-form">
  <div class="pda-card__body pda-card__body--padded">
    <div id="slider" class="pda-slider"></div>

    <div class="pda-grid pda-grid--2" style="margin-top: 12px;">
      <input type="text" class="pda-input" placeholder="Start Date" id="start" name="start">
      <input type="text" class="pda-input" placeholder="End Date" id="end" name="end">
    </div>

    <button type="submit" class="pda-button" style="margin-top: 12px;">Apply Range</button>
  </div>
</form>

<h3>Role Time</h3>
<div class="pda-card pda-chart">
  <div class="pda-card__body pda-card__body--padded">
    <div id="roletime"></div>
  </div>
</div>

{% endblock %}
{% block js %}
<script src="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/11.1.0/nouislider.min.js" integrity="sha256-IB524Svhneql+nv1wQV7OKsccHNhx8OvsGmbF6WCaM0=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/11.1.0/nouislider.min.css" integrity="sha256-tkYpq+Xdq4PQNNGRDPtH3G55auZB4+kh/RA80Abngaw=" crossorigin="anonymous" />
<script>
  function timestamp(str){
    return new Date(str).getTime();
  }

  function formatToYMD(date) {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();
    if (month.length < 2) month = '0' + month;
    if (day.length < 2) day = '0' + day;
    return [year, month, day].join('-');
  }
  min = timestamp('{{min}}')
  max = timestamp('{{max}}')
  start = timestamp('{{start}}')
  end   = timestamp('{{end}}')
  noUiSlider.create(slider, {
    start: [start, end],
    connect: true,
    range: {
      'min': min,
      'max': max
    },
  });
  slider.noUiSlider.on('update', function( values, handle ) {
    var dateValues = [
      document.getElementById('start'),
      document.getElementById('end')
    ];
    var start = Number(values[0]);
    var end =   Number(values[1]);
    dateValues[handle].value = formatToYMD(new Date(+values[handle]));
  });
</script>
<script type="text/javascript" src="https://cdn.plot.ly/plotly-latest.min.js"></script>

<script>
/* PDA-themed Plotly layout. Reads colour vars off the live body
 * so amber / cyan palette switches also retint the chart. */
function getPdaVar(name) {
  return getComputedStyle(document.body).getPropertyValue(name).trim();
}
var pdaFg     = getPdaVar('--pda-fg')        || '#00ff7f';
var pdaFgDim  = getPdaVar('--pda-fg-dim')    || '#00cc66';
var pdaBg     = getPdaVar('--pda-bg-elevated') || '#00321a';
var pdaBorder = getPdaVar('--pda-border')    || '#00aa55';

var data = {{player.role_time|raw}};
var jobs = unpack(data,'job');
var minutes = unpack(data,'minutes');
var trace1 = {
  x: jobs,
  y: minutes,
  type: 'bar',
  name: 'Minutes',
  marker: { color: pdaFg }
}

var layout = {
  title: { text: 'Role Time (Minutes)', font: { color: pdaFg, family: 'VT323, monospace' } },
  paper_bgcolor: 'transparent',
  plot_bgcolor: pdaBg,
  font: { color: pdaFgDim, family: 'VT323, monospace' },
  xaxis: { gridcolor: pdaBorder, linecolor: pdaBorder, tickfont: { color: pdaFgDim } },
  yaxis: { gridcolor: pdaBorder, linecolor: pdaBorder, tickfont: { color: pdaFgDim } }
};
var data = [trace1]
Plotly.newPlot('roletime',data, layout)
</script>
{% endblock %}
