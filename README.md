# Pioneras dev - Barranquilla, Octubre 2018

Taller gratuito para aprender a desarrollar aplicaciones web con Ruby on Rails.

Fecha del evento: Octubre 27 2018

## 1. Creando la aplicación

Primero, abrimos una terminal:

- Mac OS X: Abre Spotlight, digite Terminal y click en la applicación Terminal.
- Windows: Click en Inicio y busca Comando Prompt, luego click Comando Prompt con Ruby on Rails.
- Linux (Ubuntu): Buscar por Terminal en el dash y click Terminal.

Una vez en la terminal digitamos estos comandos:

Para crear una nueva carpeta:

```sh
mkdir proyectos
```

Ahora para ingresar al folder proyectos ejecuta el comando:

```sh
cd proyectos
```

Puedes validar que estás ahora en un directorio o folder vacío, ejecutando el comando de listado  `ls`.
Ahora crearemos una nueva aplicación rails:

```sh
rails new imagram
``` 
 **imagram** es un nombre de ejemplo, puedes cambiarlo.

Esto creará una nueva aplicación en el folder `imagram`, así que nuevamente tenemos 
que cambiar el directorio para ingresar a nuestra app. Ejecuta:

```sh
cd imagram
```

Si ejecutas `ls` dentro del directorio, deberías ver algunas carpetas como _app_ y _config_ entre otros arhivos.
Puedes comenzar el servidor de rails, ejecutando:

```sh
rails server
```
Ingresa a [http://localhost:3000](http://localhost:3000) en tu navegador.  Debería verse una 
página con el mensaje:  _Yay! You're on Rails!_, lo que significa que la generación de tu nueva aplicación esta funcionando correctamente.

Presiona `Ctrl`+`C` en el terminal para salir del servidor.


## 2. Crear Posts

Vamos a usar el comando `scaffold` para generar un punto de partida que nos permita listar, agregar, eliminar, editar, y ver posts, para esto ejecuta el siguiente comando en la terminal:

```sh
rails generate scaffold post caption:text picture:string
```
El comando `scaffold` crea nuevos archivos en el directorio del proyecto, los más importantes este momento, debido a que estaremos trabajando en ellos son:

| Archivo / Carpeta                   | Desripción                                                 |
|:----------------------------------: |:----------------------------------------------------------:|
| app/models/post.rb                  | Clase que representa el concepto _Post_                    |
| app/controller/posts_controller.rb  | Maneja todas las acciones que se hacen sobre los _Posts_       |
| db/migrate/2018..._create_posts.rb  | Definición para crear la tabla _Posts_ en la base de datos |
| app/views/...                       | Contiene las interfaces para crear, listar, editar posts   |


Para que la información de los Posts se guarden en la base de datos, debemos aplicar los cambios de la migración. Las [migraciones](https://edgeguides.rubyonrails.org/active_record_migrations.html) en rails nos ayudan a modificar nuestra base de datos de forma organizada.

Ejecutemos este comando en la terminal:

```sh
rake db:migrate
```

Obtendras una salida como esta:

```sh
== 20181027141706 CreatePosts: migrating ======================================
-- create_table(:posts)
   -> 0.0024s
== 20181027141706 CreatePosts: migrated (0.0026s) =============================
```

 Iniciamos nuevamente el servidor con:
```sh
rails server
```

Prueba lo que se ha generado hasta el momento ingresando a [http://localhost:3000/posts](http://localhost:3000/posts) en tu navegador.
Crea,  edita y mira la información de los _posts_.
