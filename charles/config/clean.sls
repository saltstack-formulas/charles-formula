# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import charles with context %}

    {%- if 'config' in charles and charles.config %}
           {%- set sls_package_clean = tplroot ~ '.archive.clean' %}
    {%- endif %}

include:
  - {{ sls_package_clean }}

charles-config-clean-file-absent:
  file.absent:
    - name: {{ charles.environ_file }}
    - require:
      - sls: {{ sls_package_clean }}
