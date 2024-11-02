FROM ubuntu:latest AS build
RUN apt-get update
RUN apt-get install openjdk-17-jdk -y
COPY . .
RUN ./gradlew bootJar --no-daemon

FROM openjdk:17-jdk-slim
EXPOSE 9091

COPY --from=build /build/libs/backend-parent-0.0.1-SNAPSHOT.jar backend-parent-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java", "-jar", "backend-parent-0.0.1-SNAPSHOT.jar"]