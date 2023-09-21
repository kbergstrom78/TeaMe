
# TeaMe

Welcome to the TeaMe API! This service is designed to facilitate and streamline the process of managing tea subscriptions for customers. Whether you are tracking monthly tea deliveries or any other recurring product or service, our API provides a robust solution to handle all your subscription needs.




## Authors

###  Kim Bergstrom [Github](https://github.com/kbergstrom78) | [LinkedIn](https://www.linkedin.com/in/kimberley-bergstrom/)


## Database Design
<img width="1033" alt="Screenshot 2023-09-18 at 3 37 46 PM" src="https://github.com/kbergstrom78/TeaMe/assets/124642113/d61c856f-1034-4344-a130-fc10027d6cd8">



## Tech Stack

**Server:** 
- Ruby (language)
- Rails API (framework) 


## Installation

### Prerequisites
- Ensure Ruby is installed on your local machine
- Bundler is used for managing Ruby gem dependencies
- PostgreSQL is the default relational database
    
### Clone the Repository
``` 
    gitclone git@github.com:kbergstrom78/TeaMe.git
    cd TeaMe 
```

```
    bundle install
```

### Database Setup
run ``` rails db:{drop,create,migrate,seed}```

### Startup
- Service is configured to startup locally using port 3000
- Start service by running the command:
    ``` rails s ```
## Running Tests

To run tests, run the following command

```bash
  bundle exec rspec
```


## Workflow Details
- Test Suite: Our tests are run using RSpec. 
- Linting & Code Quality: We use Rubocop to ensure code quality.
## API Endpoints

### Create a New Subscription

`POST /api/v1/customers/:customer_id/subscriptions?tea_id=:tea_id
`
#### URL Query Parameters

| Parameter| Type | Description |
| :------- | :--- | :-----------|
| `tea_id` | `integer` | ID of the tea to be included in the subscription |


| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `title` | `string` |  Subscription title |
| `price` | `float`  |  Subscription price |
| `status` | `string` | Subscription status  (e.g., "active") |
| `frequency` | `string` | Subscription frequency  (e.g., "monthly") |

#### Request
```json
{
  "subscription": {
    "title": "Chamomile Tea",
    "price": 20.0,
    "status": "active",
    "frequency": "monthly"
  }
}
```

#### Response
```json
{
    "message": "Subscription created successfully",
    "subscription": {
        "id": 12,
        "title": "Chamomile Tea",
        "price": 20.0,
        "status": "active",
        "frequency": "monthly",
        "created_at": "2023-09-21T19:34:46.470Z",
        "updated_at": "2023-09-21T19:34:46.470Z",
        "customer_id": 1
    }
}
```
### Cancel a Customer's Tea Subscription
`PATCH /api/v1/customers/:customer_id/subscriptions/:id
`
| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `status` | `string` |  New status for the subscription (e.g., "cancelled") |

#### Request
```json
{
  "status": "cancelled"
}
```
#### Response
```json
{
  "message": "Subscription cancelled successfully"
}
```

### See all of a Customer's Subscriptions(active and cancelled)
`GET /api/v1/customers/:customer_id/subscriptions
`
#### Response
```json
{
    "data": [
        {
            "id": "1",
            "type": "subscription",
            "attributes": {
                "id": 1,
                "title": "Yearly Lady Grey Box",
                "price": 20.01,
                "status": "cancelled",
                "frequency": "monthly",
                "customer_id": 1
            }
        },
        {
            "id": "11",
            "type": "subscription",
            "attributes": {
                "id": 11,
                "title": "Chamomile Tea",
                "price": 20.0,
                "status": "active",
                "frequency": "monthly",
                "customer_id": 1
            }
        },
        {
            "id": "12",
            "type": "subscription",
            "attributes": {
                "id": 12,
                "title": "Chamomile Tea",
                "price": 20.0,
                "status": "cancelled",
                "frequency": "monthly",
                "customer_id": 1
            }
        }
    ]
}
```
