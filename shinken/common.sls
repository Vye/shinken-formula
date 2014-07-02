{% from "shinken/map.jinja" import shinken with context %}

include:
  - shinken/user

# using pip right now because there are no RPMs for Shinken 2.0 
python-setuptools:
  pkg.installed
easy_install pip:
  cmd.run
pycurl:
  pip.installed:
    - bin_env: {{ shinken.pip }}
cherrypy:
  pip.installed:
    - bin_env: {{ shinken.pip }}
shinken:
  pip.installed:
    - bin_env: {{ shinken.pip }}

# setup shinken
shinken --init:
  cmd.run:
    - unless: ls /home/shinken/.shinken.ini
    - user: shinken
