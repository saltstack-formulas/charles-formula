# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import charles with context %}

charles-package-archive-clean-file-absent:
  file.absent:
    - names:
      - {{ charles.pkg.archive.name }}
      - {{ charles.dir.tmp }}
