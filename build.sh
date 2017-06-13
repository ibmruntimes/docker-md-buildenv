#/bin/bash


sudo docker build -t mkdocs_build -f ./Dockerfile.template .
sudo docker run mkdocs_build ls -l
#sudo docker run -v $PWD:/docs -w /docs -it --rm mkdocs_build mkdocs --version
