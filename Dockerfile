FROM ubuntu:16.04

EXPOSE 8081

RUN  apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*

RUN  apt-get update \
  && apt-get install default-jre -y

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-armhf/jre

RUN apt-get update \
   && apt-get install unzip -y

WORKDIR /opt
RUN wget "https://bintray.com/artifact/download/jfrog/artifactory/jfrog-artifactory-oss-6.12.2.zip" -O "artifactory.zip"
RUN mkdir jfrog \
    && mv artifactory.zip jfrog

WORKDIR /opt/jfrog
RUN export JFROG_HOME=/opt/jfrog

RUN unzip artifactory.zip \
    && mv artifactory-oss-6.12.2 artifactory \
    && cd artifactory/bin \
    && sed -ri 's/4g/512m/g' artifactory.default

WORKDIR /opt/jfrog/artifactory/bin
CMD ./artifactoryctl