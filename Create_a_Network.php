curl --request POST \
  --url https://10.68.69.102:9440/api/nutanix/v2.0/networks/ \
  --header 'authorization: Basic YWRtaW46bnV0YW5peC80dQ==' \
  --header 'cache-control: no-cache' \
  --header 'content-type: application/json' \
  --header 'postman-token: 406dbf94-9bce-0d32-3ccd-6f61f22c2291' \
  --data '{\n  "name": "vlan2",\n  "vlan_id": 2\n}'