#!/bin/bash
#content-type
CT="Content-Type:application/json"

#user and password credentials
USER="admin"
PASSWD="nutanix/4u"
echo $PASSWD

#services
SERVICE_URL="https://10.68.69.102:9440/PrismGateway/services/rest/v2.0"
RESPONSE_CODE="%{http_code}\n"

#resource
RESOURCE_VM="/vms/"
RESOURCE_SC="/storage_containers/"
RESOURCE_IM="/images/"

echo $SERVICE_URL$RESOURCE_VM
#get vms
VMs=$(curl --insecure -s -H $CT -X GET -u $USER:$PASSWD "$SERVICE_URL$RESOURCE_VM" | ./jq -r .entities[].name )
echo ""
echo "The vms are: "$VMs 
echo ""

#Pick VM
echo -ne "Enter vm for name change name\n"
read VM
VMuu=$(curl --insecure -s -H $CT -X GET -u $USER:$PASSWD "$SERVICE_URL$RESOURCE_VM" | ./jq -r '.entities[] | select(.name=="'$VM'")| .uuid ' ) 

echo -ne "Enter new name for VM "$VM"\n"
read NAME
# change name
VAR=$(curl --insecure -s -H $CT -X PUT -u $USER:$PASSWD "$SERVICE_URL$RESOURCE_VM$VMuu" -d '{ "name":"'$NAME'"}')
echo "Name changed for "$VM
