# Tea-Time

Tea-Time is a backend application for a tea subscription service. It inclues customers and their subscriptions, as well as teas that can be added to the subscription.

## Table of Contents

- [Getting Started](#getting-started)
- [Plans](#Plans)
- [Database Schema](#database-schema)
- [Endpoints](#endpoints)
- [Testing](#testing)
- [Author](#author)

## Getting Started

Clone repo to your local machine and run:
```
bundle install
rails db:{create,migrate}
```
## Plans

Currently Tea-Time has 3 levels of subscriptions.
  * Economy. Only $9.99 with 1 delivery a month.
  * Standard. Only $19.99 with 2 deliveries a month.
  * Economy. Only $24.99 with 4 deliveries a month.

## Database Schema

![Screen Shot 2021-06-02 at 2 03 57 PM](https://user-images.githubusercontent.com/62969459/120664075-dd552900-c447-11eb-85d6-0c30e45f8810.png)

## Endpoints
`POST /api/v1/subscriptions`
Creates a new subscription. The request needs to include the title of the plan (economy, standard, zen), and the customer's id number in the body of the request formatted in JSON.
```
{
  "title": "economy",
  "customer_id": "26"
}
```

The response status will be `201`  and will be formatted in JSON as well.
```
{
    "data": {
        "id": "1",
        "type": "subscription",
        "attributes": {
            "title": "economy",
            "price": 9.99,
            "status": "active",
            "frequency": "monthly"
        }
    }
}
```
---
`DELETE /api/v1/subscriptions`
Cancels a subscription. The request must include the subscriptions id formatted in JSON.
```
{
  "subscription_id": "1"
}
```
The response will be a `204` status code.

---
`GET /api/v1/customer/:id/subscriptions`
Returns a list of all of the customer's subscriptions active and canceled. The customer's id must come through the URI.

The response will be an array of the subscriptions.
```
{
    "data": [
        {
            "id": "1",
            "type": "subscription",
            "attributes": {
                "title": "economy",
                "price": 9.99,
                "status": "canceled",
                "frequency": "monthly"
            }
        },
        {
            "id": "2",
            "type": "subscription",
            "attributes": {
                "title": "standard",
                "price": 19.99,
                "status": "active",
                "frequency": "bi_weekly"
            }
        }
    ]
}
```

## Testing

This application was developed using TDD with the test suite RSpec. To run the etire suite run `bundle exec rspec` from the command line. Test coverage was tracked with SimpleCov, and has 100% coverage.

## Author

* **Megan Gonzales** 
-[linkedin](https://www.linkedin.com/in/megan-e-gonzales/) 
-[github](https://github.com/MGonzales26)
