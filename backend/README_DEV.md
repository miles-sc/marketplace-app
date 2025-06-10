backend/app/models/product.rb defines a data type called Product- each "row" of the database is a Product

backend/db/migrate/20250609_create_products.rb tells rails to create the database and add specific "columns" to it- can add more later with more migrations

backend/app/controllers/products_controller.rb contains methods that can be run to return values using the database

backend/config/routes.rb translates requests that come in from the frontend into methods from the controller that need to be run
