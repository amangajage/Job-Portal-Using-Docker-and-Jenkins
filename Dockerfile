# Stage 1: Build the Java application
FROM maven:3.9-eclipse-temurin-8 AS build

WORKDIR /app

COPY pom.xml .

RUN mvn dependency:go-offline

COPY src ./src

RUN mvn clean package -DskipTests


# Stage 2: Run the application using Tomcat
FROM tomcat:9-jdk8

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build /app/target/Job_Portal.war /usr/local/tomcat/webapps/Job_Portal.war

EXPOSE 8080

CMD ["catalina.sh", "run"]