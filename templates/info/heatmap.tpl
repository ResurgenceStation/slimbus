{% extends "base/index.html"%}
{% block titlebar %}SERVER POPULATION (30 DAYS){% endblock %}
{% block content %}

{% if fromCache %}
<div class="pda-alert pda-alert--info">This data was loaded from a cached file</div>
{% endif %}

<div class="pda-card pda-chart">
  <div class="pda-card__body pda-card__body--padded">
    <div id="population"></div>
  </div>
</div>
<p class="text-muted">
  This chart shows the average number of players, admins, and completed rounds, by hour, across all servers, for the last 30 days.
</p>
{% endblock %}

{% block js %}
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script>
function pdaVar(name, fallback) {
  return getComputedStyle(document.body).getPropertyValue(name).trim() || fallback;
}
var pdaFg     = pdaVar('--pda-fg',         '#00ff7f');
var pdaAccent = pdaVar('--pda-accent',     '#d4ff00');
var pdaInfo   = pdaVar('--pda-info',       '#6cf2ff');
var pdaFgDim  = pdaVar('--pda-fg-dim',     '#00cc66');
var pdaBorder = pdaVar('--pda-border',     '#00aa55');
var pdaBg     = pdaVar('--pda-bg-elevated','#00321a');

var json = {{data|raw}}
var options = {
  chart: {
    type: 'line',
    height: 512,
    background: 'transparent',
    foreColor: pdaFgDim,
    fontFamily: 'VT323, monospace',
    animations: { enabled: false }
  },
  colors: [pdaFg, pdaAccent, pdaInfo],
  series: [
    { name: 'Players', data: unpack(json, 'players') },
    { name: 'Admins',  data: unpack(json, 'admins')  },
    { name: 'Rounds',  data: unpack(json, 'rounds')  }
  ],
  xaxis: {
    type: "datetime",
    categories: unpack(json, 'date'),
    labels: { style: { colors: pdaFgDim } },
    axisBorder: { color: pdaBorder },
    axisTicks:  { color: pdaBorder }
  },
  yaxis: { labels: { style: { colors: pdaFgDim } } },
  grid: { borderColor: pdaBorder },
  tooltip: {
    theme: 'dark',
    x: { format: 'dd MMM yyyy HH:00' }
  },
  legend: { labels: { colors: pdaFgDim } }
}
var chart = new ApexCharts(document.querySelector("#population"), options);
chart.render();
</script>
{% endblock %}
