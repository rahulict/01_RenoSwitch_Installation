Playbook Name: "RenoSwitch installation Playbook"
=========

A brief description of the role goes here.
1) This playbook downloads DB scripts from BitBucket & then executes those scripts in MySQL database << only if, MySQLFlag=TRUE >>
2) It downloads RenoSwitch build (with perticular version) from artifactory.
4) In case above downloaded RenoSwitch build differs with currently running RenoSwitch software,
	it will stop that & its supporting components, clean directories, extract new build & then start following components in same sequence:-
	i)   Start Gigaspace Agent
	ii)  Check whether GSA has been started or not       << 10 times in every one second >>
	iii) Start Gigaspace Processing Unit
	iv)  Check whether GSP unit has been started or not  << 10 times in every one second >>
        v)   Run Config loader
        vi)  Finally start RenoSwitch
5) Other functionality: This Playbook can also restart RenoSwitch if we supply variable GigaSpaceKillFLag=TRUE explicitly. 

Requirements
------------

1) Java 1.8.0_161   << Required by RenoSwitch >>
2) put US_export_policy.jar , local_policy.jar in $JAVA_HOME/jre/lib/security/  << Required by RenoSwitch >>


Role Variables
--------------

  vars:
   SupportSoftDir: "{{ playbook_dir }}/Softwares/Supporting"
   SupportSoftUnzippedDir: "{{ SupportSoftDir }}/Extracted"
   RenoSwitchDir: "{{ playbook_dir }}/Softwares/RenoSwitch"
   RenoSwitchUnzippedDir: "{{ RenoSwitchDir }}/Extracted"
   GigaspaceDir: "{{ SupportSoftUnzippedDir }}/RippsLinuxSW/gigaspaces-xap-enterprise-12.1.1-ga-b17100"
   SQLScriptDir: "{{ playbook_dir }}/Softwares/SQLScriptDir"
   Artifactory_URL: "http://172.16.23.28:8081/artifactory"
   BitBucket_URL: "git@bitbucket.org:renoprod/reno-switch-db-scripts.git"
   RenoSwitchRelease: "1.0.0.0.27"
   MySQLFlag: False
   GigaSpaceKillFLag: False
   SQLs:
   - ripps-master
   - ripps-master-auditing
   - mc_schema
   - test-data

Dependencies
------------

Below Roles are being used in this playbook:-
RenoSwitchCheckGSAgent
RenoSwitchCheckGSProcessingUnit
RenoSwitchCleanDirExtractPKG
RenoSwitchCreateDirectories
RenoSwitchDownloadPackage
RenoSwitchInstallDependencies
RenoSwitchKillProcesses
RenoSwitchMysql
RenoSwitchStartConfigLoader
RenoSwitchStartGSAgent
RenoSwitchStartGSProcessingUnit
RenoSwitchStartRenoSwitch
RenoSwitchSupportingScripts

Author Information
------------------

Rahul Kumar << rahul.kumar@renovite.com >>

Version History
------------------

Version Modifier	Date		Comment
-----------------------------------------------
v1.0	Rahul Kumar	16/04/2018	Creation
