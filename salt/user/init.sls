{% set user = salt['pillar.get']('user') %}
{% set admin = salt['pillar.get']('admin') %}

create_user:
  user.present:
   # - shell: /bin/bash
   # - home:  /home/{{ user }}
   # - uid:   1000
   # - gid:   1000
    - name:     {{ user }}
    - password: $y$j9T$o2Nw55z5p6lU29.PnnILc7Xk$LK9epAt40VqbxNEW76d9E4U2rW9ahJTYUpfFN/8YC21
    - groups:
      - wheel

{% if admin %}
create_group_netuser:
  group.present:
    - name: netuser
    - gid: 1100
    - members:
      - {{ user }}
{% endif %}

ssh_authorized_keys:
  ssh_auth.manage:
    - user: {{ user }}
    - enc:  ssh-ed25519
    - ssh_keys:
      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIUe9W/59j6yBXx0FTOWKpKTPXciGMw746ZErf7d8EJt leif.liddy@black.example.com
      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN4NU5CHu4XAkia/J6NSrunmffKa3Vq+GBL7tXDx91fJ leif.liddy@cloud.leifliddy.com
      - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGdpPv6AUY3uOJRiK5ukdCYsmrr/6RWWR3lssVWVKsNG leif.liddy@mac.example.com

create_bashrc_d:
  file.directory:
    - name:  /home/{{ user }}/.bashrc.d
    - user:  {{ user }}
    - group: {{ user }}
    - mode:  755

deploy_bashrc_default:
  file.managed:
    - name:   /home/{{ user }}/.bashrc.d/default
    - source: salt://files/bashrc_default_user
    - user:   {{ user }}
    - group:  {{ user }}
    - mode:   644

deploy_bashrc_podman:
  file.managed:
    - name:   /home/{{ user }}/.bashrc.d/podman
    - source: salt://files/bashrc_podman
    - user:   {{ user }}
    - group:  {{ user }}
    - mode:   644

deploy_bashrc_rpmbuild:
  file.managed:
    - name:   /home/{{ user }}/.bashrc.d/rpmbuild
    - source: salt://files/bashrc_rpmbuild
    - user:   {{ user }}
    - group:  {{ user }}
    - mode:   644

deploy_bashrc_git:
  file.managed:
    - name:   /home/{{ user }}/.bashrc.d/git
    - source: salt://files/bashrc_git
    - user:   {{ user }}
    - group:  {{ user }}
    - mode:   644

deploy_vimrc:
  file.managed:
    - name:   /home/{{ user }}/.vimrc
    - source: salt://files/vimrc
    - user:   {{ user }}
    - group:  {{ user }}
    - mode:   644

deploy_rpmmacros:
  file.managed:
    - name:   /home/{{ user }}/.rpmmacros
    - source: salt://files/rpmmacros
    - user:   {{ user }}
    - group:  {{ user }}
    - mode:   644
