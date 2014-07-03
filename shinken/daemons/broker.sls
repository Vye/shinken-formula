include:
  - shinken.user
  - shinken.services
  - shinken.conf

{% set enable = salt['pillar.get']('shinken:broker:enable', True) %}
{% set modules = salt['pillar.get']('shinken:broker:modules', []) %}

{% if enable %}

  {% for module in modules %}
shinken install {{ module }}:
  cmd.run:
    - unless: ls /var/lib/shinken/inventory/{{ module }}/package.json
    - user: shinken
    - watch_in:
      - service: shinken-arbiter
      {# this isn't gonna float... will need to refactor as I go. #}
      {# need to be able to watch file so it doesn't get blown away by install #}
      {% if module == 'webui' %} {#TODO: fix me #}
      - file: /etc/shinken/modules/webui.cfg
      {% endif %}
  {% endfor %}

/etc/shinken/brokers/broker-master.cfg:
  file.managed:
    - user: shinken
    - group: shinken
    - template: jinja
    - source: salt://shinken/files/broker-master.cfg
    - watch_in:
      - service: shinken-arbiter

{% endif %}
