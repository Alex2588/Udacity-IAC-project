#!/bin/bash

./deploy-stack.sh udagram-network network.yml network-parameters.json us-east-1
./deploy-stack.sh udagram-app udagram.yml udagram-parameters.json us-east-1