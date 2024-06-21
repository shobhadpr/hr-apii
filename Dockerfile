From alpine:latest
LABEL AUTHOR "JAVA HOME"
RUN apk add openjdk17-jre
WORKDIR /opt
ADD https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.25/bin/apache-tomcat-10.1.25.tar.gz .
RUN tar xf apache-tomcat-10.1.25.tar.gz
RUN rm -rf apache-tomcat-10.1.25.tar.gz
RUN mv apache-tomcat-10.1.25 tomcat10
COPY target/hr-api.war /opt/tomcat10/webapps
EXPOSE 8001
CMD ["/opt/tomcat10/bin/catalina.sh","run"]
