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

## 4. Añadiendo navegación

La aplicación no se ve muy bien. Usaremos el proyecto [Bootstrap](http://getbootstrap.com/getting-started/) para darle un mejor estilo.

Para esto instalaremos la gema que nos permite usarlo.

Abre el archivo `Gemfile` en tu editor de código y  al final del archivo agrega:

 ```ruby
  gem 'bootstrap-sass', '~> 3.3.7'
 ```

En la terminal ejecuta:

```sh
bundle install
```

### Layout
Ahora cambiaremos el layout de la aplicación, para est0 abre el archivo `app/views/layouts/application.html.erb` en tu editor de código y reemplaza *todo* el contenido por este:

```ruby
<html>
  <head>
    <title>Imagram</title>
    <%= csrf_meta_tags %>
    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
    <nav class="navbar navbar-default navbar-fixed-top">
      <div class="navbar-container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="/">Imagram</a>
        </div>
        <div id="bs-navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li><%= link_to "Posts", posts_path %></li>
            <li><%= link_to "New Post", new_post_path %></li>
          </ul>
        </div>
      </div>
    </nav>
    <br/>

    <div class="container">
      <br/>
      <%= yield %>
    </div>

    <footer>
      <div class="container">
        <p>Imagram - Barranquilla 2018</p>
      </div>
    </footer>
  </body>
</html>
```

y ahora cambiaremos la forma como se muestran las publicaciones, para esto abre el archivo ` app/views/posts/index.html.erb` y reemplaza *todo* el contenido por este:

```ruby
<div class="posts-wrapper row">
    <% @posts.each do |post| %>
      <div class="post">
        <div class="post-head">
          <div class="name">
             Taller Pioneras
          </div>
        </div>

        <div class="image center-block">
          <%= image_tag(post.picture_url, :class => "img-responsive") if post.picture.present? %>
        </div>
        <p class="caption"> <%= post.caption %> </p>

        <div class="text-center edit-links">
          <%= link_to 'Edit', edit_post_path(post) %>
          |
          <%= link_to 'Destroy', post, method: :delete, data: { confirm: 'Are you sure?' } %>
        </div>
      </div>

    <% end %>
</div>
```


### ¡Ahora el  *css*! 
Ve al archivo *app/assets/stylesheets/application.css* y cambiar su exetensión a *.scss*

Luego abre el archivo, y borra las siguiente lineas:

```ruby
 *= require_tree .
 *= require_self
```

y al final del archivo pega este contenido:

```ruby
@import "bootstrap-sprockets";
@import "bootstrap";

body {
 background-color: #dbe8f0;
  font-family: proxima-nova, 'Helvetica Neue', Arial, Helvetica, sans-serif;
}

.navbar-brand {
  a{
    color: #125688;
  }
}

.navbar-default {
  background-color: #fff;
  height: 54px;
  .navbar-nav li a {
    color: #125688;
  }
}

.navbar-container {
  width: 640px;
  margin: 0 auto;
}

.posts-wrapper {
  padding-top: 40px;
  margin: 0 auto;
  max-width: 642px;
  width: 100%;
}

.post {
  background-color: #fff;
  border-color: #edeeee;
  border-style: solid;
  border-radius: 3px;
  border-width: 1px;
  margin-bottom: 60px;
}

.post-head {
  height: 64px;
  padding: 14px 20px;
  color: #125688;
  font-size: 15px;
  line-height: 18px;
  .thumbnail {
  }
  .name {
    display: block;
  }
}

.image {
  border-bottom: 1px solid #eeefef;
  border-top: 1px solid #eeefef;
}

.caption {
  padding: 24px 24px;
  font-size: 15px;
  line-height: 18px;
}

.form-wrapper { width: 100%;
  margin: 2px auto;
  background-color: #fff;
  padding: 10px;
  border: 1px solid #eeefef;
  border-radius: 3px;
}

.edit-links {
  margin-top: 10px;
  margin-bottom: 20px;
}

```

> :floppy_disk: ¡Guarda todos los cambios!


Mira como luce la aplicación y en [http://localhost:3000/posts](http://localhost:3000/posts)


## 5. Agregando comentarios

Seamos más sociales permitiendo que se puedan añadir comentarios sobre nuestros _posts_, para esto  en la terminal presionamos `Ctrl` + `C` para detener el servidor y ejecutamos el siguiente comando:

```sh
rails g model comments content:text post:references
```

Se generaran unos archivos, uno de los más importatntes es la migración, pues contiene la definición de la tabla donde se guardaran los comentarios.

Ejecutamos la migración para crear la tabla en la base de datos con el comando:

```sh
rake db:migrate
```

Creemos la relación entre _post_ y _comments_. Abrimos el archivo `app/models/post.rb` y debajo de la línea

```ruby
  mount_uploader :picture, PictureUploader
```

agregamos

```ruby
 has_many :comments, :dependent => :destroy
 accepts_nested_attributes_for :comments,  :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
```

Ahora necesitamos una formulario para escribir los comentarios, entonces abrimos `app/views/posts/index.html.erb` y encima de las lineas

```ruby
 <div class="text-center edit-links">
  <%= link_to 'Edit', edit_post_path(post) %>
```

agrega

```ruby
<div class="form-wrapper">
 <%= form_for([post, post.comments.build]) do |f| %>
     <%= f.label :content %>
     <%= f.text_area :content %>
     <%= f.submit 'comment' %>
  <% end %>
</div>
```

Ahoara creemos el archivo el controlador que se encargará de guardar los comentarios, en la terminal ejecutaremos:

```sh
rails g controller comments

```

Luego abre el archivo `app/controllers/comment_controller.rb` y pega

```ruby
class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.save
    redirect_to posts_path
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end
```

en el archivo `config/routes.rb`, borrar la linea `resources :posts`y agrega lo siguiente:

```ruby
  root 'posts#index'
  resources :posts do
   resources :comments
  end
```

> :floppy_disk: ¡Guarda todos los cambios!

 Iniciamos nuevamente el servidor con:
```sh
rails server
```


Entra a [http://localhost:3000/posts](http://localhost:3000/posts) y agrega un comentario.

Nótaras que no se pueden ver los comentario agregados, para poder visualizarlos entra al archivo `app/views/posts/index.html.erb` y encima de la linea

```ruby
<div class="form-wrapper">
   <%= form_for([post, post.comments.build]) do |f| %>
```

agrega

```ruby
  <% post.comments.each do |comment| %> <span class="text-muted">
      <%= comment.created_at.to_formatted_s(:short) if comment.created_at.present? %>
    </span> | <%= comment.content %>
    <br>
  <% end %>

```

Ahora refresca tu navegador para ver los comentarios.


