# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import charles with context %}
{%- from tplroot ~ "/macros.jinja" import format_kwargs with context %}

charles-package-repo-pkgrepo-managed:
  pkgrepo.managed:
    {{- format_kwargs(charles.pkg.repo) }}
    - onlyif: {{ charles.pkg.repo and charles.pkg.use_upstream_repo }}
