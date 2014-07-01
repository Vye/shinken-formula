include:
  - shinken/common
  - shinken/packs

shinken-poller:
  service:
    - running
    - enable: True

# setup key authentication for ssh-dependent monitors
/home/shinken/.ssh:
  file.directory:
    - owner: shinken
    - group: shinken
    - mode: 700
/home/shinken/.ssh/id_rsa:
  file.managed:
    - owner: shinken
    - group: shinken
    - mode: 600
    - contents_pillar: shinken:priv_key
/home/shinken/.ssh/id_rsa.pub:
  file.managed:
    - owner: shinken
    - group: shinken
    - mode: 644
    - contents_pillar: shinken:pub_key
