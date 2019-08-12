#!/bin/sh
certbot renew --post-hook \"openresty -s reload\"