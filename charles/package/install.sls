# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import charles with context %}

    {%- if grains.os_family in ('Debian', 'RedHat',) and charles.pkg.use_upstream_repo %}

include:
  - .repo

charles-package-install-pkg-installed:
  pkg.installed:
    - name: {{ charles.pkg.name }}
    - reload_modules: true

    {%- elif grains.os_family == 'MacOS' %}

charles-package-install-cmd-run-cask:
  cmd.run:
    - name: brew cask install {{ charles.pkg.name }}
    - onlyif: test -x /usr/local/bin/brew

    {%- endif %}
