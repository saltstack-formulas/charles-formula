# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import charles with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

charles-package-archive-install-extract:
  pkg.installed:
    - names:
      - curl
      - tar
      - gzip
  file.directory:
    - name: {{ charles.pkg.archive.name }}
    - user: {{ charles.rootuser }}
    - group: {{ charles.rootgroup }}
    - mode: 755
    - makedirs: True
    - require_in:
      - archive: charles-package-archive-install-extract
    - recurse:
        - user
        - group
        - mode
  archive.extracted:
    {{- format_kwargs(charles.pkg.archive) }}
    - archive_format: {{ charles.pkg.format }}
    - retry: {{ charles.retry_option }}
    - user: {{ charles.rootuser }}
    - group: {{ charles.rootgroup }}
