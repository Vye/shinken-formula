include:
  - shinken/user

shinken_poller:
  ssh_auth:
    - present
    - user: shinken
    - contents_pillar: shinken:pub_key
