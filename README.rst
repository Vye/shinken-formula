===============
shinken-formula
===============

Formula to setup and configure Shinken.

**WARNING**: At the time of writing, this formula has not been tested in production.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

System Requirements
===================

This formula has only been tested on RHEL6. Contributions are welcome.

Available states
================

.. contents::
    :local:

``shinken``
-----------

Decide which states to apply based on shinken roles defined in ``grains['roles']``.

``shinken.common``
------------------

Configures user, installs Shinken 2.0 (via pip atm...), initalizes shinken CLI

``shinken.master``
------------------

Applies the states to configure shinken master.

Adds a host config for all minions (Linux only, for now).

Adds minions with Shinken roles defined to master.

``shinken.poller``
------------------

Manages shinken-poller service, sets up ssh keys for monitors that depend on ssh.

``shinken.node``
------------------

Add shinken user and public key for monitors that depend on ssh.
