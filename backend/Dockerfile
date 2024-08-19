FROM maven:sapmachine AS build

COPY src /app/src
COPY pom.xml /app

WORKDIR /app
RUN mvn clean install package

FROM amazoncorretto:21.0.3

COPY --from=build /app/target/*.jar /app/app.jar

WORKDIR /app

EXPOSE 3000

CMD ["java", "-jar", "app.jar"]