FROM openjdk:22-slim

WORKDIR /app

COPY apiGateway-service/target/apiGateway-service-0.0.1-SNAPSHOT-exec.jar app.jar

EXPOSE 8001

CMD ["java", "-jar", "app.jar"]
