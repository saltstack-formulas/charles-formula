# -*- coding: utf-8 -*-
# vim: ft=yaml
---
charles:
  version: 4.5.6
  pkg:
       {%- if grains.os_family in ('Debian', 'RedHat') %}
    use_upstream_repo: true
       {%- else %}
    use_upstream_repo: false
       {%- endif %}
