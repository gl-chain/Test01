FROM openjdk:8
WORKDIR /opt/app
COPY ./target/Test01-0.0.1-SNAPSHOT.tar.gz ./
RUN tar -zxvf Test01-0.0.1-SNAPSHOT.tar.gz -C ./ \
    && rm -rf ./Test01-0.0.1-SNAPSHOT.tar.gz
EXPOSE 8080
ENV APP_NAME="com.chengl.test01.Test01Application" 
ENV CLASSPATH="classpath:./lib/*"
ENTRYPOINT ["sh", "-c", "java -server -Xms1g -Xmx1g -Xss256k -Xmn600m -classpath $CLASSPATH $APP_NAME -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=256m -XX:-OmitStackTraceInFastThrow -Duser.timezone=Asia/Shanghai -Dclient.encoding.override=UTF-8 -Dfile.encoding=UTF-8 > ./console.log"]
#HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD ["/opt/app/boot.sh status"]
