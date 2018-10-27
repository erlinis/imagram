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



## 3. Guardando imagenes

Para subir imagenes a nuestro servidor necesitamos instalar una pieza de software, llamada `gema`.
En Ruby, a las librerías se les conoce con el nombre de [gemas](https://blog.makeitreal.camp/manejo-de-dependencias-en-ruby-con-bundler/). Una librería no es más que código empaquetado que alguien publica y que puedes utilizar en tus proyectos.

Usando tu editor texto abre el archivo `Gemfile` que se encuentra en la raíz del directorio  y al final de archivo agrega los siguiente:

```ruby
# Use Carrierwave to upload images on the server
gem 'carrierwave'
```

> :floppy_disk: ¡Guarda los cambios!

En la terminal ejecuta:

```sh
bundle install
```

Ahora podemos generar el código para el manejar la subida de imagenes, para eso en la terminal ejecuta:

```sh
rails generate uploader Picture
```

La gema que agregamos creará un nuevo archivo `app/uploaders/picture_uploader.rb`

> Si el servidor está corriendo. Presiona `Ctrl` + `C` para cerrarlo y luego ejecuta `rails server` para iniciarlo.
> Es necesario reiniciar el proceso del servidor Rails para que la aplicación pueda cargar el código generado por la librería recién agregada.

Para usar el codigo generado previamente abrimos el archivo `app/models/post.rb` y debajo de la línea

```ruby
class Post < ApplicationRecord
```
agregamos

```ruby
  mount_uploader :picture, PictureUploader
```

Luego abre `app/views/posts/_form.html.erb` y cambia

```ruby
  <%= form.text_field :picture, id: :post_picture %>
```

por

```ruby
<%= form.file_field :picture, id: :post_picture %>
````

> :floppy_disk: ¡Guarda todos los cambios!

Ingresa a [http://localhost:3000/posts](http://localhost:3000/posts) en tu navegador y agrega un nuevo _post_ con una imagen. Notarás cuando cargas una imagen que esta no se ve, esto es porque te muestra sólo la ruta del archivo, para arreglar eso abre el archivo `app/views/post/show.html.erb` y cambia

```ruby
<%= @post.picture %>
```

por:

```ruby
<%= image_tag(@post.picture_url, :width => 300) if @post.picture.present? %>
````

> :floppy_disk: ¡Guarda todos los cambios!

Ahora refresca tu navegador para ver los cambios.
