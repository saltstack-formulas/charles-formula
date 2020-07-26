# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import charles with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

charles-package-archive-install:
  pkg.installed:
    - names:
      - curl
      - tar
      - gzip
  file.directory:
    - name: {{ charles.pkg.archive.name }}
    - user: {{ charles.identity.rootuser }}
    - group: {{ charles.identity.rootgroup }}
    - mode: 755
    - makedirs: True
    - require_in:
      - archive: charles-package-archive-install
    - recurse:
        - user
        - group
        - mode
  archive.extracted:
    {{- format_kwargs(charles.pkg.archive) }}
    - archive_format: {{ charles.pkg.format }}
    - retry: {{ charles.retry_option }}
    - user: {{ charles.identity.rootuser }}
    - group: {{ charles.identity.rootgroup }}

charles-archive-install-file-symlink-charles:
  file.symlink:
    - name: {{ charles.linux.symlink }}
    - target: {{ charles.pkg.archive.name }}/{{ charles.command }}
    - force: True
    - require:
      - archive: charles-package-archive-install
    - unless:
      - {{ charles.linux.altpriority|int > 0 }}
      - {{ grains.os_family|lower in ('windows', 'arch',) }}
