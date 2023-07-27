FROM docker.io/frolvlad/alpine-glibc
COPY jre8/  /usr/local/jre
ENV JAVA_HOME /usr/local/jre
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $PATH:$JAVA_HOME/bin