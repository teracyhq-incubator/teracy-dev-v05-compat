#!/bin/bash


# rm -rm is just hacking, find a better way
# rm -rf main-cookbooks/teracy-dev/Berksfile.lock # always install the latest

echo "install vendor-cookbooks"
berks vendor -b main-cookbooks/teracy-dev/Berksfile --delete vendor-cookbooks

# chown 1000:1000 main-cookbooks/teracy-dev/Berksfile.lock

echo "check outdated vendor-cookbooks"
berks outdated -b main-cookbooks/teracy-dev/Berksfile
