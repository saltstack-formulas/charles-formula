# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import charles with context %}

charles-package-repo-pkgrepo-absent:
  pkgrepo.absent:
    - name: {{ charles.pkg.repo.name }}
    - onlyif: {{ charles.pkg.repo and charles.pkg.use_upstream_repo }}
