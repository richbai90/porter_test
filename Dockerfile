# The variant of debian to use when pulling the devcontainer image from MS
ARG VARIANT="1.18-bullseye"
# The porter image
ARG IMG
# Pull in the go devcontainer image from MS
FROM mcr.microsoft.com/vscode/devcontainers/go:0-${VARIANT}
# Pull in the porter image
FROM ${IMG}
# The group id of the docker group on the host system
ARG DOCKERID
# Set the GOPATH
ENV GOPATH /home/nonroot/go
# Add go to the system path
ENV PATH "$PATH:/usr/local/go/bin"
# MS installs go as root so these steps must be done as Root user
USER root
# Copy gopath from devcontainer root to porter nonroot user home directory 
COPY --from=0 /go /home/nonroot/go
# Copy go bin folder from devcontainer to porter
COPY --from=0 /usr/local/go /usr/local/go
# Correct goroot ownership and install git
RUN chown -R nonroot:0 /home/nonroot && \
    apt-get update && \
    apt-get install -y git

# Set the user back to nonroot as expected by porter runtime
USER nonroot