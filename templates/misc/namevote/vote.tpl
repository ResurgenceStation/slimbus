{% extends "base/index.html"%}
{% block titlebar %}NAME RATER 5000{% endblock %}
{%block content %}
{% if not user %}
<h1>Hmm...</h1>
<p class="lead">You need to be logged in in order to vote on names</p>
<a href="{{path_for('auth')}}" class="pda-button pda-button--accent" style="display:block;">Authenticate</a>
{% else %}
<div class="modal fade show" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content pda-card">
      <div class="modal-header pda-card__title">
        <h5 class="modal-title" id="exampleModalCenterTitle">Hey! Listen!</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="background:none; border:none; color: var(--pda-fg);">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body pda-card__body pda-card__body--padded">
        This is <strong>JUST FOR FUN</strong>. Votes cast here will have no effect on policy and will not be used to change anything. If it becomes un fun it will be removed.
      </div>
      <div class="modal-footer pda-card__footer">
        <a href="#" class="pda-button pda-button--accent" data-dismiss="modal">I Understand This Is Just For Fun</a>
      </div>
    </div>
  </div>
</div>

<h1>Name Rater 5000</h1>

<div class="pda-namevote-nav">
  <a class="pda-button" href="{{path_for('nameVoter')}}">Vote on Names</a>
  <a class="pda-button" href="{{path_for('nameVoter.results',{'rank':'best'})}}">Best Names</a>
  <a class="pda-button" href="{{path_for('nameVoter.results',{'rank':'worst'})}}">Worst Names</a>
</div>

<p class="lead">Just for funsies*, select whether or not the name below is good or bad, in your opinion. Remember that we're simply judging the name, not the player behind the name.</p>

<div class="pda-card pda-namevote">
  <div class="pda-card__body pda-card__body--padded" style="text-align: center;">
    <h3>Is this a good name?</h3>
    <h1 class="pda-namevote__name" id="name">{{name.name}}</h1>
    <h2 id="job">({{name.job}})</h2>

    <form method="POST">
      <div class="pda-grid pda-grid--2" style="margin-top: 14px;">
        <button class="pda-button" style="color: var(--pda-danger); border-color: var(--pda-danger);" value="nay"><i class="fas fa-ban"></i> Bad Name</button>
        <button class="pda-button pda-button--accent" value="yea"><i class="fas fa-check"></i> Good Name</button>
      </div>
      <input type="hidden" name="name" value="{{name.name}}" id="nameField">
    </form>
  </div>
</div>

<p><small>* No action will be taken against anyone based on any votes cast here. Names are only being shown for the following jobs:</small></p>
<code>Assistant, Atmospheric Technician, Bartender, Botanist, Captain, Cargo Technician, Chaplain, Chemist, Chief Engineer, Chief Medical Officer, Cook, Curator, Detective, Geneticist, Head of Personnel, Head of Security, Janitor, Lawyer, Librarian, Medical Doctor, Quartermaster, Research Director, Roboticist, Scientist, Security Officer, Shaft Miner, Station Engineer, Virologist, Warden</code>
<p>Meaning antagonist roles, ghost spawns, etc are not being shown.</p>
<p>As species data is not tracked, there is no way to differentiate between human/lizard/moth/fly person names.</p>
<p>Duplicate votes are discarded, so don't worry if you see the same name twice.</p>
{% endif %}
{% endblock %}

{% block js %}
<script>
$('#exampleModalCenter').modal('toggle')
$('button').on('click', function(e){
  $('button').toggleClass('disabled')
  e.preventDefault();
  if('yea' == $(this).attr('value')){ vote = 'yea' } else { vote = 'nay' }
  name = $('#nameField').attr('value');
  $('#name').html("<i class='fas fa-cog fa-spin'></i>")
  $('#job').html("<i class='fas fa-cog fa-spin'></i>")
  data = { vote: vote, name: name }
  $.ajax({
    url: {{path_for('nameVoter.cast')}}/,
    method: 'post',
    data: data,
    dataType: 'json'
  }).done(function(r) {
    $('#name').html(r.name.name);
    $('#nameField').attr('value',r.name.name)
    $('#job').html(r.name.job);
    $('button').toggleClass('disabled')
  }).fail(function(r){
    console.log(r.responseText);
  })
});
</script>
{% endblock %}
