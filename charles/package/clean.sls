# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import charles with context %}

    {%- if grains.os_family in ('Debian', 'RedHat',) and charles.pkg.use_upstream_repo %}

include:
  - .repo.clean

charles-package-remove-pkg-removed:
  pkg.removed:
    - name: {{ charles.pkg.name }}
    - reload_modules: true

    {%- elif grains.os_family == 'MacOS' %}

charles-package-remove-cmd-run-cask:
  cmd.run:
    - name: brew cask remove {{ charles.pkg.name }}
    - runas: {{ charles.identity.rootuser }}
    - onlyif: test -x /usr/local/bin/brew

    {%- endif %}
