#/bin/bash


sudo docker build -t mkdocs_build_env -f ./Dockerfile.template .
sudo docker run -v $PWD:/docs -w /docs -it --rm mkdocs_build_env mkdocs --version
