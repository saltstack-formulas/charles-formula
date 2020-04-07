# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.os_family == 'MacOS' %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import charles with context %}

charles-macos-app-clean-files:
  file.absent:
    - names:
      - {{ charles.dir.tmp }}
      - /Applications/Charles

    {%- else %}

charles-macos-app-clean-unavailable:
  test.show_notification:
    - text: |
        The charles macpackage is only available on MacOS

    {%- endif %}
