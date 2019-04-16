# openface_ics
Code and workflow for building [OpenFace](https://github.com/TadasBaltrusaitis/OpenFace)
in Docker Hub and modifying it with Singularity Hub for use with PSU
ACI HPC clusters.

## Quick Start
From ACI, executing the following code should create an `OpenFace` image.
```
singularity pull shub://d-bohn/openface_ics:latest
```

## Image Builds
The OpenFace docker image was built from scratch on docker hub following the
[documentation](https://github.com/TadasBaltrusaitis/OpenFace/wiki/Unix-Installation) provided by it's maintainers.

The OpenFace singularity image was built using the docker image base and
converting it to a singularity image via singularity hub.

Setup for linking Github with Docker Hub and Singularity Hub can be found here:

  - [docker Hub](https://docs.docker.com/docker-hub/)
  - [Singularity Hub](https://github.com/singularityhub/singularityhub.github.io/wiki)

The `Singularity` file specifies creating a Singularity-compatible image
from the docker image, as well as adding access to folders within ACI,  specifically:
```
# ACI mappings so you can access your files.
mkdir -p /storage/home
mkdir -p /storage/work
mkdir -p /gpfs/group
mkdir -p /gpfs/scratch
mkdir -p /var/spool/torque
```

## Notes
  - The OpenFace docker image is large (> 6GB). It is built on Ubuntu 18.04.
  Not sure if it can be reduced in size as the executables rely on several
  large libraries.

  - Several important updates for `faciallandmarkdetector` are hosted on
  the maintainer's cloud account. Might be prudent to download them
  separately and/or include them in the repository.

  - Some functionality for real-time video viewing is not available
  when run in a container (at least not as of now).
