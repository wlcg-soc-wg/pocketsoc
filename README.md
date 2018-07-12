# docker-soc-demonstrator

## Introduction

A test, **non-production** SOC demonstrator, intended to track the lifecycle of an event. 

## Components

The current containers used by this demonstrator are:

- client
- webserver
- router
- bro

## Networks

Three internal docker networks are used:

- internal
- external
- mirror

Each container is configured to belong to a specific set of these: 

- client: `internal` only
- webserver: `external` only
- bro: `mirror` only
- router: `internal`:`external`:`mirror`

The router is then configured to route traffic between the client and webserver, mirroring the consequent packets to the bro node via the mirror network.

## Usage

- Build docker images with docker-compose

```
docker-compose build
```

This builds a new image for each component. The demonstrator is intended to reflect the WG deployment documentation, so each container starts from a base centos:7 image - this step can therefore take a few minutes

- Bring up containers in the background

```
docker-compose up -d
```


- [development] Check IP addresses for each container, eg:

```
echo "Client network:"

docker exec client ifconfig | grep -A 1 ^eth

echo -e "\nWebserver network:"

docker exec webserver ifconfig | grep -A 1 ^eth

echo -e "\nRouter network:"

docker exec router ifconfig | grep -A 1 ^eth
```
```
Client network:
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.19.0.2  netmask 255.255.0.0  broadcast 172.19.255.255

Webserver network:
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.18.0.2  netmask 255.255.0.0  broadcast 172.18.255.255

Router network:
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.18.0.3  netmask 255.255.0.0  broadcast 172.18.255.255
--
eth1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.20.0.3  netmask 255.255.0.0  broadcast 172.20.255.255
--
eth2: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.19.0.3  netmask 255.255.0.0  broadcast 172.19.255.255
```

- [development] Check that the iptables rules described in `/scripts/routing` on `router` match what you expect from this configuration

- [development] Run `/scripts/routing` on `router` to activate these rules. **This is a key step**

```
docker exec router /files/routing
```
- [development] Check that `client` has `router` as its default route:

```
docker exec ip route
```
- [development] If necessary, put this in place
```
docker exec client ip route add default via [ROUTER_IP]
```
- Check that the IP address for `webserver` or `client`  matches the intel file on `bro` in `/files/testdata.txt`
```
docker exec bro grep [WEBSERVER_IP] /files/testdata.txt`
```
If not, `docker exec bro bash` and fix it.

- Check that `client` can talk to `webserver` via `ping` or otherwise
```
docker exec client ping [WEBSERVER_IP]

```
- Access some data from `webserver` on `client`, eg

```
curl http://[WEBSERVER_IP]/demonstrator/
```
- Check that this works OK
- On `bro`, check that the contents of `/opt/bro/logs/current/` looks something like this:

```
capture_loss.log   files.log  known_hosts.log     packet_filter.log  stderr.log
communication.log  http.log   known_services.log  software.log       stdout.log
conn.log           intel.log  loaded_scripts.log  stats.log
```
- If the IP address of `client` or `webserver matches `/scripts/testdata.txt`, you should see a populated `intel.log` file.
```
docker exec bro grep [WEBSERVER_IP] /opt/bro/logs/current/intel.log
```
- Watch live traffic
```
docker exec bro tail -f /opt/bro/logs/current/conn.log
```
On client
```
docker exec curl [WEBSERVER_IP]
```
You should see `conn.log` populating with traffic.


