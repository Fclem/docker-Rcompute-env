#!/usr/bin/env bash

# source <(curl -L https://goo.gl/JMgctm)

sudo apt-get update
sudo apt-get install git
git clone https://github.com/Fclem/docker-Rcompute-env docker && cd docker && exec ./init.sh && rm ../bootstrap.sh
