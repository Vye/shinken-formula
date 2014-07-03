include:
  - shinken.user

{% set enable = salt['pillar.get']('shinken:enable_ssh', False) %}

{% if enable %}
shinken_poller:
  ssh_auth:
    - present
    - user: shinken
    - contents_pillar: shinken:pub_key
{% endif %}
