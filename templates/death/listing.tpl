{% extends "base/index.html"%}
{% block pagetitle %}Death Listing{% endblock %}
{% block titlebar %}DEATHS{% endblock %}
{% block content %}
<div class="pda-listing-toolbar">
  {% set vars = {
    'nbPages': death.pages,
    'currentPage': death.page,
    'url': death.url
    }
  %}
  {% include 'components/pagination.html' with vars %}

  <div class="pda-listing-toolbar__meta">
    <a class="pda-button pda-button--accent" href="{{path_for('death.lastwords')}}">
      <i class="fas fa-quote-left"></i> Some famous last words
    </a>
  </div>
</div>

<table class="pda-table">
  {% include 'death/html/table-header.html' %}
  <tbody>
  {% for death in deaths %}
    {% include 'death/html/listingrow.tpl' %}
  {% endfor %}
  </tbody>
</table>

{% include 'components/pagination.html' with vars %}
{% endblock %}
