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
![image](https://github.com/kevingaray/rails-store/assets/48739137/f9c29cf0-7723-44cc-a4ac-a29f9cc5d7b6)
Item page with image on AWS
![image](https://github.com/kevingaray/rails-store/assets/48739137/6fb3e06d-ffa7-465e-aa6f-61e7937a3b82)
Cart view
![image](https://github.com/kevingaray/rails-store/assets/48739137/6ae84dcd-02e8-419a-85fa-005cbe9215c1)
Stripe view
![image](https://github.com/kevingaray/rails-store/assets/48739137/79109853-723b-4023-94ea-574e0bb9aac1)
Insomnia   
![image](https://github.com/kevingaray/rails-store/assets/48739137/786a7781-77ca-488b-bf17-7b615d7fe006)



