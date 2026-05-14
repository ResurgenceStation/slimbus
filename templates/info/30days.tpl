{% extends "base/index.html"%}
{% block titlebar %}30-DAY PLAY MINUTES{% endblock %}
{% block content %}
<div class="pda-card pda-chart">
  <div class="pda-card__body pda-card__body--padded" style="height: 400px;">
    <canvas id="minutes" width="400" height="400"></canvas>
  </div>
</div>
<p class="text-muted">
  This chart shows the accumulated time spent in the Living role (i.e. alive and playing) and the Ghost role (i.e. dead or observing) over the last 30 days, across all servers.
</p>
{% endblock %}

{% block js %}
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
<script>
function pdaVar(name, fallback) {
  return getComputedStyle(document.body).getPropertyValue(name).trim() || fallback;
}
var pdaFg     = pdaVar('--pda-fg',         '#00ff7f');
var pdaAccent = pdaVar('--pda-accent',     '#d4ff00');
var pdaFgDim  = pdaVar('--pda-fg-dim',     '#00cc66');
var pdaBorder = pdaVar('--pda-border',     '#00aa55');

var data = {{minutes|raw}}
var minutes = { living: [], ghost: [], dates: [] };
data.forEach(function(row){
  if(row.job == 'Living'){ minutes.living.push(row.minutes); minutes.dates.push(row.date); }
  if(row.job == 'Ghost'){ minutes.ghost.push(row.minutes); }
})

var ctx = document.getElementById('minutes').getContext('2d');
var myChart = new Chart(ctx, {
    type: 'line',
    data: {
      labels: minutes.dates,
      datasets: [{
        data: minutes.living,
        label: "Living Minutes",
        borderColor: pdaFg,
        backgroundColor: pdaFg,
        fill: false
      },
      {
        data: minutes.ghost,
        label: "Ghost Minutes",
        borderColor: pdaAccent,
        backgroundColor: pdaAccent,
        fill: false
      }]
    },
    options: {
      maintainAspectRatio: false,
      tooltips: { mode: 'index', intersect: true },
      scales: {
        xAxes: [{
          type: 'time',
          time: { unit: 'day' },
          gridLines: { color: pdaBorder },
          ticks: { fontColor: pdaFgDim, fontFamily: 'VT323, monospace' }
        }],
        yAxes: [{
          gridLines: { color: pdaBorder },
          ticks: { fontColor: pdaFgDim, fontFamily: 'VT323, monospace' }
        }]
      },
      legend: { labels: { fontColor: pdaFgDim, fontFamily: 'VT323, monospace' } },
      elements: { line: { tension: 0 } }
    }
});
</script>
{% endblock %}
