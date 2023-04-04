FROM amazoncorretto:8-alpine3.17-jdk
WORKDIR /opt/app
ENV project_name=Test01 project_version=0.0.1-SNAPSHOT
ARG SOURCE=target/${project_name}-${project_version}.tar.gz
RUN addgroup -S test && adduser -S test -G test && tar -zxvf SOURCE -C ./
USER test:test
ENTRYPOINT [ "sh /opt/app/boot.sh start" ]
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "sh /opt/app/boot.sh status" ]
