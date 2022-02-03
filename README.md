# Project Title

Homework

## Description

 - to install database client on "app server"
 - to create table, generate sample data in database
 - to execute code to retrieve subset (first 100 rows) of generated data from database thought "app-server" in CSV format
 - store gathered data on ansible server file /tmp/gathered_data.csv
Information about table and generated sample data:
 - at least 3 columns: type of number, date, character (size 100 bytes)
 - data volume one million rows

## Getting Started

### Dependencies

* Ansible version 2.9.3
* DB server is Oracle 18c (and that means that there are used special features available starting 12.2)
  In sql files can see usage of identity column (to skip sequence creation or generating with own code number value)
  Can see "set markup csv on" to have nicely formated csv
  Can see usage "first rows only" instead of "where rownum < 101"
* For DB client instant client is used with version 21.5 (for task in question it was opted for small/efficient install)
* App server is Centos7 and it is expected that linux user for client installation is already present
* It is expected that db_user on oracle database with right privileges exists
  Minimum privileges for user: create session, create table, create sequence, quota on tablespace
  Under templates is sql script for creation, but it is not executed.
* sqlplus connects via tnsnames.ora, it is generated based on vars file.
* for the sake of simplicity password is not stored, but is asked to enter (better would be to have crypted variable with ansible-vault)

### Installing

* No special installation, regular ansible playbook
* Modify any variables under vars/main.yml to fit env needs
* included output example as gathering_data.csv
```
[homework]$ tree
.
├── CHANGELOG.md
├── gathered_data.csv
├── README.md
├── swed_hw
│   ├── defaults
│   ├── files
│   │   ├── instantclient-basiclite-linux.x64-21.5.0.0.0dbru.zip
│   │   ├── instantclient-sqlplus-linux.x64-21.5.0.0.0dbru.zip
│   │   └── sql
│   │       ├── demo_data.sql
│   │       └── export_data.sql
│   ├── handlers
│   ├── meta
│   ├── tasks
│   │   └── main.yml
│   ├── templates
│   │   ├── create_user.sql.j2
│   │   └── tnsnames.ora.j2
│   └── vars
│       └── main.yml
└── swed_hw.yml

9 directories, 12 files

```

### Executing program

* 
```
ansible-playbook swed_hw.yml -i "demo_appserver, " 
Enter password for oracle db user swed_hw: 

PLAY [SWED Home Work] ***************************************************************************************************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************************************************************************************************
ok: [demo_appserver]

TASK [swed_hw : Create /opt/oracle directory] ***************************************************************************************************************************************************************
changed: [demo_appserver]

TASK [swed_hw : Copy/extract db client] *********************************************************************************************************************************************************************
changed: [demo_appserver]

TASK [swed_hw : Copy/extract db client] *********************************************************************************************************************************************************************
changed: [demo_appserver]

TASK [swed_hw : Generate and copy tnsnames.ora] *************************************************************************************************************************************************************
changed: [demo_appserver]

TASK [swed_hw : Copy sql dir and files] *********************************************************************************************************************************************************************
changed: [demo_appserver]

TASK [swed_hw : Execute demo_data.sql using sqlplus] ********************************************************************************************************************************************************
changed: [demo_appserver]

TASK [swed_hw : debug] **************************************************************************************************************************************************************************************
ok: [demo_appserver] => {
    "sqlout.stdout": "\nTable created.\n\n\nCommit complete.\n\n\n1000000 rows created.\n\n\nCommit complete.\n\n\nPL/SQL procedure successfully completed."
}

TASK [swed_hw : Execute export_data.sql using sqlplus] ******************************************************************************************************************************************************
changed: [demo_appserver]

TASK [swed_hw : Copy gathered_data.csv] *********************************************************************************************************************************************************************
changed: [demo_appserver]

PLAY RECAP **************************************************************************************************************************************************************************************************
demo_appserver                 : ok=10   changed=8    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

## Authors

Created by Laura

