#################################################
# Imagen base para el contenedor de compilación
#################################################
FROM maven:3.6.3-openjdk-11 as builder

# Define el directorio de trabajo donde ejecutar comandos
WORKDIR /project

# Copia el código del proyecto
COPY pom.xml /project/
COPY /src /project/src

# Compila proyecto y descarga librerías
RUN mvn package

#################################################
# Imagen base para el contenedor de la aplicación
#################################################
FROM openjdk:11-jre-slim-buster

# Define el directorio de trabajo donde se encuentra el JAR
WORKDIR /usr/planner/

# Instalamos cURL para poder añadir wait-for-it
RUN apt-get update && apt-get install -y \
curl \
bash \
&& rm -rf /var/lib/apt/lists/*

# Añadimos wait-for-it para esperar a que arranque la BD MySQL
RUN curl -LJO https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && chmod +x /usr/planner/wait-for-it.sh

# Copia el JAR del contenedor de compilación
COPY --from=builder /project/target/*.jar /usr/planner/planner.jar

# Comando que se ejecuta al hacer docker run
CMD [ "java", "-jar", "planner.jar" ]