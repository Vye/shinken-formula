{% from "shinken/map.jinja" import shinken with context %}

include:
  - shinken.services

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
      - service: shinken-broker
  {% endfor %}

/etc/shinken/modules/webui.cfg:
  file.managed:
    - user: shinken
    - group: shinken
    - template: jinja
    - source: salt://shinken/files/webui.cfg
    - watch_in:
      - service: shinken-broker

{% endif %}
