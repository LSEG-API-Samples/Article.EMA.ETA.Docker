FROM oraclelinux:7
LABEL maintainer="Thomson Reuters Active Help Service"
RUN yum -y install gcc-c++.x86_64 git.x86_64 ksh redhat-lsb-core.x86_64 openssl-devel wget.x86_64
RUN mkdir -p /opt/thomsonreuters \
 && cd /opt/thomsonreuters \
 && git clone --recursive https://github.com/thomsonreuters/Elektron-SDK.git \
 && wget https://cmake.org/files/v3.11/cmake-3.11.2-Linux-x86_64.tar.gz \
 && tar -xvf cmake-3.11.2-Linux-x86_64.tar.gz \
 && cd Elektron-SDK \
 && git clone --recursive https://github.com/thomsonreuters/Elektron-SDK-BinaryPack.git \
 && cd Elektron-SDK-BinaryPack \
 && ./LinuxSoLink 
RUN cd /opt/thomsonreuters/Elektron-SDK \
 && mkdir esdk \
 && export PATH=/opt/thomsonreuters/cmake-3.11.2-Linux-x86_64/bin:$PATH \
 && cd esdk \
 && cmake ../ \
 && make \
 && cp /opt/thomsonreuters/Elektron-SDK/Cpp-C/etc/* /opt/thomsonreuters/Elektron-SDK/Cpp-C/Eta/Executables/OL7_64*/Optimized \
 && ln -s /opt/thomsonreuters/Elektron-SDK/Cpp-C/Eta/Executables/OL7_64* /opt/thomsonreuters/Elektron-SDK/Cpp-C/Eta/Executables/OL7_64
WORKDIR /opt/thomsonreuters/Elektron-SDK/Cpp-C/Eta/Executables/OL7_64/Optimized
CMD /bin/sh
