include:
  - shinken.user
  - shinken.services

{% set enable = salt['pillar.get']('shinken:scheduler:enable', True) %}
{% set modules = salt['pillar.get']('shinken:scheduler:modules', []) %}

{% if enable %}

  {% for module in modules %}
    {% if module == 'retention-memcache' %}
python-memcached:
  pkg.installed
    {% endif %}

shinken install {{ module }}:
  cmd.run:
    - unless: ls /var/lib/shinken/inventory/{{ module }}/package.json
    - user: shinken
    - watch_in:
      - service: shinken-arbiter
  {% endfor %}

/etc/shinken/schedulers/scheduler-master.cfg:
  file.managed:
    - user: shinken
    - group: shinken
    - template: jinja
    - source: salt://shinken/files/scheduler-master.cfg
    - watch_in:
      - service: shinken-arbiter

{% endif %}