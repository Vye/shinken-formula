include:
  - shinken.user
  - shinken.services

{% set enable = salt['pillar.get']('shinken:poller:enable', True) %}
{% set modules = salt['pillar.get']('shinken:poller:modules', []) %}

{% if enable %}

  {% for module in modules %}
shinken install {{ module }}:
  cmd.run:
    - unless: ls /var/lib/shinken/inventory/{{ module }}/package.json
    - user: shinken
    - watch_in:
      - service: shinken-poller
  {% endfor %}

/etc/shinken/pollers/poller-master.cfg:
  file.managed:
    - user: shinken
    - group: shinken
    - template: jinja
    - source: salt://shinken/files/poller-master.cfg
    - watch_in:
      - service: shinken-poller

{% endif %}

# setup key authentication for ssh-dependent monitors
/home/shinken/.ssh:
  file.directory:
    - owner: shinken
    - group: shinken
    - mode: 700

{% if salt['pillar.get']('shinken:enable_ssh', False) %}
/home/shinken/.ssh/id_rsa:
  file.managed:
    - owner: shinken
    - group: shinken
    - mode: 600
    - contents_pillar: shinken:priv_key
{% endif %}

{% if salt['pillar.get']('shinken:pub_key') %}
/home/shinken/.ssh/id_rsa.pub:
  file.managed:
    - owner: shinken
    - group: shinken
    - mode: 644
    - contents_pillar: shinken:pub_key
{% endif %}
