#!/bin/bash
#content-type
CT="Content-Type:application/json"

#user and password credentials
USER="admin"
PASSWD=“nutanix/4u”

#services
SERVICE_URL="https://10.68.69.102:9440/PrismGateway/services/rest/v2.0"
RESPONSE_CODE="%{http_code}\n"

#resource
RESOURCE_VM="/vms/"
RESOURCE_SC="/storage_containers/"
RESOURCE_IM="/images/"


#get storage container
STORAGE=$(curl --insecure -s -H $CT -X GET -u $USER:$PASSWD "$SERVICE_URL$RESOURCE_SC" | ./jq -r .entities[].name)
echo ""
echo "The storage containers are: "$STORAGE 
echo ""

#Pick container
echo -ne "Enter container name\n"
read CONTAINER

#get container uuid
STORAGEc=$(curl --insecure -s -H $CT -X GET -u $USER:$PASSWD "$SERVICE_URL$RESOURCE_SC" | ./jq -r ".entities[] | select(.name==\"$CONTAINER\") | .storage_container_uuid")

#Get compression
COMP=$(curl --insecure -s -H $CT -X GET -u $USER:$PASSWD "$SERVICE_URL$RESOURCE_SC$STORAGEc" | ./jq -r .compression_enabled) 
echo "Compression is: "$COMP" for "$CONTAINER
echo ""
echo -ne "Turn compression on for "$CONTAINER"(y/n)?\n"
read PROMPT
if [ "$PROMPT" == "y" ]
    then
    #turn compression on
    VAR=$(curl --insecure -s -H $CT -X PUT -u $USER:$PASSWD "$SERVICE_URL$RESOURCE_SC" -d '{ "compression_enabled":true,"name":"'$CONTAINER'","storage_container_uuid":"'$STORAGEc'" }')
    echo "Compression enabled for "$CONTAINER
fi




