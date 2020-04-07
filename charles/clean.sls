# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import charles with context %}

             {%- if grains.os_family in ('MacOS',) %}
include:
  -{{ ' .macapp.clean' if charles.pkg.use_upstream_macapp else ' .package.clean' }}

             {%- elif charles.pkg.use_upstream_archive %}
include:
  - .archive.clean
  - .config.clean

             {%- else %}
include:
  - .package.clean

             {%- endif %}
