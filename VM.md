# Instructions for VM installation

## Introduction

This quickstart guide covers the `pocketsoc_v1` VM. This contains a prebuilt version of PocketSOC v1, with docker images already in place.

## Requirements

- Tested on VirtualBox v6

## Configuration

The VM has the following configuration by default. 
- 2 cores
- 1 network port (NAT)
- 8GB RAM
  - Startup has been tested with 4GB, but this option has not been extensively tested
- USB disabled

In addition, 3 ports are forwarded by default:

| Description | Host IP:port   | Guest IP:port   |
| ----------- | -------------- | -------------- |
| Kibana      | 127.0.0.1:8060 | 10.0.2.15:8060 |
| MISP        | 127.0.0.1:8040 | 10.0.2.15:8040 |
| SSH         | 127.0.0.1:2222 | 10.0.2.15:22   |

## Access

Access to the VM once running is via `ssh -p 2222 pocketsoc@localhost`. Credentials:
- Username: `pocketsoc`
- Password: `pocketsoc`

## On startup and service control

On startup, the VM will autostart the pocketsoc docker cluster via `systemd`. Check the status of the service using

```
systemtl status pocketsoc
```

To restart the service, currently use

```
systemctl stop pocketsoc
systemctl start pocketsoc
```

It takes some time for the individual services to start up - their progress can be seen using `pocketsoc_log` which will give the output of `docker-compose`

## Installation directory

All of the configuration can be found in `development/PocketSOC`; this is a clone of the v1 configuration.

## Accessing kibana and MISP

Access to `kibana` and `MISP` are the same as via the standard install - open a browser and use the following:

- 127.0.0.1:8040: MISP
- 127.0.0.2:8060: Kibana


