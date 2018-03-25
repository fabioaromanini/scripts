#!/bin/bash

NVM_VERSION="v0.33.8"

sudo apt-get update
wget -qO- https://raw.githubusercontent.com/creationix/nvm/$NVM_VERSION/install.sh | bash

# After running the script, open a new terminal and use the following commands:

# nvm ls-remote --lts
# nvm install "latest lts version available in remote"

# nvm ls-remote
# nvm install "latest version available in remote"
# nvm install --latest-npm

# To switch between latest stable and lts release use the following
# nvm use stable
# nvm use lts/lts_version
