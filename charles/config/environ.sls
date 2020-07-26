# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import charles with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

    {%- if charles.environ and 'path' in charles.config %}
           {%- set sls_package_install = tplroot ~ '.archive.install' %}

include:
  - {{ sls_package_install }}

charles-config-file-managed-environ_file:
  file.managed:
    - name: {{ charles.environ_file }}
    - source: {{ files_switch(['environ.sh.jinja'],
                              lookup='charles-config-file-managed-environ_file'
                 )
              }}
    - mode: 640
    - user: {{ charles.identity.rootuser }}
    - group: {{ charles.identity.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
        path: {{ charles.config.path|json }}
        environ: {{ charles.environ|json }}
    - require:
      - sls: {{ sls_package_install }}

    {%- endif %}
