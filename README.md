# README

## Database Schema 
![image](https://github.com/kbergstrom78/TeaMe/assets/124642113/aa72089d-cc4e-4691-9100-e48d51852e55)



## API Endpoints

#### Create a New Subscription

`http
  POST api/v1/customers/:customer_id/teas/:tea_id/subscribe
`

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `title` | `string` |  Subscription title |
| `price` | `float`  |  Subscription price |
| `status` | `string` | Subscription status |
| `frequency` | `string` | Subscription frequency |

#### Cancel a Customer's Tea Subscription
`http
  DELETE api/v1/customers/:customer_id/subscriptions/:subscription_id
`
#### See all of a Customer's Subscriptions both active and inactive
`http
  GET api/v1/customers/:customer_id/subscriptions
`
| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `title` | `string` |  Subscription title |
| `price` | `float`  |  Subscription price |
| `status` | `string` | Subscription status |
| `frequency` | `string` | Subscription frequency |
| 'customer_id'| 'integer | Customer ID number |
<br>

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
