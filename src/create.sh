#!/bin/sh
echo [default] > ~/.aws/credentials
echo aws_access_key_id = $AWS_ACCESS_KEY_ID >> ~/.aws/credentials
echo aws_secret_access_key = $AWS_SECRET_ACCESS_KEY >> ~/.aws/credentials

PASSWORD=$(aws ecr get-login-password --region sa-east-1)
echo "AWS_TOKEN recived: "
echo ${PASSWORD:0:5}
rancher login --skip-verify --context $CONTEXT_PROJECT -t $RANCHER_TOKEN $RANCHER_ENDPOINT

rancher kubectl delete secret aws-credential -n=$NAMESPACE

rancher kubectl create secret -n=$NAMESPACE docker-registry aws-credential --docker-server=$DOCKER_SERVER_URL --docker-username=AWS --docker-password=$PASSWORD

