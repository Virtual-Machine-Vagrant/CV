{%- if salt['pillar.get']('pip:installed') %}
  {%- for pip in salt['pillar.get']('pip:installed') %}
pip-{{ pip }}-installed:
  pip.installed:
    - name: {{ pip }}
    - require:
      - sls: pkg
  {% endfor %}
{%- endif %}