FROM maven:3.8.1-jdk-11-slim AS build
LABEL AUTHOR="Java Home"
WORKDIR /app
COPY . .
RUN mvn clean package

FROM tomcat:9-jre11-slim
WORKDIR /opt
COPY --from=build /app/target/hr-api.war /opt/tomcat9/webapps
EXPOSE 8080
CMD ["/opt/tomcat9/bin/catalina.sh", "run"]

