- 为了减小SpringBoot应用的docker镜像体积，我们使用JRE为基础镜像，不需要使用JDK为基础镜像。
- 下载jdk包：https://www.oracle.com/java/technologies/oracle-java-archive-downloads.html
- 解压：tar -zxvf jre-8u291-linux-x64.tar.gz
- cd jre
- 删除不必要文件
- rm -rf COPYRIGHT LICENSE README release THIRDPARTYLICENSEREADME-JAVAFX.txt THIRDPARTYLICENSEREADME.txt Welcome.html
- ```
  rm -rf  lib/plugin.jar \
           lib/ext/jfxrt.jar \
           bin/javaws \
           lib/javaws.jar \
           lib/desktop \
           plugin \
           lib/deploy* \
           lib/*javafx* \
           lib/*jfx* \
           lib/amd64/libdecora_sse.so \
           lib/amd64/libprism_*.so \
           lib/amd64/libfxplugins.so \
           lib/amd64/libglass.so \
           lib/amd64/libgstreamer-lite.so \
           lib/amd64/libjavafx*.so \
           lib/amd64/libjfx*.so
  ```
  - 新建Dockerfile文件并写入以下内容：
  - ```
    FROM docker.io/frolvlad/alpine-glibc
    COPY jre8/ /usr/local/jre
    ENV JAVA_HOME /usr/local/jre
    ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
    ENV PATH $PATH:$JAVA_HOME/bin
    ```
  - 构建JRE8镜像:
  - docker build -t jre:8 .  
