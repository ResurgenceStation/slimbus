<form action="{{path_for('library.delete',{'id': book.id})}}" method="POST" class="pda-library-delete">
  <input type="hidden" name="{{csrf.keys.name}}" value="{{csrf.name}}">
  <input type="hidden" name="{{csrf.keys.value}}" value="{{csrf.value}}">
{% if book.deleted %}
  <button class="pda-button pda-button--accent"><i class="fas fa-check"></i> Undelete Book</button>
{% else %}
  <button class="pda-button" style="color: var(--pda-danger); border-color: var(--pda-danger);"><i class="fas fa-times"></i> Delete Book</button>
{% endif %}
</form>
