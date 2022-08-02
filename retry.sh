#! /usr/bin/env bash
# rm -rf ~/restore
# rm -rf ./.cnab
# mkdir ~/restore
docker container stop "$(docker container ls | grep "/cnab/app/run" | awk '{print $1}' )"
docker container prune -f
docker image prune -f
docker volume prune -f
docker builder prune -f
porter install --debug --param loglevel=DEBUG