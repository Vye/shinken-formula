{% set roles = grains.get('roles', {}) %}

{% if 'shinken.master' in roles %}
include:
  - shinken.master
{% else %}
  {% for role in roles %}   {# if not a master, apply other roles present #}
    {% if 'shinken.' in role %}   {# make sure only shinken roles are applied #}
      {% if loop.first %}
include:
      {% endif %}
  - {{ role }}
    {% endif %}
  {% endfor %}
{% endif %}
