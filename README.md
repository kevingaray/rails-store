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

To see an insomnia collection look at file 
```
Insomnia_2023-06-16.json
```

## Jobs
Using sidekiq, requires to have [redis](https://redis.io/docs/getting-started/) installed and running to like and dislike items
Visit the sidekiq url http://127.0.0.1:3000/admin/sidekiq


## Test
Minitest(default) with FactoryBot


## Stripe Sync
To sync all items to the stripe account, run 
```
rails stripe:sync_items
```

# Screenshots
Deploy version
![image](https://github.com/kevingaray/rails-store/assets/48739137/e4c50536-47f6-4d24-9af4-4b7452e70830)
Item page with image on AWS
![image](https://github.com/kevingaray/rails-store/assets/48739137/e3216dd1-4b85-4bec-927f-b839414662df)
Cart view
![image](https://github.com/kevingaray/rails-store/assets/48739137/2810578e-4c69-4a61-b523-7779bce444c2)
Stripe view
![image](https://github.com/kevingaray/rails-store/assets/48739137/09086667-2575-4235-b5b1-4fa64e91579e)
Insomnia   
![image](https://github.com/kevingaray/rails-store/assets/48739137/ccabdd7c-b815-4a31-bf44-ca06adda0aa7)
![image](https://github.com/kevingaray/rails-store/assets/48739137/1d9883ee-530d-481a-9025-10417867f860)


