{# PDA-themed round detail header (Stage 3 migration).
   Replaces the Bootstrap row/col layout with a pda-card laid out
   like a PDA "session info" header: identifier on the left,
   primary status in the middle, secondary metadata on the right.
   Three-tier end-time display (Stage 0) preserved. #}
<div class="pda-card pda-round-header">
  <div class="pda-round-header__id">
    <i class="fas fa-circle"></i> ROUND #{{round.id}}
    <div class="pda-round-header__map"><small>{{round.map}}</small></div>
  </div>

  <div class="pda-round-header__status">
    <div class="pda-round-header__mode">
      <i class="fas fa-{{round.icons.mode}}"></i> {{round.mode|upper}}
    </div>
    <div class="pda-round-header__result">
      <span class="pda-tag pda-tag--{{round.class == 'danger' ? 'err' : (round.class == 'warning' ? 'warn' : 'ok')}}">
        <i class="fas fa-{{round.icons.result}}"></i> {{round.result|upper}}
      </span>
    </div>
    <div class="pda-round-header__timing">
      <small>
        Started {{round.start_datetime}},
        {% if round.end_datetime and round.shutdown_datetime %}
          Ended {{round.end_datetime}} (Shutdown: {{round.shutdown_datetime}})
        {% elseif round.shutdown_datetime %}
          Shutdown {{round.shutdown_datetime}}
        {% else %}
          <span class="pda-tag pda-tag--err">Server crashed - No end timings</span>
        {% endif %}
      </small>
    </div>
  </div>

  <div class="pda-round-header__meta">
    <div class="pda-round-header__server">{{round.server}}</div>
    <div class="pda-round-header__duration">{{round.duration}}</div>
  </div>
</div>
