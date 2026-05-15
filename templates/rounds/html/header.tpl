<div class="win95-section">
  <div class="win95-section__title">
    <span><i class="fas fa-circle"></i> Round #{{round.id}} &middot; {{round.map}}</span>
    <small>{{round.server}}</small>
  </div>
  <div class="win95-section__body">
    <div class="win95-grid win95-grid--3">
      <div>
        <div class="win95-muted" style="font-size:11px;text-transform:uppercase;letter-spacing:.05em;">Mode</div>
        <div><i class="fas fa-{{round.icons.mode}}"></i> <strong>{{round.mode}}</strong></div>
      </div>
      <div class="win95-center">
        <div class="win95-muted" style="font-size:11px;text-transform:uppercase;letter-spacing:.05em;">Result</div>
        <div><i class="fas fa-{{round.icons.result}}"></i> <strong>{{round.result}}</strong></div>
      </div>
      <div class="win95-right">
        <div class="win95-muted" style="font-size:11px;text-transform:uppercase;letter-spacing:.05em;">Duration</div>
        <div><i class="fas fa-stopwatch"></i> <strong>{{round.duration}}</strong></div>
      </div>
    </div>
    <hr>
    {# Three-tier end-time display, matching upstream Statbus.
       Each timestamp gets its own line for readability. #}
    <div class="win95-mono" style="font-size:12px;line-height:1.6;">
      <div><i class="fas fa-play"></i> <strong>Started</strong> {{round.start_datetime}}</div>
      {% if round.end_datetime %}
        <div><i class="fas fa-flag-checkered"></i> <strong>Ended</strong> {{round.end_datetime}}</div>
      {% endif %}
      {% if round.shutdown_datetime %}
        <div><i class="fas fa-power-off"></i> <strong>Shutdown</strong> {{round.shutdown_datetime}}</div>
      {% endif %}
      {% if not round.end_datetime and not round.shutdown_datetime %}
        <div><span class="win95-muted"><i class="fas fa-skull-crossbones"></i> Server crashed &mdash; no end timings recorded</span></div>
      {% endif %}
    </div>
  </div>
</div>
