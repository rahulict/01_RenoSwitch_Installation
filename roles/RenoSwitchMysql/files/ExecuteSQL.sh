#!/bin/bash

#trap "echo; echo Errors captured while running SQL.; \
  #echo Check log files: /tmp/tmp-${1}.log and /tmp/tmp-${1}-error.log ; \
  #echo Exit code: $?; echo; exit 0" ERR

if test $# -ne 1
then
 echo This script requires atleast one argument.
 echo Valid Argument: Any sql script.
 echo Exiting...
 exit 1
fi

mysql --user=root --password=Reno@1234 < \
 /home/jenkins/Reno_DevOps_Tools/Ansible_Playbooks/01_Reno_Switch_Software_Installation/Softwares/SQLScriptDir/dev\ -db-scripts/${1}.sql \
 > /tmp/tmp-${1}.log 2> /tmp/tmp-${1}-error.log

if grep -v -e 'ERROR 1146' /tmp/tmp-${1}-error.log | grep 'ERROR ' > /dev/null
then
 echo -e " Errors captured while running SQL."
 echo -e " Check log files: /tmp/tmp-${1}.log and /tmp/tmp-${1}-error.log "
 set -x
  cat /tmp/tmp-${1}-error.log
 set +x
 exit 1
fi
