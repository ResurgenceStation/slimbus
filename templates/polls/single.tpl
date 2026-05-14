{% extends "index.tpl"%}
{% block titlebar %}POLL #{{poll.id}}{% endblock %}
{% block content%}
<h4>
  <small class="text-muted">#{{poll.id}} {{poll.createdby_ckey}} asks:</small><br>
  {{poll.question|nl2br}}
</h4>

<div class="pda-poll-meta">
  <div class="pda-poll-meta__cell">
    <strong>Started</strong>
    <div class="pda-readout">{{poll.starttime|timestamp|raw}}</div>
  </div>
  <div class="pda-poll-meta__cell">
    <strong>Duration</strong>
    <div class="pda-readout">{{poll.duration}}</div>
  </div>
  <div class="pda-poll-meta__cell">
    <strong>Responses</strong>
    <div class="pda-readout">
      {{poll.totalVotes}}
      {% if poll.filtered %}
      <br><small>Does NOT reflect filtered votes!</small>
      {% endif %}
    </div>
  </div>
  <div class="pda-poll-meta__cell">
    <strong>Ended</strong>
    <div class="pda-readout">{{poll.endtime|timestamp|raw}}</div>
  </div>
</div>

{% if poll.ended %}
<div class="pda-alert pda-alert--info">This poll has ended</div>
{% endif %}

{% if poll.filtered %}
<div class="pda-alert pda-alert--err"><strong>VIEWING FILTERED RESULTS</strong></div>
{% endif %}

{% if poll.polltype == 'TEXT' %}
  {% include 'polls/types/text.tpl' %}
{% elseif poll.polltype == 'MULTICHOICE' %}
  {% include 'polls/types/option.tpl' %}
{% elseif poll.polltype == 'OPTION' %}
  {% include 'polls/types/option.tpl' %}
{% elseif poll.polltype == 'IRV' %}
  {% include 'polls/types/irv.tpl' %}
{% endif %}

{% endblock %}
