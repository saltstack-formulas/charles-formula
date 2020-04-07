# -*- coding: utf-8 -*-
# vim: ft=sls

             {%- if grains.os_family in ('MacOS',) %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import charles with context %}

include:
  -{{ ' .macapp' if charles.pkg.use_upstream_macapp else ' .package' }}

             {%- elif charles.pkg.use_upstream_archive %}
include:
  - .archive 
  - .config

             {%- else %}
include:
  - .package

             {%- endif %}
