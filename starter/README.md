# CD12352 - Infrastructure as Code Project Solution
# Oleksandr Beschasnyi

## Spin up instructions
This project uses the cloudformation templates to launch a high-availability web app.
Running the script will create two stacks named `udagram-network` and `udagram-app`, starting with the network stack.

To get started run: `./create-infra.sh`

## Tear down instructions
To delete stacks first run: `./delete-stack.sh udagram-app us-east-1`. Once complete you can delete the network stack with `/delete-stack.sh udagram-network us-east-1`.

## Other considerations
Apllications load balancer DNS name - http://udagra-webap-f0yotmsjgeyt-486617817.us-east-1.elb.amazonaws.com/