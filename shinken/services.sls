{% for service in [
    'arbiter',
    'broker',
    'poller',
    'reactionner',
    'receiver',
    'scheduler',
] %}

  {% set enable = salt['pillar.get']('shinken:' ~ service ~ ':enable', True) %}

  {% if enable %}
    {% set svc_state = 'running' %}
  {% else %}
    {% set svc_state = 'dead' %}
  {% endif %}

shinken-{{ service }}:
  service.{{ svc_state }}

{% endfor %}
