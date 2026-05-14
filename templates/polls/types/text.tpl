{# Poll text-response results (PDA-themed). #}
{% for r in poll.results %}
{% if r.replytext == 'ABSTAIN' %}
  <p class="text-center text-muted">&laquo; Abstained &raquo;</p>
{% else %}
  <dl class="pda-poll-response" id="{{r.id}}">
    <dt>
      {{r.datetime}}<br>
      <a class="pda-link" href="#{{r.id}}">#{{r.id}}</a>
    </dt>
    <dd>
      <blockquote class="pda-blockquote">
        {{r.replytext|nl2br}}
      </blockquote>
    </dd>
  </dl>
{% endif %}
{% endfor %}
