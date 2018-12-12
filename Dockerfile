FROM openjdk:8-jdk-alpine
MAINTAINER mc0222
VOLUME /tmp
ADD ./build/libs/app.jar app.jar
EXPOSE 8888
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-Xmx200m","-jar","/app.jar"]
