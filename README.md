# Terraform VPC for AWS

## Provider and Credentials

## Server Instances

## Network
### Virtual Privat Cloud
#### Public IP
#### Internet Gateway
### Subnets
#### Subnet Public1
#### NAT Gateway
#### Subnet Private2

## Utils
### createlist

### Terrafrom show

### Terraform graph
The output of terraform graph is in the DOT format, which can easily be converted to an image by making use of dot provided by GraphViz:
$ terraform graph | dot -Tsvg > graph.svg  
to install GraphViz see https://graphviz.org/download/  

