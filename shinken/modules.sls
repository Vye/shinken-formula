{% set shinken = pillar.get('shinken', {}) %}

{% if 'modules' in shinken %}
  {% for module in shinken['modules'] %}

# Some packages have dependencies
    {% if module == 'retention-memcache' %}
memcached:
  pkg:
    - installed
  service:
    - running
    - enable: True

# Install module
shinken install {{ module }}:
  cmd.run:
    - unless: ls /var/lib/shinken/inventory/{{ module }}/package.json
    - user: shinken
    {% endif %}
  {% endfor %}
{% endif %}
