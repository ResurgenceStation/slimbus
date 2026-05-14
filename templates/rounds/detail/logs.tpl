{% extends "index.tpl"%}
{% block titlebar %}ROUND #{{round.id}} / LOG FILES{% endblock %}
{% block content%}
{% include('rounds/html/basic.tpl') %}

<h3>Available log files</h3>
<ul class="pda-list-group list-group">
{% for file in round.logs %}
<a class="pda-list-group__item list-group-item" href="{{app.url}}round.php?round={{round.id}}&file={{file.fileName}}">{{file.fileName}}</a>
{% endfor %}
</ul>
{% endblock %}

{% block js %}
<script>
$.ajax({
  url: '{{app.url}}api/parsedLogStatus.php',
  data: { round: {{round.id}} },
  method: 'GET'
})
.done(function(e){
  if (e){
    $('#logStatus').toggleClass('btn-warning').toggleClass('disabled').toggleClass('btn-success').text('View parsed');
  } else {
    $('#logStatus').text('Parsing...');
    $.ajax({
      url: '{{app.url}}api/processRoundLogFile.php',
      data: { round: {{round.id}} },
      method: 'GET'
    })
    .done(function(e){
      $('#logStatus').toggleClass('btn-warning').toggleClass('disabled').toggleClass('btn-success').text('View parsed').attr('data-toggle','tooltip').attr('title',e);
    })
  }
});
</script>
{% endblock %}
