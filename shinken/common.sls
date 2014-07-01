include:
  - shinken/user

# using pip right now because there are no RPMs for Shinken 2.0 
python-pip:
  pkg.installed
pycurl:
  pip.installed
cherrypy:
  pip.installed
shinken:
  pip:
    - installed

# setup shinken
shinken --init:
  cmd.run:
    - unless: ls /home/shinken/.shinken.ini
    - user: shinken
