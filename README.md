| --- |
| This repository contains sample material for the gateway of new modularized openIMIS platform. It is dedicated to illustrate the services delivered by the gateway to other components. It is provided withoutany waranty and doesn't address all openIMIS platform security needs. |

Please look for the direction on the openIMIS Wiki: https://openimis.atlassian.net/wiki/spaces/OP/pages/963182705/MO1.1+Install+the+modular+openIMIS+using+Docker

The current configuration exposes:
- the backend apis for external applications under the /api urls
- the backend apis for openIMIS frontend under the /iapi urls


The /api urls are restricted to authenticated users. The showcased authentication mechanism is a basic auth. protocol based on a .htpasswd file located in the /conf MOUNTED volume.
When starting the docker from command line, you need to specify the host location you want to use via the command
`docker run --mount HOST_LOCATION:/conf IMAGE`

The gateway also routes all proxied pages to a (legacy) openIMIS installation, and all new API and front calls to the frontend and backend servers.
* The (sub)domain where legacy openIMIS is installed must be provided in the LEGACY_OPENIMIS_HOST build argument (example: `--build-arg LEGACY_OPENIMIS_HOST=demo.openimis.org`)
* The (sub)domain where new openIMIS is installed must be provided in the NEW_OPENIMIS_HOST build argument (example: `--build-arg NEW_OPENIMIS_HOST=openimis.org`)

The gateway auto-generate a self-signed certificate, which should be replaced by a certificate registered for your domain (see 'obtain a SSL certificate' here below).

Finally, to automatically renew the certificate prior to expiry, you may register the certbot in the crontab of your container

## To add a user (#Linux only)
- connect to the running docker container (`docker exec -it <container id> /bin/sh`
- by default, you are in the /script directory (`cd /script` otherwise)
- issue the command `./add-user.sh <username> <userpassword>`

## To change a user's password (#Linux only)
- connect to the running docker container (`docker exec -it <container id> /bin/sh` 
- by default, you are in the /script directory (`cd /script` otherwise)
- issue the command `./update-user.sh <username> <new userpassword>`

## To remove a user (#Linux only)
- connect to the running docker container (`docker exec -it <container id> /bin/sh` 
- by default, you are in the /script directory (`cd /script` otherwise)
- issue the command `./remove-user.sh <username>`

## To obtain a SSL certificate signed by letsencrypt (#Linux only)
- connect to the running docker container (`docker exec -it <container id> /bin/sh` 
- by default, you are in the /script directory (`cd /script` otherwise)
- issue the command `install-certificate.sh` ... and follow the setup wizzard (provide contact address,...)
- stop/start the container

## To register the certbot for automatic certificate renewal (#Linux only)
- connect to the running docker container (`docker exec -it <container id> /bin/sh` 
- by default, you are in the /script directory (`cd /script` otherwise)
- issue the command `register-certbot.sh`