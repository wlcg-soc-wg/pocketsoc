# PocketSOC v1.1 instructions

Check the most recent version [here](https://gist.github.com/drmcrooks/e7cc23fa1ba3831b71b60534a0ab0672) 

1. Start up VM. Initially configured with 6GB of RAM
    - increase this if possible; 8GB is a good value
    - The VM will run slowly with 4GB
2. Log into VM: `ssh -p 2222 pocketsoc@localhost`
    - Credentials: pocketsoc:pocketsoc
    - Port: 2222
3. Switch to root `sudo -s` 

4. Check access to MISP: [https://localhost:8443](https://localhost:8443)
    - You will need to accept the self-signed certificate warning
5. Check access to Kibana: [http://localhost:8080](http://localhost:8080)
    - It is possible that this will take longer to be available
    
6. Enter credentials for elastalert. The current rules use `telegram`
    - Sign up for Telegram
    - Follow instructions e.g. [here](https://qbox.io/blog/elastalert-telegram-alerting-elasticsearch) to create bot
        - Note the token
    - In Telegram, create "New Group"
    - Send a message to the group from yourself
    - Visit https://api.telegram.org/bot[BOT_TOKEN]/getUpdates
    - Find the chat.id (format "-xxxxxxxxx") - *not your id!*
7. Copy credentials to `elastalert`
    - Run `pocketsoc_elastalert_secrets` and follow instructions
8. Copy MISP Auth key into PocketSOC: `pocketsoc_authkey`
9. After a minute, check intel is being pulled correctly:`pocketsoc_zeek_intel` should display headings

10. Add event and object/attributes to MISP and publish
11. After a minute check that the attributes are pulled down: `pocketsoc_zeek_intel` and `pocketsoc_memcache`
    - Attributes are pulled every minute
    
12. Trigger "suspicious activity"
    - Connect to client: `pocketsoc_attach client`
    - Trigger activity: `/files/suspicious_activity.sh`

13. *Note*: If kibana index patterns have not been imported, repeat using `pocketsoc_importpatterns`

14. Install Elastiflow dashboards
    - Download the [dashboard file](https://raw.githubusercontent.com/robcowart/elastiflow/master/kibana/elastiflow.kibana.7.5.x.ndjson)
    - Visit Kibana [Management](http://localhost:8080/app/kibana#/management/kibana/objects?_g=())
    - Click "Import" and follow instructions
