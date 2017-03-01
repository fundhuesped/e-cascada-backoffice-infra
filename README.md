# Turnos Backoffice Infra

Proyecto que contiene configuraciones de cada uno de los componentes de la infra:

* Configuración NGINX
* Docker compose con definición de los contenedores
* Contenido estático de Django para ser servido por NGINX
* Scripts para obtener / actualizar BE y FE

## Setup de instancia CoreOS

Se debe ejecutar el script `coreos_setup.sh` como **root** que realizará las siguientes tareas:

1. Instala **docker-compose**
2. Agrega usuario al group **docker** del os


## Variables de entorno necesarias

* `DBUSER`: Nombre del usuario de la base de datos a instanciar
* `DBPASSWORD`: Password del usuario de la base de datos a instanciar
* `DBNAME`: Nombre de la instancia de base de datos a instanciar
* `SERVERNAME`: Dominio a configurar en Nxing para el reverse proxy (Ej: turnos.hospital.com)
* `APPUSER`: Nombre del usuario que correrá los containers de Docker

Todas estas varialbes pueden setearse directamente en el ambiente o bien en el script setenv.sh para ser utilizado luego


## Scripts

* `setenv.sh`: Setea las variables de entorno necesarias para la aplicación.
* `configure_nginx.sh`: Setea el hostname en Nginx a partir de la variable de entorno $SERVERNAME. Sólo debe hacerse durante el setup inicial.
* `get_sources.sh`: git clone de los proyectos FE y BE. Sólo debe hacerse durante el setup inicial.
* `update_projects.sh`: git pull sobre FE y BE
* `start_docker.sh`: inicia o reinicia **Turnos Backoffice** con docker-compose
* `coreos_setup.sh`: inicializa instancia de CoreOS


## Pasos para instalar una instancia
1. Setear las variables de entorno ya sea con el script setenv o manualmente.
2. Descargar el código fuente utilizando el script get_sources.sh

```bash
	./get_sources.sh
```
3. Configurar Nginx utilizando el script configure_nginx.sh

```bash
	./configure_nginx.sh
```
4. Ejecutar docker compose para levantar los containers

```bash
	./start_docker.sh
```

## Tareas post inicio de aplicación

1. Crear super usuario

```bash
	docker exec -ti turnosbackoffice_be_1 python manage.py createsuperuser
```
2. Backup de base de datos

```bash
# Acceder al container de PostgreSQL
docker exec -ti turnosbackoffice_db_1 /bin/bash
# Realizar Backup
pg_dump hues_turnos -U fhuser -W -f /var/lib/postgresql/data/dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql
```
