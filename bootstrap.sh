#!/usr/bin/env bash

# source <(curl -L https://goo.gl/JMgctm)

END_C="\e[0m"
L_CYAN="\e[96m"

echo -e "${L_CYAN}Breeze-comp bootstrap :"
echo -e "Checking for git...${END_C}"
sudo apt-get update
sudo apt-get install git
echo -e "${L_CYAN}downloading git repo and running init.sh :${END_C}"
git clone https://github.com/Fclem/docker-Rcompute-env docker && cd docker && exec ./init.sh && rm ../bootstrap.sh
