include:
  - shinken.services

/etc/shinken/modules/webui.cfg:
  file.managed:
    - user: shinken
    - group: shinken
    - template: jinja
    - source: salt://shinken/files/webui.cfg
    - watch_in:
      - service: shinken-arbiter
