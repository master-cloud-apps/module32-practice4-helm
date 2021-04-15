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
Máster Cloud Apps
Módulo III - Aplicaciones nativas de la nube
Contenedores y Orquestadores
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

### Helm Chart
1. Se crea la estructura del chart en la carpeta **eoloplanner** mediante el comando:
   ```sh
   helm create eoloplanner
   ```


## Autores

👤 **Diego Fernández**

* GitLab: [@TheChameleon](https://gitlab.com/TheChameleon)

👤 **Álvaro Martín Martín**

* Github: [@amartinm82](https://github.com/amartinm82)