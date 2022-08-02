#!/bin/bash
img=$(porter build --debug 2>&1 | grep "naming to" | awk '{print $4}')
imgname=$(docker images "$img" | awk '(NR>1) {print $1}')
dockerid=$(gstat -c '%g' /var/run/docker.sock)
friendlyname=$(echo "$img" | awk -F '/' '{print $2}' | awk -F ':' '{print $1}')-debug
docker build -t "$imgname:debug" \
        --no-cache \
        --force-rm \
        --progress plain \
        --build-arg IMG="$img" \
        --build-arg DOCKERID="$dockerid" . && \
docker run -it \
           --rm \
           --mount type=bind,src=/run/host-services/ssh-auth.sock,target=/run/host-services/ssh-auth.sock \
           --group-add "$dockerid" \
           --name "$friendlyname" \
           -v test:/target \
           -v $HOME/xfer:/xfer \
           -v $HOME/porter:/porter \
           -v /var/run/docker.sock.raw:/var/run/docker.sock \
           "$imgname:debug" /bin/bash
