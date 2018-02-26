# goCD_kb8

deploying GoCD on kubernetes cluster (google cloud)

## GOOGLE CLOUD AUTHENTICATION

Get your credentials from google cloud , then save it as credentials.json into root project directory 

## DEFINE ENVIRONMENTS

/envs

here you can define your environments, it needs to be one file per env.

## CONTROLLER

converge.rb manages all operations

./converge.rb path/to/env/file OPERATION

### OPERATIONS

#### CREATE
#### DESTROY
#### APPS

##### LIST
##### INSTALL

## INSTALLING KUBERNETES CLUSTER

./converge.rb path/to/env/file create

make sure get all envs settings in /envs/*

## LISTING APPS AVAILABLES TO INSTALL

./converge.rb ./envs/dev/dev1.tfvars apps list

## INSTALLING  GO CD

./converge.rb ./envs/dev/dev1.tfvars apps install goc


## DESTROYING ENVIRONMENTS

converge.rb ./envs/dev/dev1.tfvars destroy
