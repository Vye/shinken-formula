{% from "shinken/map.jinja" import shinken with context %}

{% set modules = salt['pillar.get']('shinken:modules', {}) %}

{% for module in modules %}

# Some packages have dependencies
  {% if module == 'retention-memcache' %}
memcached:
  pkg:
    - installed
  service:
    - running
    - enable: True
  {% endif %}

  {% if module == 'webui' %}
cherrypy:
  pip.installed:
    - bin_env: {{ shinken.pip }}
  {% endif %}

# Install module
shinken install {{ module }}:
  cmd.run:
    - unless: ls /var/lib/shinken/inventory/{{ module }}/package.json
    - user: shinken

{% endfor %}
