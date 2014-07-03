include:
  - shinken.user
  - shinken.services

{% set enable = salt['pillar.get']('shinken:arbiter:enable', True) %}
{% set modules = salt['pillar.get']('shinken:arbiter:modules', []) %}

{% if enable %}

  {% for module in modules %}
shinken install {{ module }}:
  cmd.run:
    - unless: ls /var/lib/shinken/inventory/{{ module }}/package.json
    - user: shinken
    - watch_in:
      - service: shinken-arbiter
  {% endfor %}

/etc/shinken/arbiters/arbiter-master.cfg:
  file.managed:
    - user: shinken
    - group: shinken
    - template: jinja
    - source: salt://shinken/files/arbiter-master.cfg
    - watch_in:
      - service: shinken-arbiter

{% endif %}
