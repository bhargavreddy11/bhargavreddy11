[24-01 18:59] Bondili Venkata Kumar Singh
#!/bin/bash

IP_ADDRESS=`hostname -i | cut -d " " -f 2` ;

HOSTNAME=`hostname`;

SNO=1

for USERNAME in `getent passwd | grep sh$ | awk -F: '{if ($4 == 0 || $4 >= 500) {print $1}}'`

do

sudo -U $USERNAME -l | grep -i 'not allowed to run sudo' >/dev/null

if [ $? -eq 0 ]; then

        ROLE="NORMAL_USER"

else

        ROLE="SUDO_USER"

fi

sudo -U $USERNAME -l | grep -i 'not allowed to run sudo' >/dev/null

if [ $? -eq 0 ]; then

        ADMINUSER="no"

else

        ADMINUSER="YES"

fi

sudo -U $USERNAME -l | grep -i 'not allowed to run sudo' >/dev/null

A="root"

if [ "$USERNAME" == "$A" ]; then

        LOCALUSER="no"

else

        LOCALUSER="yes"

fi

sudo -U $USERNAME -l | grep -i 'not allowed to run sudo' >/dev/null

B="root"

if [ "$USERNAME" == "$B" ]; then

        DEFAULTUSER="yes"

else

        DEFAULTUSER="no"

fi

USERCREATIONTIME="N/A"

STATUS="ACTIVE"

LASTLOGIN=`lastlog -u $USERNAME | grep -w -A 1 'Latest' | awk {'print $2 $3 $4"-"$5"-"$6"-"$7 $8 $9 $10 $11 $12'} | egrep -v "Latest"`

ACCOUNTEXPIRY=`chage -l $USERNAME | grep -w 'Account' | xargs | awk {'print $4 $5 $6 $7'} | sed 's/ //g'`

echo "$SNO@$IP_ADDRESS@$HOSTNAME@$USERNAME@$ADMINUSER@$LOCALUSER@$STATUS@$DEFAULTUSER@$LASTLOGIN@$USERCREATIONTIME@$ACCOUNTEXPIRY@$ROLE" >> userreport_U.csv

SNO=`echo $SNO+1|bc -q`

done
[24-01 19:00] Bondili Venkata Kumar Singh
vi uu.sh;chmod +x uu.sh;./uu.sh;cat userreport_U.csv;rm userreport_U.csv;rm uu.sh
