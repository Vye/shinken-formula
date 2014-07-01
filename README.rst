===============
shinken-formula
===============

Formula to setup and configure Shinken.

**WARNING**: At the time of writing, this formula has not been tested in production.

See the full `Salt Formulas installation and usage instructions <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

`Shinken
<http://www.shinken-monitoring.org/>`_

System Requirements
===================

This formula has only been tested on RHEL6. Contributions are welcome.

Getting Started
===============

Setup Master
------------

#. Add ``shinken.master`` to ``roles`` grain.
#. If using SSH based monitors, create an ssh key for the poller like seen in `shinken_master <shinken_master.example>`_ and `shinken_node <shinken_node.example>`_.

Monitor Minions
---------------

Basic monitors can be automatically generated for minions that allow the Shinken Master to make ``grains.item`` calls via `Peer Communication <http://docs.saltstack.com/en/latest/ref/peer.html>`_.

#. Make sure the minions have access to the pillar key ``shinken:ssh_pub``.
#. For SSH based monitors, apply the ``shinken.node`` state to desired minions via topfile.

Available States
================

.. contents::
    :local:

``shinken``
-----------

Decides which states to apply based on shinken roles defined in ``grains['roles']``.

``shinken.common``
------------------

Configures user, installs Shinken 2.0 (via pip atm...), initalizes shinken CLI.

``shinken.master``
------------------

Applies the states to configure shinken master.

Adds a host config for all minions (Linux only, for now).

Adds minions with Shinken roles defined to master.

*Note: this state may not be combined with other role states (poller, scheduler, etc.).*

``shinken.poller``
------------------

Manages shinken-poller service, sets up ssh keys for monitors that depend on ssh.

``shinken.node``
------------------

Add shinken user and public key for monitors that depend on ssh.
