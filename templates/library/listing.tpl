{% extends "base/index.html"%}
{% block pagetitle %}Library Catalog{% endblock %}
{% block titlebar %}LIBRARY{% endblock %}
{% block content %}
<h1>Library</h1>

<div class="pda-listing-toolbar">
  {% set vars = {
    'nbPages': library.pages,
    'currentPage': library.page,
    'url': library.url,
    'query': library.query
    }
  %}
  {% include 'components/pagination.html' with vars %}

  <form class="pda-library-search" action="{{path_for('library.index')}}" method="GET">
    <input name="query" class="pda-input pda-input--sm" type="text" value="{{library.search}}" placeholder="search">
    <button class="pda-button">Search</button>
  </form>
</div>

<table class="pda-table">
  <thead>
    <tr>
      <th><abbr title="Nanotrasen Book Number" data-toggle="tooltip">NTBN</abbr></th>
      <th>Title</th>
      <th>Author</th>
      <th>Category</th>
    </tr>
  </thead>
  <tbody>
  {% for book in books %}
    <tr{% if book.class == 'danger' %} class="pda-row--crashed"{% elseif book.class == 'warning' %} class="pda-row--ongoing"{% endif %}>
      <td>
        <a class="pda-link" href="{{path_for('library.single',{'id': book.id})}}">
          <i class="fas fa-book"></i> {{book.id}}
        </a>
      </td>
      <td>{{book.title|raw}}</td>
      <td>{{book.author}}</td>
      <td>{{book.category}}</td>
    </tr>
  {% endfor %}
  </tbody>
</table>

{% include 'components/pagination.html' with vars %}
{% endblock %}
