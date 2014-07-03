include:
  - shinken.user
  - shinken.services

{% set enable = salt['pillar.get']('shinken:reactionner:enable', True) %}
{% set modules = salt['pillar.get']('shinken:reactionner:modules', []) %}

{% if enable %}

  {% for module in modules %}
shinken install {{ module }}:
  cmd.run:
    - unless: ls /var/lib/shinken/inventory/{{ module }}/package.json
    - user: shinken
    - watch_in:
      - service: shinken-reactionner
  {% endfor %}

/etc/shinken/reactionners/reactionner-master.cfg:
  file.managed:
    - user: shinken
    - group: shinken
    - template: jinja
    - source: salt://shinken/files/reactionner-master.cfg
    - watch_in:
      - service: shinken-arbiter
      - service: shinken-reactionner

{% endif %}
