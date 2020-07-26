# -*- coding: utf-8 -*-
# vim: ft=sls

  {%- if grains.os_family == 'MacOS' %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import charles with context %}

charles-macos-app-install-curl:
  file.directory:
    - name: {{ charles.dir.tmp }}
    - makedirs: True
    - clean: True
  pkg.installed:
    - name: curl
  cmd.run:
    - name: curl -Lo {{ charles.dir.tmp }}/charles-{{ charles.version }} {{ charles.pkg.macapp.source }}
    - unless: test -f {{ charles.dir.tmp }}/charles-{{ charles.version }}
    - require:
      - file: charles-macos-app-install-curl
      - pkg: charles-macos-app-install-curl
    - retry: {{ charles.retry_option }}

      # Check the hash sum. If check fails remove
      # the file to trigger fresh download on rerun
charles-macos-app-install-checksum:
  module.run:
    - onlyif: {{ charles.pkg.macapp.source_hash }}
    - name: file.check_hash
    - path: {{ charles.dir.tmp }}/charles-{{ charles.version }}
    - file_hash: {{ charles.pkg.macapp.source_hash }}
    - require:
      - cmd: charles-macos-app-install-curl
    - require_in:
      - macpackage: charles-macos-app-install-macpackage
  file.absent:
    - name: {{ charles.dir.tmp }}/charles-{{ charles.version }}
    - onfail:
      - module: charles-macos-app-install-checksum

charles-macos-app-install-macpackage:
  macpackage.installed:
    - name: {{ charles.dir.tmp }}/charles-{{ charles.version }}
    - store: True
    - dmg: True
    - app: True
    - force: True
    - allow_untrusted: True
    - onchanges:
      - cmd: charles-macos-app-install-curl
  file.append:
    - name: '/Users/{{ charles.identity.rootuser }}/.bash_profile'
    - text: 'export PATH=$PATH:/Applications/Charles.app/Contents/MacOS/Charles'
    - require:
      - macpackage: charles-macos-app-install-macpackage

    {%- else %}

charles-macos-app-install-unavailable:
  test.show_notification:
    - text: |
        The charles macpackage is only available on MacOS

    {%- endif %}
