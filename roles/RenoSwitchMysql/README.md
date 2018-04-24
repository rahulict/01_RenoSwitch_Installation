Role Name
=========

This role will run 4 diffrent SQLs in MySQL database

Requirements
------------

MySQL DB must be up & running, however this role will start mysql service.
This role with read template ExecuteSQL.j2 & will generate shell script files/ExecuteSQL.sh,
which will be used to execute SQLs mentioned below in variable section.

Role Variables
--------------

   RenoSwitchDir: "{{ playbook_dir }}/Softwares/RenoSwitch"
   RenoSwitchUnzippedDir: "{{ RenoSwitchDir }}/Extracted"
   SQLFilesLocation: "{{ RenoSwitchUnzippedDir }}/setup-configurations/db-scripts"
   SQLs:
   - ripps-master
   - ripps-master-auditing
   - mc_schema
   - test-data

Dependencies
------------

Below Roles are needed:
1) RenoSwitchInstallDependencies
2) RenoSwitchDownloadPackage

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

- name: Main Playbook
  hosts: JenkinsServer
  gather_facts: false
  vars:
   RenoSwitchDir: "{{ playbook_dir }}/Softwares/RenoSwitch"
   RenoSwitchUnzippedDir: "{{ RenoSwitchDir }}/Extracted"
   SQLFilesLocation: "{{ RenoSwitchUnzippedDir }}/setup-configurations/db-scripts"
   MySQLFlag: False
   GigaSpaceKillFLag: False
   SQLs:
   - ripps-master
   - ripps-master-auditing
   - mc_schema
   - test-data

  tasks:
  - name: "Role: RenoSwitchMysql << MySQLFlag == {{ MySQLFlag }} (Task runs, if it is set as 'True') >>"
    include_role: name=RenoSwitchMysql
    when: MySQLFlag|upper == "TRUE"

License
-------

BSD

Author Information
------------------

Rahul Kumar << rahul.kumar@renovite.com >>
