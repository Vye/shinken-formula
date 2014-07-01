{% set roles = grains.get('roles', {}) %}

include:
{% if 'shinken_master' in roles %}
  - shinken.master
{% else %}
  {% for role in roles %}   {# if not a master, apply other roles present #}
    {% if 'shinken.' in role %}   {# make sure only shinken roles are applied #}
  - {{ role }}
    {% endif %}
  {% endfor %}
{% endif %}
