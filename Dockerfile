FROM ubuntu:18.04 as build

LABEL maintainer="Daniel Albohn <d.albohn@gmail.com>"

ARG DEBIAN_FRONTEND=noninteractive

ARG OPENFACE_DIR=/OpenFace

RUN apt-get update && apt-get install -qq -y \
    git wget sudo unzip

RUN sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak && \
    rm -f /etc/apt/sources.list

ADD https://raw.githubusercontent.com/d-bohn/openface_aci/master/assets/sources.list \
    /etc/apt/sources.list

RUN apt-get update

RUN git clone https://github.com/TadasBaltrusaitis/OpenFace.git

RUN cd ${OPENFACE_DIR} && /bin/sh download_models.sh

RUN ${OPENFACE_DIR}/install.sh

ENTRYPOINT ["/bin/bash"]
