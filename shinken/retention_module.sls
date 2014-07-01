#TODO: Refactor this
# used for retention module
memcached:
  pkg:
    - installed
  service:
    - running
    - enable: True
