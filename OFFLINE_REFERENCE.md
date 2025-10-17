# Offline Rails Development Reference

  ## Common Commands

  ### Rails Generators
  - `rails generate model Post title:string body:text published:boolean`
  - `rails generate controller Posts index show new create edit update destroy`
  - `rails generate scaffold Article title:string content:text`
  - `rails generate stimulus [controller_name]`

  ### Database
  - `rails db:create` - Create databases
  - `rails db:migrate` - Run migrations
  - `rails db:rollback` - Undo last migration
  - `rails db:seed` - Load seed data
  - `rails db:reset` - Drop, create, migrate, seed

  ### Running the App
  - `bin/dev` - Start Rails + Tailwind CSS watcher
  - `rails server` or `rails s` - Just Rails server
  - `rails console` or `rails c` - Rails console

  ### Docker
  - `docker-compose up` - Start all services
  - `docker-compose down` - Stop all services
  - `docker-compose build` - Rebuild containers
  - `docker-compose exec web rails console` - Console in container

  ## Turbo Concepts
  - **Turbo Drive**: Intercepts clicks, makes them AJAX, swaps body
  - **Turbo Frames**: Lazy-loaded independent page sections
  - **Turbo Streams**: Real-time partial page updates over WebSocket or HTTP

  ## Stimulus Concepts
  - **Controllers**: JavaScript classes that add behavior to HTML
  - **Targets**: Elements you want to reference in your controller
  - **Actions**: Events that trigger controller methods
  - **Values**: Data passed from HTML to JavaScript

  ## File Locations
  - Models: `app/models/`
  - Controllers: `app/controllers/`
  - Views: `app/views/`
  - Stimulus Controllers: `app/javascript/controllers/`
  - Routes: `config/routes.rb`
  - Database Config: `config/database.yml`
