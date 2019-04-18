FROM ubuntu:18.04 as build

LABEL maintainer="Daniel Albohn <d.albohn@gmail.com>"

ARG DEBIAN_FRONTEND=noninteractive

ARG OPENFACE_DIR=/OpenFace

RUN apt-get update && apt-get install -qq -y \
    git wget sudo unzip

RUN git clone https://github.com/TadasBaltrusaitis/OpenFace.git

RUN cd ${OPENFACE_DIR} && /bin/sh download_models.sh

RUN /OpenFace/install.sh

ENTRYPOINT ["/bin/bash"]
