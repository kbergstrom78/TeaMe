
# TeaMe

Welcome to the TeaMe API! This service is designed to facilitate and streamline the process of managing tea subscriptions for customers. Whether you are tracking monthly tea deliveries or any other recurring product or service, our API provides a robust solution to handle all your subscription needs.




## Authors

###  Kim Bergstrom [Github](https://github.com/kbergstrom78) | [LinkedIn](https://www.linkedin.com/in/kimberley-bergstrom/)



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

`POST /api/v1/customers/:customer_id/subscriptions
`

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `title` | `string` |  Subscription title |
| `price` | `float`  |  Subscription price |
| `status` | `string` | Subscription status  (e.g., "active") |
| `frequency` | `string` | Subscription frequency  (e.g., "monthly") |

#### Request
```json
{
  "title": "Subscription Title",
  "price": 19.99,
  "status": "active",
  "frequency": "monthly"
}
```

#### Response
```json
{
  "subscription": {
    "title": "Subscription Title",
    "price": 19.99,
    "status": "active",
    "frequency": "monthly"
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
  "subscriptions": [
    {
      "title": "Subscription Title",
      "price": 19.99,
      "status": "active",
      "frequency": "monthly"
    } 
  ]
}
```
