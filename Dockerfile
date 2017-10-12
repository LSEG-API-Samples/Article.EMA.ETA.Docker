FROM oraclelinux:7
LABEL maintainer="Thomson Reuters Active Help Service"
RUN yum -y install gcc-c++.x86_64 git.x86_64 ksh redhat-lsb-core.x86_64 \
 && mkdir -p /opt/thomsonreuters \
 && cd /opt/thomsonreuters \
 && git clone --recursive https://github.com/thomsonreuters/Elektron-SDK.git \
 && cd Elektron-SDK/Elektron-SDK-BinaryPack/Cpp-C/Eta \
 && ./LinuxSoLink \
 && cd /opt/thomsonreuters/Elektron-SDK/Cpp-C/Eta/Impl \
 && make all \
 && cd ../Utils/Libxml2 \
 && make \
 && cd /opt/thomsonreuters/Elektron-SDK/Cpp-C/Ema/Src/Access \
 && make \
 && cd /opt/thomsonreuters/Elektron-SDK/Cpp-C/Eta/Applications/Examples/Consumer \
 && make \
 && cd .. \
 && ln -s Consumer/*/*/Consumer consumer \
 && cd Provider \
 && make \
 && cd .. \
 && ln -s Provider/*/*/Provider provider \
 && ln -s ../../etc/RDMFieldDictionary RDMFieldDictionary \
 && ln -s ../../etc/enumtype.def enumtype.def

WORKDIR /opt/thomsonreuters/Elektron-SDK/Cpp-C/Eta/Applications/Examples
CMD /bin/sh
