| Disclaimer : NOT FOR PRODUCTION USE  |
| --- |
| This repository currently only contains sample material for the modularized openIMIS. Don't use it for production!! |

# openIMIS Backend Location reference module
This repository provides a simple openIMIS Gateway to illustrate how openIMIS can interact with an external authentication system (SSO platform, ...).

The current configuration only exposes the backend apis under the /api urls
These urls are restricted to authenticated users. The authentication mechanism is a basic auth. protocol based on a .htpasswd file located in the gateway.

The gateway also routes all proxied pages to a (legacy) openIMIS installation, and all new API and front calls to the frontend and backend servers.
* The (sub)domain where legacy openIMIS is installed must be provided in the LEGACY_OPENIMIS_HOST build argument (example: `--build-arg LEGACY_OPENIMIS_HOST=demo.openimis.org`)
* The (sub)domain where new openIMIS is installed must be provided in the NEW_OPENIMIS_HOST build argument (example: `--build-arg NEW_OPENIMIS_HOST=openimis.org`)

The gateway auto-generate a self-signed certificate, which should be replaced by a certificate registered for your domain (see 'obtain a SSL certificate' here below)

## To add a user
- connect to the running docker container (`docker exec -it <container id> /bin/sh`
- by default, you are in the /script directory (`cd /script` otherwize)
- issue the command `./add-user.sh <username> <userpassword>`

## To change a user's password
- connect to the running docker container (`docker exec -it <container id> /bin/sh` 
- by default, you are in the /script directory (`cd /script` otherwize)
- issue the command `./update-user.sh <username> <new userpassword>`

## To remove a user
- connect to the running docker container (`docker exec -it <container id> /bin/sh` 
- by default, you are in the /script directory (`cd /script` otherwize)
- issue the command `./remove-user.sh <username>`

## To obtain a SSL certificate signed by letsencrypt
- connect to the running docker container (`docker exec -it <container id> /bin/sh` 
- by default, you are in the /script directory (`cd /script` otherwize)
- issue the command `certbot --nginx -d <openimis.domaine>` ... and follow the setup wizzard (provide contact address,...)
- stop/start the container