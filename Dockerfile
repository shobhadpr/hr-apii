FROM maven:3.8.1-jdk-11-slim AS build
LABEL AUTHOR="Java Home"
WORKDIR /app
COPY . . #copy everything from local means pom file , src ---etc
RUN mvn clean package

