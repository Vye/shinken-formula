include:
  - shinken.user
  - shinken.services

{% set enable = salt['pillar.get']('shinken:broker:enable', True) %}
{% set modules = salt['pillar.get']('shinken:broker:modules', []) %}

{% if enable %}

  {% for module in modules %}
shinken install {{ module }}:
  cmd.run:
    - unless: ls /var/lib/shinken/inventory/{{ module }}/package.json
    - user: shinken
    - watch_in:
      - service: shinken-broker
  {% endfor %}

/etc/shinken/brokers/broker-master.cfg:
  file.managed:
    - user: shinken
    - group: shinken
    - template: jinja
    - source: salt://shinken/files/broker-master.cfg
    - watch_in:
      - service: shinken-broker

{% endif %}
