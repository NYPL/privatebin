#! /bin/bash
# Deploy only if it's not a pull request
# Deploy only if we're testing the master branch
if [ "$TRAVIS_BRANCH" == "master" ]; then

  export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID_PRODUCTION
  export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY_PRODUCTION
  CLUSTER_NAME=reoccurring-job-runner
  WEB_APP_SERVICE_NAME="zerobin-production"

  echo "Deploying $TRAVIS_BRANCH"
  
  AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION aws ecs update-service --cluster $CLUSTER_NAME --region us-east-1 --service $WEB_APP_SERVICE_NAME --force-new-deployment
else
  echo "Skipping deploy because it's not a deployable branch"
fi
