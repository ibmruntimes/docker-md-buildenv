# (C) Copyright IBM Corporation 2016, 2017
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FROM ubuntu:16.04
MAINTAINER runtimesid <jtcid@uk.ibm.com> 

# Set up for SSH (including SSH login fix to prevent user being logged out) and add PIP 
RUN apt-get update && apt-get install -y --no-install-recommends python3 python3-pip python-setuptools openjdk-8-jdk \
    && DEBIAN_FRONTEND="noninteractive" apt-get -q upgrade -y -o Dpkg::Options::="--force-confnew" --no-install-recommends \
    && DEBIAN_FRONTEND="noninteractive" apt-get -q install -y -o Dpkg::Options::="--force-confnew" --no-install-recommends openssh-server \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install --upgrade pip \
    && pip3 install -U setuptools \
    && sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd \
    && mkdir -p /var/run/sshd

# Add MkDocs and dependencies
COPY requirements.txt /tmp/
RUN pip3 install --requirement /tmp/requirements.txt
COPY . /tmp/

# Setup jenkins user
RUN  useradd -m -d /home/jenkins -s /bin/sh jenkins \
    && echo "jenkins:jenkinspass" | chpasswd

ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8

# Standard SSH port
EXPOSE 22

# Deafult command
CMD ["/usr/sbin/sshd", "-D"]

# Create and set a working directory /docs
RUN mkdir /docs
WORKDIR /docs
