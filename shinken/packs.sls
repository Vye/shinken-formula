{% set packs = salt['pillar.get']('shinken:packs', {}) %}

{# This file manages packs that do not need to be
explicitly loaded via daemon or module config #}

include:
  - shinken.services

{% for pack in packs %}

# Some packages have dependencies
  {% if pack == 'linux-ssh' %}
# required by linux-ssh pack
python-paramiko:
  pkg.installed
sysstat:
  pkg.installed
ntp:
  pkg.installed
   {% endif %}
  
# Install pack
shinken install {{ pack }}:
  cmd.run:
    - unless: ls /var/lib/shinken/inventory/{{ pack }}/package.json
    - user: shinken
    - watch_in:
      - service: shinken-arbiter
{% endfor %}
