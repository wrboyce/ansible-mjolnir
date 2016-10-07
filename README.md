wrboyce.mjolnir
===============

[![Build Status](https://travis-ci.org/wrboyce/ansible-mjolnir.svg)](https://travis-ci.org/wrboyce/ansible-mjolnir)

Install and Configure Mjolnir.app

Requirements
------------

* [Homebrew](http://brew.sh)

Dependencies
------------

Variable `user_username` must be set.

Example Playbook
----------------

    - hosts: servers
      roles:
         - wrboyce.mjolnir

License
-------

Apache 2.0
