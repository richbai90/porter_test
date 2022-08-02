# syntax=docker/dockerfile-upstream:1.4.0
# This is a template Dockerfile for the bundle's invocation image
# You can customize it to use different base images, install tools and copy configuration files.
#
# Porter will use it as a template and append lines to it for the mixins
# and to set the CMD appropriately for the CNAB specification.
#
# Add the following line to porter.yaml to instruct Porter to use this template
# dockerfile: template.Dockerfile

# You can control where the mixin's Dockerfile lines are inserted into this file by moving the "# PORTER_*" tokens
# another location in this file. If you remove a token, its content is appended to the end of the Dockerfile.
FROM debian:stretch-slim

# PORTER_INIT

# Add expected boilerplate files
RUN mkdir -p ${BUNDLE_DIR}/.cnab
RUN echo "" > ${BUNDLE_DIR}/porter.yaml

RUN rm -f /etc/apt/apt.conf.d/docker-clean; echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
RUN --mount=type=cache,target=/var/cache/apt --mount=type=cache,target=/var/lib/apt \
    apt-get update && apt-get install -y ca-certificates qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils

# PORTER_MIXINS

COPY --chown=${BUNDLE_USER}:${BUNDLE_GROUP} ./terraform/ ${BUNDLE_DIR}/terraform