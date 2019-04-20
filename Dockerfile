FROM ubuntu:14.04 as build

LABEL maintainer="Daniel Albohn <d.albohn@gmail.com>"

ARG DEBIAN_FRONTEND=noninteractive

ARG OPENFACE_DIR=/OpenFace

RUN apt-get update && apt-get -y install -qq -y \
    git wget sudo unzip

RUN sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak && \
    rm -f /etc/apt/sources.list

ADD https://raw.githubusercontent.com/d-bohn/openface_aci/master/assets/trusty-sources.list \
    /etc/apt/sources.list

RUN apt-get update

# RUN ${OPENFACE_DIR}/install.sh

RUN apt-get -y update && \
    apt-get -y install build-essential && \
    apt-get -y install cmake && \
    apt-get -y install libopenblas-dev liblapack-dev && \
    apt-get -y install git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev && \
    apt-get -y install python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev

ADD https://github.com/opencv/opencv/archive/3.4.0.zip /

RUN unzip 3.4.0.zip && \
    cd opencv-3.4.0 && \
    mkdir -p build && \
    cd build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=ON -D WITH_CUDA=OFF -D BUILD_SHARED_LIBS=OFF .. && \
    make -j4 && \
    make install && \
    cd ../.. && \
    rm 3.4.0.zip && \
    rm -r opencv-3.4.0

ADD http://dlib.net/files/dlib-19.13.tar.bz2 /

RUN tar xf dlib-19.13.tar.bz2 && \
    cd dlib-19.13 && \
    mkdir -p build && \
    cd build && \
    cmake .. && \
    cmake --build . --config Release && \
    make install && \
    ldconfig && \
    cd ../.. && \
    rm -r dlib-19.13.tar.bz2

RUN apt-get -y install libboost-all-dev

RUN git clone https://github.com/TadasBaltrusaitis/OpenFace.git

RUN cd ${OPENFACE_DIR} && /bin/sh download_models.sh

RUN cd ${OPENFACE_DIR} && \
    mkdir -p build && \
    cd build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE .. && \
    make && \
    cd .. && \
    echo "OpenFace installed."

ENTRYPOINT ["/bin/bash"]
