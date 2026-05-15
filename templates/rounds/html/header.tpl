<div class="win95-section">
  <div class="win95-section__title">
    <span>Round #{{round.id}} &middot; {{round.map}}</span>
    <small>{{round.server}}</small>
  </div>
  <div class="win95-section__body">
    <div class="win95-grid win95-grid--3">
      <div>
        <div class="win95-muted"><small>Mode</small></div>
        <div><strong>{{round.mode}}</strong></div>
      </div>
      <div class="win95-center">
        <div class="win95-muted"><small>Result</small></div>
        <div><strong>{{round.result}}</strong></div>
      </div>
      <div class="win95-right">
        <div class="win95-muted"><small>Duration</small></div>
        <div><strong>{{round.duration}}</strong></div>
      </div>
    </div>
    <hr>
    <div class="win95-mono" style="font-size:11px;">
      <strong>Started</strong> {{round.start_datetime}}
      {# Three-tier end-time display, matching upstream Statbus. #}
      {% if round.end_datetime and round.shutdown_datetime %}
        &middot; <strong>Ended</strong> {{round.end_datetime}} <span class="win95-muted">(Shutdown {{round.shutdown_datetime}})</span>
      {% elseif round.shutdown_datetime %}
        &middot; <strong>Shutdown</strong> {{round.shutdown_datetime}}
      {% else %}
        &middot; <span class="win95-muted">Server crashed &mdash; no end timings</span>
      {% endif %}
    </div>
  </div>
</div>
