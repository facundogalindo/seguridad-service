FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Etapa 2: Ejecutar el .jar
FROM openjdk:21-jdk-slim
WORKDIR /app
# Copiamos exactamente el jar con nombre fijo
COPY --from=build /app/target/*-SNAPSHOT.jar app.jar
EXPOSE 9000
ENTRYPOINT ["java", "-jar", "app.jar"]