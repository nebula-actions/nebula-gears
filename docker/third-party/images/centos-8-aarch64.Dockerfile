FROM arm64v8/centos:8
SHELL ["/bin/bash", "-c"]
RUN yum update -y
RUN yum install -y epel-release yum-utils
RUN yum config-manager --set-enabled powertools
RUN yum update -y
RUN yum install -y make \
                   git \
				   m4 \
				   wget \
				   unzip \
				   xz \
				   patch \
				   python2 \
				   python2-devel \
				   redhat-lsb-core \
				   perl-Data-Dumper \
				   perl-Thread-Queue \
				   readline-devel \
				   ncurses-devel \
				   zlib-devel \
				   gcc \
				   gcc-c++ \
				   cmake \
				   libtool \
				   autoconf \
				   autoconf-archive \
				   automake \
				   bison \
				   flex \
				   gperf \
				   gettext \
                   autoconf-archive

ENV NG_URL=https://raw.githubusercontent.com/dutor/nebula-gears/master/install
ENV OSS_UTIL_URL='https://gosspublic.alicdn.com/ossutil/1.7.0/ossutilarm64?spm=a2c63.p38356.879954.15.c0942454HuAZDI'
ENV PACKAGE_DIR=/usr/src/third-party
RUN curl -s ${NG_URL} | bash

RUN mkdir -p ${PACKAGE_DIR}
WORKDIR ${PACKAGE_DIR}

COPY build-third-party.sh ${PACKAGE_DIR}/build-third-party.sh
RUN chmod +x ${PACKAGE_DIR}/build-third-party.sh

COPY oss-upload.sh ${PACKAGE_DIR}/oss-upload.sh
RUN chmod +x ${PACKAGE_DIR}/oss-upload.sh

RUN wget -q -O /usr/bin/ossutil64 ${OSS_UTIL_URL}
RUN chmod +x /usr/bin/ossutil64
