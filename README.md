| :bomb: Disclaimer |
| --- |
| This repository currently only contains sample material for the modularized openIMIS. Don't use it for production!! |

# openIMIS Backend Location reference module
This repository provides a simple openIMIS Gateway to illustrate how openIMIS can interact with an external authentication system (SSO platform, ...).

The current configuration only exposes the backend apis under the /api urls
These urls are restricted to authenticated users. and the authentication mechanism is a basic auth. protocol based on a .htpasswd file located in the gateway.

## To add a user
- connect to the running docker container (`docker exec -it <container id> /bin/sh` 
- issue the command `/script/add-user.sh <username> <userpassword>`

## To change a user's password
- connect to the running docker container (`docker exec -it <container id> /bin/sh` 
- issue the command `/script/update-user.sh <username> <new userpassword>`

## To remove a user
- connect to the running docker container (`docker exec -it <container id> /bin/sh` 
- issue the command `/script/remove-user.sh <username>`