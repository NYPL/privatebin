#! /bin/bash
# Push only if it's not a pull request
# Push only if we're testing a deployable branch
if [ "$TRAVIS_BRANCH" == "master" ]; then

  export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID_PRODUCTION
  export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY_PRODUCTION
  DOCKER_REPO_URL=$REMOTE_IMAGE_URL

  # This is needed to login on AWS and push the image on ECR
  # Change it accordingly to your docker repo
  pip install --user awscli
  export PATH=$PATH:$HOME/.local/bin
  eval $(aws ecr get-login --no-include-email --region us-east-1)

  # Build and push
  LOCAL_TAG_NAME=privatebin:latest
  REMOTE_FULL_URL=$DOCKER_REPO_URL:latest

  docker build --tag $LOCAL_TAG_NAME .
  echo "Pushing $LOCAL_TAG_NAME"
  docker tag $LOCAL_TAG_NAME "$REMOTE_FULL_URL"
  docker push "$REMOTE_FULL_URL"
  echo "Pushed $LOCAL_TAG_NAME to $REMOTE_FULL_URL"
else
  echo "Skipping deploy because branch is not a deployable branch"
fi
