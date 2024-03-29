FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

ENV JAVA_VERSION=15.0.1

ENV INSTALL_DIR=${INSTALL_DIR:-/usr}

# py3
RUN apt-get update -y && \
    apt-get install -y apt-utils automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev && \
    apt-get install -y curl iputils-ping nmap net-tools build-essential software-properties-common libsqlite3-dev sqlite3 bzip2 libbz2-dev git wget unzip vim python3-pip python3-setuptools python3-dev python3-venv python3-numpy python3-scipy python3-pandas python3-matplotlib && \
    apt-get install -y git xz-utils && \
    apt-get install -y sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# locale
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

# openjdk
RUN apt-get update && apt-get install -y --no-install-recommends \
		bzip2 \
		unzip \
		xz-utils \
	&& rm -rf /var/lib/apt/lists/*

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

ENV JDK_TGZ_URL=https://download.java.net/java/GA/jdk${JAVA_VERSION}/51f4f36ad4ef43e39d0dfdbaf6549e32/9/GPL/openjdk-${JAVA_VERSION}_linux-x64_bin.tar.gz

ENV JDK_INSTALL_DIR=/opt

ENV JAVA_HOME=${JDK_INSTALL_DIR}/jdk-${JAVA_VERSION}
ENV PATH=$JAVA_HOME/bin:$PATH

RUN curl -sL --retry 3 --insecure \
  ${JDK_TGZ_URL} | gunzip | tar x -C ${JDK_INSTALL_DIR}/ && \
  ls -al ${INSTALL_DIR} ${JAVA_HOME} && \
  echo  export PATH=$PATH ; echo "PATH=${PATH}" ; export JAVA_HOME=${JAVA_HOME} ; echo "java=`which java`" && \
  ln -s ${JAVA_HOME} ${JDK_INSTALL_DIR}/java 


# TODO:
## update-alternatives so that future installs of other OpenJDK versions don't change /usr/bin/java

### mvn uncomment if needed
#ARG MAVEN_VERSION=${MAVEN_VERSION:-3.6.3}
#ENV MAVEN_VERSION=${MAVEN_VERSION}
#ENV MAVEN_HOME=/usr/apache-maven-${MAVEN_VERSION}
#ENV PATH=${PATH}:${MAVEN_HOME}/bin
#RUN curl -sL http://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
#  | gunzip \
#  | tar x -C /usr/ \
#  && ln -s ${MAVEN_HOME} /usr/maven

# default python packages
COPY requirements.txt ./

## -- if pkg-resources error occurs, then do this! -- ##
# pip3 uninstall pkg-resources==0.0.0
RUN pip3 --no-cache-dir install --upgrade pip
RUN pip3 --no-cache-dir install --ignore-installed -U -r requirements.txt
#
## -- added Local PIP installation bin to PATH
ENV PATH=${PATH}:${HOME}/.local/bin

## VERSIONS ##
ENV PATH=${PATH}:${JAVA_HOME}/bin

## gradle uncomment if needed
#ARG GRADLE_INSTALL_BASE=${GRADLE_INSTALL_BASE:-/opt/gradle}
#ARG GRADLE_VERSION=${GRADLE_VERSION:-6.0.1}
#
#ARG GRADLE_HOME=${GRADLE_INSTALL_BASE}/gradle-${GRADLE_VERSION}
#ENV GRADLE_HOME=${GRADLE_HOME}
#ARG GRADLE_PACKAGE=gradle-${GRADLE_VERSION}-bin.zip
#ARG GRADLE_PACKAGE_URL=https://services.gradle.org/distributions/${GRADLE_PACKAGE}
#
#RUN mkdir -p ${GRADLE_INSTALL_BASE} && \
#    cd ${GRADLE_INSTALL_BASE} && \
#    wget -q --no-check-certificate -c ${GRADLE_PACKAGE_URL} && \
#    unzip -d ${GRADLE_INSTALL_BASE} ${GRADLE_PACKAGE} && \
#    ls -al ${GRADLE_HOME} && \
#    ln -s ${GRADLE_HOME}/bin/gradle /usr/bin/gradle && \
#    ${GRADLE_HOME}/bin/gradle -v && \
#    rm -f ${GRADLE_PACKAGE}

## node uncomment if needed
#ARG NODE_VERSION=${NODE_VERSION:-14}
#ENV NODE_VERSION=${NODE_VERSION}
#RUN apt-get update -y && \
#    apt-get install -y sudo curl git xz-utils && \
#    curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - && \
#    apt-get install -y nodejs

# Extra-tools
RUN apt-get update && \
    apt-get install -y graphviz && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN curl -L https://sourceforge.net/projects/plantuml/files/plantuml.jar/download > /usr/local/bin/plantuml.jar
RUN curl -L https://github.com/schemaspy/schemaspy/releases/download/v6.1.0/schemaspy-6.1.0.jar > /usr/local/bin/schemaspy.jar
ADD bin/plantuml /usr/local/bin
ADD bin/schemaspy /usr/local/bin

# use local system user for generated files
ENV USER_ID=${USER_ID:-1000}
ENV GROUP_ID=${GROUP_ID:-1000}
ENV USER=${USER:-developer}
ENV HOME=/home/${USER}

## -- setup NodeJS user profile
RUN groupadd ${USER} && useradd ${USER} -m -d ${HOME} -s /bin/bash -g ${USER} && \
    ## -- Ubuntu -- \
    usermod -aG sudo ${USER} && \
    ## -- Centos -- \
    #usermod -aG wheel ${USER} && \
    echo "${USER} ALL=NOPASSWD:ALL" | tee -a /etc/sudoers && \
    echo "USER =======> ${USER}" && ls -al ${HOME}

# npm-prefix
ENV NPM_CONFIG_PREFIX=${NPM_CONFIG_PREFIX:-${HOME}/.npm-global}
ENV PATH="${NPM_CONFIG_PREFIX}/bin:$PATH"
RUN mkdir -p ${NPM_CONFIG_PREFIX} ${HOME}/.config ${HOME}/.npm && \
    chown ${USER}:${USER} -R ${NPM_CONFIG_PREFIX} ${HOME}/.config ${HOME}/.npm


# drop user privileges
# USER ${USER}
# WORKDIR ${HOME}

CMD ["/bin/bash"]
