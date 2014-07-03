include:
  - shinken.user
  - shinken.services

{% set enable = salt['pillar.get']('shinken:receiver:enable', True) %}
{% set modules = salt['pillar.get']('shinken:receiver:modules', []) %}

{% if enable %}

  {% for module in modules %}
shinken install {{ module }}:
  cmd.run:
    - unless: ls /var/lib/shinken/inventory/{{ module }}/package.json
    - user: shinken
    - watch_in:
      - service: shinken-receiver
  {% endfor %}

/etc/shinken/receivers/receiver-master.cfg:
  file.managed:
    - user: shinken
    - group: shinken
    - template: jinja
    - source: salt://shinken/files/receiver-master.cfg
    - watch_in:
      - service: shinken-receiver

{% endif %}
