{% from "shinken/map.jinja" import shinken with context %}

include:
  - shinken.services
  - shinken.conf

{% set enable = salt['pillar.get']('shinken:webui:enable', False) %}
{% set modules = salt['pillar.get']('shinken:webui:modules', []) %}

{% if enable %}
cherrypy:
  pip.installed:
    - bin_env: {{ shinken.pip }}

  {% for module in modules %}
shinken install {{ module }}:
  cmd.run:
    - unless: ls /var/lib/shinken/inventory/{{ module }}/package.json
    - user: shinken
    - watch_in:
      - file: /etc/shinken/modules/webui.cfg
  {% endfor %}

{% endif %}
