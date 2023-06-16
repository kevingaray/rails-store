# Store
Store web app created on the trainee program Ruby on Rails from Applaudo Studios
* ruby: 3.1.2
* rails: 6.1.7
* style: Bootstrap 4.4
* database: PostgreSQL
* storage images: amazon s3

To run this locally, create a .env file with credentials for the postgres database
```
DB_USERNAME = postgres
DB_PASSWORD = admin
```

Run ```db:seed``` to create the items and users:
| user      | email                     | password |
|-----------|---------------------------|----------|
| admin     | admin@snackstore.com      | 123456   |
| support   | support@snackstore.com    | 123456   |
| customer  | michi@snackstore.com      | 123456   |

# Functions

| user      | Functions                                                    |
|-----------|--------------------------------------------------------------|
| admin     | Create and eliminate items, view "items change logs" page    |
| support   | Edit items                                                   | 
| customer  | Like items , add to cart and buy                             |


# Deploy
Visit the fly.io version [Rails Store](https://rails-store.fly.dev/)

# Documentation
Running with yard
```
yard server --reload
```

Visit the API documentation
[Swagger API](https://app.swaggerhub.com/apis/KGARAY_1/SnackStoreKevGer/1.0.0)

# Test
Minitest(default) with FactoryBot
