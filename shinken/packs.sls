{% set packs = salt['pillar.get']('shinken:packs', {}) %}

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
{% endfor %}
