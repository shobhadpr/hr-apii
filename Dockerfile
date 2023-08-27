FROM maven:3.8.1-jdk-11-slim
LABEL AUTHOR="Java Home"
WORKDIR /app
COPY . .
RUN mvn clean package
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.80/bin/apache-tomcat-9.0.80.tar.gz .
RUN tar xf apache-tomcat-9.0.80.tar.gz
RUN rm -rf apache-tomcat-9.0.80.tar.gz
RUN mv apache-tomcat-9.0.80 tomcat9
RUN cp target/hr-api.war /app/tomcat9/webapps
EXPOSE 8080
CMD ["/app/tomcat9/bin/catalina.sh", "run"]

