{% extends "index.tpl"%}
{% block titlebar %}BOOK #{{book.id|default('?')}}{% endblock %}
{% block content %}
{% if book.deleted and not user.canAccessTGDB %}
  <div class="pda-card pda-card--deleted">
    <div class="pda-card__title">[Book Deleted]</div>
    <div class="pda-card__body pda-card__body--padded">
      <p class="text-muted text-center">&laquo; No content &raquo;</p>
    </div>
  </div>
{% else %}
  {% if book.deleted and user.canAccessTGDB %}
    <div class="pda-alert pda-alert--err"><strong>Deleted!</strong> This book has been deleted</div>
  {% endif %}
  <div class="pda-card pda-book">
    <div class="pda-card__title">
      {{book.title|raw}}
      <small class="text-muted">By {{book.author}}
        {% if user.canAccessTGDB %}
        | <a class="pda-link" href="{{path_for('player.single',{'ckey': book.ckey})}}">{{book.ckey}}</a>
        {% endif %}
      </small>
    </div>
    <div class="pda-card__body pda-card__body--padded pda-book__content">
      {{book.content|raw}}
    </div>
    <div class="pda-card__footer">
      Published {{book.datetime|timestamp}}
      {% if book.round_id_created %}
      during <a class="pda-link" href="{{path_for('round.single',{'id': book.round_id_created})}}"><i class="fas fa-circle"></i> {{book.round_id_created}}</a>
      {% endif %}
      {% if user.canAccessTGDB %}
        {% include 'library/html/delete.tpl' %}
      {% endif %}
    </div>
  </div>
{% endif %}
{% endblock %}
