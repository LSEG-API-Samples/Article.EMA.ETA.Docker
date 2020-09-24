FROM oraclelinux:7
LABEL maintainer="Refinitiv Developer Advocate"
RUN yum -y install gcc-c++.x86_64 git.x86_64 ksh redhat-lsb-core.x86_64 openssl-devel wget.x86_64
RUN mkdir -p /opt/refinitiv \
 && cd /opt/refinitiv \
 && git clone --recursive https://github.com/refinitiv/Real-Time-SDK.git \
 && wget https://cmake.org/files/v3.11/cmake-3.11.2-Linux-x86_64.tar.gz \
 && wget http://xmlsoft.org/sources/libxml2-2.9.9.tar.gz \
 && tar -xvf cmake-3.11.2-Linux-x86_64.tar.gz
RUN cd /opt/refinitiv/Real-Time-SDK \
 && mkdir rtsdk \
 && export PATH=/opt/refinitiv/cmake-3.11.2-Linux-x86_64/bin:$PATH \
 && cd rtsdk \
 && mkdir -p external/dlcache \
 && cp /opt/refinitiv/libxml2-2.9.9.tar.gz external/dlcache \
 && cmake ../ -DBUILD_UNIT_TESTS=OFF \
 && make \
 && cp /opt/refinitiv/Real-Time-SDK/Cpp-C/etc/* /opt/refinitiv/Real-Time-SDK/Cpp-C/Eta/Executables/OL7_64*/Optimized \
 && ln -s /opt/refinitiv/Real-Time-SDK/Cpp-C/Eta/Executables/OL7_64* /opt/refinitiv/Real-Time-SDK/Cpp-C/Eta/Executables/OL7_64
WORKDIR /opt/refinitiv/Real-Time-SDK/Cpp-C/Eta/Executables/OL7_64/Optimized
CMD /bin/sh
