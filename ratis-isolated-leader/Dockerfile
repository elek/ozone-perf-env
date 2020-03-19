ARG BASE=latest
FROM flokkr/base:35
ADD hadoop-ozone/dist/target/ozone-0.5.0-SNAPSHOT /opt/ozone
ENV CONF_DIR /opt/ozone/etc/hadoop
ENV PATH $PATH:/opt/ozone/bin
RUN yum install -y unzip
RUN curl -s https://gist.githubusercontent.com/elek/23b8b8c5f2849572d4d3b0751076eb21/raw/77e2cae6d360a459c285affb605b52fd3d4cfb17/bitman.sh | bash
ADD dev-support/byteman/ratis-mock-followers.btm /tmp/ratis-mock-followers.btm
WORKDIR /opt/ozone
