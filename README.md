# Práctica 4. Helm

## Enunciado
El objetivo de esta práctica consiste en desarrollar una modificación en el planner de la
Práctica 3 y crear un chart del mismo.

### Cambios en el Planner
Se debe implementar un cambio básico en el planner porque los de negocio nos habían
indicado mál sus requisitos. En la aplicación original se indica que:

    “El resultado de la creación de la planta será creará de la siguiente forma: la ciudad
    concatenada a la respuesta del servicio que responda primero concatenada a la
    respuesta del segundo. El resultado se convertirá a lowercase si la ciudad empieza por
    una letra igual o anterior a M o en uppercase si es posterior”.

Pero en realidad debería ser justo al revés.

    “El resultado de la creación de la planta será creará de la siguiente forma: la ciudad
    concatenada a la respuesta del servicio que responda primero concatenada a la
    respuesta del segundo. El resultado se convertirá a **uppercase** si la ciudad empieza
    por una letra igual o anterior a M o en **lowercase** si es posterior”.

Para realizar este cambio, se utilizará una herramienta de desarrollo en la que el servicio
planner se pueda ejecutar en modo depuración (con un punto de ruptura en el código que
implementa la lógica de negocio) y el resto de servicios se ejecuten en el cluster
Kubernetes. La herramienta puede ser Okteto o VSCode.

Se deberá grabar un vídeo en el que se pueda ver cómo salta el punto de ruptura cuando
se usa el server desde el cluster Kubernetes.

La imagen modificada deberá publicarse en DockerHub y usarse en el chart.

### Helm Chart
Los aspectos que deben de poder configurar al desplegar el chart deben ser los siguientes:
* Se debe permitir que convivan dos releases del mismo chart en el mismo
namespace a la misma vez sin ningún tipo de interferencia. Eso implica que los
nombre de los recursos, las etiquetas y demás identificadores que sean necesarios
estén prefijados con el nombre de la release.
* Se podrá activar o desactivar el ingress para la aplicación. Se tendrá en cuenta
cómo afecta la existencia de ingress a otros recursos del despliegue para que el
server y el toposervice sigan siendo accesibles desde el exterior (obviamente sin
compartir dominio).
* Se deberá poder configurar el tipo de servicio para publicar el server y el toposervice
en caso de que no se use el ingress.
* Se deberá poder configurar el dominio del host del ingress.
* Se deberá poder configurar si se crean los PersistenceVolumes o se asume que
están ya creados en el cluster o se crean de forma dinámica con un StorageClass.
* En caso de que al instalar se decida que no se crean los PersistenceVolumes, se
deberá permitir configurar el storageClassName por cada uno de los servicios que
los necesiten.
* Se deberá poder configurar si se aplican Network Policies o no.
* Se deberá poder configurar la imagen y el tag de cada uno de los servicios.
* Se deberá publicar un repositorio con el chart en un servidor http (GitHub, por
ejemplo) y darlo de alta en ArtifactHUB.
* Las constraseñas se deberán crear de forma aleatoria, pero también se podrán
parametrizar sus valores. En ese caso, cuando se especifique el valor de una
contraseña, se deberá poder usar tanto para el servicio en sí (p.e. MySQL) como
para el cliente de ese servicio (p.e. el server).
* En el NOTES.txt se deberá indicar cómo acceder a los servicios una vez desplegada
la release. Esa información deberá depender de si se usa ingress o no.
Se debe grabar un vídeo en el que se vea cómo se despliega una release con ingress y
luego se actualiza esa release para que no use ingrees. En el vídeo se tienen que mostrar
los recursos kubernetes que se ven afectados por el cambio. También se tiene que mostrar
el servicio funcionando en ambos casos.

## Formato de entrega
La práctica se entregará teniendo en cuenta los siguientes aspectos:
* La práctica se entregará como un fichero .zip con el código del los diferentes
servicios y los ficheros auxiliares. El nombre del fichero .zip será el correo URJC del
alumno (sin @alumnos.urjc.es).

Las prácticas se podrán realizar de forma individual o por parejas. En caso de que la
práctica se haga por parejas:
* Sólo será entregada por uno de los alumnos
* El nombre del fichero .zip contendrá el correo de ambos alumnos separado por
guión. Por ejemplo p.perezf2019-z.gonzalez2019.zip

## Resolución de la práctica

Para ejecutar la práctica se han de ejecutar los siguientes pasos:
1. Arrancar minikube con el driver de virtualbox y los parámetros necesarios para cilium
   ```sh
   minikube start --cni=cilium --memory=8192 --driver=virtualbox
   ```
2. Habilitar el ingress:
   * Actualizar la nueva IP de minikube.
     ```sh
     minikube addons enable ingress
     export MINIKUBE_IP=$(minikube ip)
     ```
   * Recuperar el nuevo valor de la variable y modificar en /etc/hosts la nueva IP asociada al nombre dado al host en el chart (por defecto es _cluster-ip_).
     ```sh
     echo $MINIKUBE_IP
     sudo vi /etc/hosts
     ```
**NOTA:** No es necesario añadir la label al namespace _kube-system_ para que funcionen los accesos mediante network-policies, ya que al ingress se le habilitan los accesos a cualquier namespace:
   ```yaml
   ingress:
   - from:
    - namespaceSelector: {}
      podSelector:
        matchLabels:
          app.kubernetes.io/name: ingress-nginx
   ```

### Cambios en el Planner
Se ha optado por el uso de Okteto con VSCode. Para ello:
1. Levantamos el cluster usando el chart de helm definido sin usar ingress ni network-policies:
   ```sh
   helm install --set global.np.enabled=false --set ingress.enabled=false eolo eoloplanner/.
   ```
2. Una vez arrancado el cluster el nombre del deploy del planner en el cluster se compone con el nombre de la release: **_release-name>_**-planner-deploy. Por tanto se ha de modificar el archivo _okteto.yml_ para que use dicho nombre del deployment (en este ejemplo la release es _eolo_):
   ```yaml
   name: eolo-planner-deploy
   image: maven:3.8.1-jdk-11
   workdir: /okteto
   volumes:
   - /root/.m2
   - /root/.vscode-server
   forward:
   - 8080:8080
   - 35729:35729
   ```
3. Se han instalado los plugins necesarios en VSCode.
4. Se ha lanzado el _Okteto: Up_
5. Se selecciona el fichero [okteto.yml](./planner/okteto.yml) en el path del código fuente
6. Una vez conectados al pod, se generan los fuentes necesarios de GRPC lanzando el comando:
   ```sh
   mvn clean compile
   ```
7. Ponemos punto de ruptura en la línea 54 del fuente [Eoloplant.java](./planner/src/main/java/es/codeurjc/mastercloudapps/planner/models/Eoloplant.java) en el editor remoto.
8. Ejecutamos en modo Debug
9. Accedemos a la URL correspondiente de la app y generamos una nueva planta.
10. Se comprueba que se para en el punto de ruptura.

Se incorpora además el código fuente del [planner](./planner) con los cambios solicitados, y un script [generate_planner_image.sh](generate_planner_image.sh) para generar la imagen y subirla a un repo de DockerHub como versión v2.0. Dicha versión se usa por defecto en el chart de Helm.

### Helm Chart
1. Se crea la estructura del chart en la carpeta **eoloplanner** mediante el comando:
   ```sh
   helm create eoloplanner
   ```
2. Dentro de esa carpeta se ha definido la siguiente estructura:
   * charts: contiene los subcharts necesarios para el proyecto, que son las bases de datos y el broker.
     * mongodb: chart de helm para mongodb
     * mysql: chart de helm para mysql
     * rabbitmq: chart de helm para rabbitmq
   * templates: contiene los manifiestos necesarios para componer el proyecto organizados por carpetas para cada servicio.
     * ingress
     * planner
     * server
     * toposervice
     * weatherservice
   * values contiene las variables necesarias para el chart. Estas variables permiten activar/desactivar el ingress, las network-policies, la creación de volúmenes, etc.

3. Para instalar el Chart ejecutar:
   ```sh
   helm install <NAME> eoloplanner/.
   ```
   Esto levantará el cluster con el ingress, las np y la creación de volúmenes activas por defecto. Para desactivar cualquiera de esas opciones lanzar el comando:
   ```sh
   helm install --set ingress.enabled=false --set global.np.enabled=false --set <subchart>.persistence.volume.enabled=false <NAME> eoloplanner/.
   ```
   Donde subchart puede ser cualquiera de los subcharts del proyecto: mongodb, mysql, rabbitmq.


4. Para desinstalar el Chart ejecutar:
   ```sh
   helm uninstall <NAME>
   ```




## Autores

👤 **Diego Fernández**

* GitLab: [@TheChameleon](https://gitlab.com/TheChameleon)

👤 **Álvaro Martín Martín**

* Github: [@amartinm82](https://github.com/amartinm82)