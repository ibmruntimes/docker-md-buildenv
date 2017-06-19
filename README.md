# docker-md-buildenv
Docker script to create an image that contains all the pre-reqs to build markdown with MkDocs in a jenkins slave build node.

Pre-reqs include:
- python 3
- python-pip
- python-setuptools
- open-ssh
- openjdk
- plus ... a pinned dependency list for MkDocs (see requirements.txt)

This image is stored at: https://hub.docker.com/r/ibmjavaid/mkdocs_build_env/

To use this image **docker pull ibmjavaid/mkdocs_build_env**
