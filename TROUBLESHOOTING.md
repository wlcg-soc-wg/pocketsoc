# Troubleshooting

## If containers don't start properly

Type `Ctrl-C` to stop containers, and re-run `docker-compose up` (particularly if you see error messages like "could not connect to database")

## Using the correct `docker-compose.yml` file

Make sure you're in the `PocketSOC` directory proper - there are other `docker-compose.yml` files in the `misp-docker` subdirectory (the XME misp-docker repo) and `docker-elk` subdirectory, but we override this with different network settings to make our cluster work.

## Network not found

If an error like "Cannot start service ... network ... not found", one or more of the containers may be trying to attach to a network that no longer exists. First, make sure that the `internal`, `external` and `mirror` networks exist using `docker network ls`, then recreate the containers using `docker-compose up --forcerecreate`