#/bin/bash


docker build -t mkdocs_build .
docker run -v $PWD:/docs -w /docs -it --rm mkdocs_build mkdocs --version
