FROM maven:3.6.3-openjdk-11-slim as build

WORKDIR /app

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

#RUN ./mvnw dependency:go-offline -B

COPY src src
RUN mvn package

#RUN ./mvnw package -DskipTests
#RUN mkdir -p target/dependency && (cd target/dependency; jar -xf ../* .jar)

#FROM openjdk:11-jre-alpine

#ARG DEPENDENCY=/app/target/dependency

#COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /backend/lib
#COPY --from=build ${DEPENDENCY}/META-INF /backend/META-INF
#COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /backend

FROM openjdk:11

COPY --from=build /app/target/api-server-0.0.1-SNAPSHOT.jar .

EXPOSE 8080
CMD ["java", "-jar", "/api-server-0.0.1-SNAPSHOT.jar"]

#ENTRYPOINT ["java", "-cp", "backend:backend/lib/*", "me.test.apiserver.ApiServerApplication"]
