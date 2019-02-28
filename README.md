# PocketSOC

## Introduction

A test, **non-production** SOC demonstrator, intended to track the lifecycle of an event for demonstration purposes, as well as acting as a testbed for new technologies. For instructions for the VM installation, click [here](VM.md)

## Quickstart

The individual steps and scripts used in this guide will be explored in more detail elsewhere.

- Clone repo:
```
git clone https://gitlab.cern.ch/wlcg-soc-wg/PocketSOC.git
```
- Inside repo, run `./pocketsoc_start_local` to 
	- pull in submodules
	  - docker-elk
	  - elastiflow
	  - misp-docker
	- set up the networking
	- patch the misp-web Dockerfile to personalise our instance and deploy other minor changes
	- set up the Docker volumes for the submodules
		- misp-web
		- misp-db
		- elasticsearch
		- logstash
		- kibana
		- elastiflow
    - build the docker images
      - this will take some time initially if starting from scratch
- Following build, containers will be automatically started
- Visit `127.0.0.1:8040` to see MISP login page
	- Log in with `admin@admin.test:admin` and change password
      - Administration ->
      - List Users ->
      - Copy `Authkey` for `admin`
- Visit `127.0.0.1:8060` to see Kibana front page
	-  After a brief wait to allow Elasticsearch to ingest data, set up indexes
		- Discover -\>
		- `Index pattern`: logstash\*
		- Next step -\>
		- Select `@timestamp` from dropdown menu
		- Create index pattern -\>
		- Discover -\>
		- For example, choose fields of interest
- Use  `./pocketsoc_attach client` to access the client container and access the traffic sources. 
- To use Elastiflow, once logstash-flow starts up fully, you need to add the kibana dashboards. Download the appropriately versioned JSON file from [here](https://github.com/robcowart/elastiflow/tree/master/kibana) and upload via the kibana web interface (this will hopefully be included during startup in a future release)

### Troubleshooting

- If containers don't start properly, `Ctrl-C` to stop containers, and re-run `docker-compose up` (particularly if you see error messages like "could not connect to database")
- Make sure you're in the `PocketSOC` directory proper - there are other `docker-compose.yml` files in the `misp-docker` subdirectory (the XME misp-docker repo) and `docker-elk` subdirectory, but we override this with different network settings to make our cluster work.

## Environment

Environment variables recognised by the deployment scripts:

### SOCDIR

Defines the base directory for the pocketsoc installation. In the VM version, this is `/development/PocketSOC/`. The `_local` wrapper scripts described below assume that they are being run from the installation directory.

## Components

The current containers used by this demonstrator are:

### Interactive
- [client](components/client/)

### Data/Traffic sources
- [apache\*](components/apache/)
- [flask\*](components/flask/)
- [ssh\*](components/ssh/)

### Infrastructure
- [router](components/router/)

### SOC (IDS)
- [bro](components/bro/)

### SOC (Threat Intelligence)
- misp-web
- misp-db

### SOC (Analytics)
- elasticsearch
- logstash (bro)
- logstash (elastiflow)
- kibana

### SOC (Alerting)
- [elastalert](components/elastalert/)

### Notes

- `misp-web` and `misp-db` are used from the misp-docker (XME edition) repo, part of the official MISP project, which is included as a submodule.
- `elasticsearch`, `kibana` and `logstash` are used from the docker-elk repo, https://github.com/deviantony/docker-elk, which uses the official elastic docker containers. 
- \* `apache` , `flask` and `ssh` are intended to scale to multiple instances.

## Networks

Three internal docker networks are used:

- internal
- external
- mirror

Each container is configured to belong to a specific set of these: 

- client: `internal` only
- apache: `external` only
- flask: `external` only
- bro: `mirror` only
- router: `internal`:`external`:`mirror`
- misp-web: `mirror` only
- misp-db: `mirror` only
- elasticsearch: `mirror` only
- logstash: `mirror` only
- kibana: `mirror` only

The router is then configured to route traffic between the client and apache/flask instances, mirroring the consequent packets to the bro node via the mirror network.

A network diagram showing the configuration is given [here][1]

## Helper scripts

A number of helper, wrapper scripts are included to give easy access to common commands (particularly for use during a demo session). In each case where a `_local` version exists, this assumes the script is being run in the installation directory (i.e. the `$SOCDIR` environment variable is set to `` `pwd` ``)

### pocketsoc_start[_local] NUMBEROFAPACHESERVERS

Runs `configure.sh` to do initial setup and run `docker-compose up`, hence building docker images where necessary. Takes one argument (required), the number of apache instances to spin up [will be set to 1 by default in next version]. 

Pipes the output of `docker-compose` to a logfile, by default found in `$SOCDIR/log/run.log`

### pocketsoc_stop[_local]

Runs `docker-compose stop` to shut down the containers.

### pocketsoc_log[_local]

Tails the run log, by default found in `$SOCDIR/log/run.log`

### pocketsoc_attach

Runs `docker exec -it CONTAINER bash`

### pocketsoc_daemon

As for `pocketsoc_start`, but uses `tee` to mirror the logs to `stdout` and the log file. Primarily for use with VM installation

### pocketsoc_build[_local]

As for `pocketsoc_start`, but only runs build step. Primarily for use in building VM installation.

### pocketsoc_importpatterns

Manually runs step to import kibana patterns into `kibana` for Elastiflow. Runs `docker exec` to run this from `router` container. 

### pocketsoc_revert

Dumps all current elasticsearch indices. *Use with care*

## Demo workflow

An initial demo could include showing that network traffic, where one endpoint is identified in a MISP event, can 

1. be tracked with bro
2. be identified as matching intelligence by bro for further action

Steps to follow

- After setting up admin account on MISP, note on front page that no events exist
- Visit user page and flag authentication key for later use
- on `bro`, visit `/opt/bro/logs/current/` and look in `conn.log` and `http.log`- should see connection attempt from `bro` to `misp-web` trying to fetch intel. This will not be working. This is a good time to note that different types of traffic will have specific logs autogenerated (if you have the relevant scripts enabled)
- copy auth key to `/config/pull_misp.sh`
- Note in `conn.log` that the connections to misp-web continue. You can also see in `http.log` that these should have switched from `403:Forbidden` to `200:OK`. 
- You can use `bro-cut` here to pull out particular fields, eg `cat http.log | /opt/bro/bin/bro-cut -d ts id.orig_h id.resp_h status_code status_msg | tail -1` to get the last entry
- Should now be able to see contents of `/config/feeds/testdata.txt` - just file headings
- On `client`, check that demo\_apache\_1 is accessible and issue `curl http://demo_apache_1/` which should give "SOC Demonstrator, static content"
- On `client` check the IP address of `demo_apache_1`
- on `bro`, should note presence of this IP in `conn.log`
- in MISP UI (`127.0.0.1:8040`), add an event with "Event info -\> Demo"  and add an attribute:
	- Category: Network activity
	- Type: ip-dst
	- Value: `demo_apache_1` IP
	- Check *for Intrusion Detection System*
- From sidebar, issue *Publish Event* -\> *YES*
- on `bro`, check that `/config/feeds/testdata.txt` now populates with this data (takes \> 1 minute)
- on `client`, rerun `curl http://demo_apache_1/`
- on `bro`, check that the `demo_apache_1` IP again appears in `conn.log`
- on `bro`, there should also now be an `intel.log` file with relevant matches.
- FOR ADDITIONAL DETAILING 
	- Various examples of traffic analysis can be carried out using kibana
	- Various combinations of apache/flask instances can be spun up to represent more "typical" traffic patterns
	- 

