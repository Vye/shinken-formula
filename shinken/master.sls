include:
  - shinken/common
  - shinken/retention_module
  - shinken/packs

shinken_master:
  service:
    - name: shinken
    - running
    - enable: True

shinken-arbiter:    # used for watch
  service.running

# monitor all minions
{% for _, keys in
    salt['publish.publish'](
        '*',
        'grains.item',
        ['fqdn', 'fqdn_ip4', 'roles']).iteritems() %}

/etc/shinken/hosts/{{ keys['fqdn'] }}.cfg:
  file.managed:
    - source: salt://shinken/files/host.cfg
    - watch_in:
      - service: shinken-arbiter
    - template: jinja
    - context:
        hostname: {{ keys['fqdn'] }}
        ip: {{ keys['fqdn_ip4'] }}

# if minion has shinken roles, apply them
  {% if 'roles' in keys %}
    {% if 'poller' in keys['roles'] %}
/etc/shinken/pollers/{{ keys['fqdn'] }}.cfg:
  file.managed:
    - source: salt://shinken/files/poller.cfg
    - watch_in:
      - service: shinken-arbiter
    - template: jinja
    - context:
      hostname: {{ keys['fqdn'] }}
      ip: {{ keys['fqdn_ipv4'] }}
    {% endif %}
  {% endif %}

{% endfor %}
