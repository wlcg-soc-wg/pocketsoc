#! /usr/bin/python

import requests
from requests.packages.urllib3.exceptions import InsecureRequestWarning
from pymemcache.client.base import Client
requests.packages.urllib3.disable_warnings(InsecureRequestWarning)
import json

client = Client(('memcached', 11211)) #Location of memached application

host="misp"
key="XXXXXXXX"

def misppull():
    headers = {
            'Authorization': key,
            'Accept': 'application/json',
            'Content-type': 'application/json',
             }

    data = '{"returnFormat":"json","type": {"OR": ["ip-src","ip-dst"]},"to_ids":"yes","publish_timestamp":"30d"}' #Setting up the data format we require from MISP

    response = requests.post('https://'+host+'/attributes/restSearch', headers=headers, data=data, verify=False) #Call to MISP API
    return response


if __name__ == '__main__':
    response = misppull()
    output=json.loads(response.text)
    attributes=output[u'response'][u'Attribute']
    for attribute in attributes:
        attribute_type=attribute[u'type']
        value=attribute[u'value']
        event="event_"+attribute[u'event_id']
        client.set(attribute_type+"-"+value, event+" ("+attribute_type+")", 300)
