# Coffeeshop

Ruby on Rails application for Coffeeshop.

## Quickstart

```console
  $ bundle
  $ rails db:create
  $ rails db:migrate
  $ bin/dev
```

## Requirements

-   Ruby version 3.0.3
-   Rails version 7.0.2
-   Postgresql

## Running Tests

```console
$ rspec
```

## Admin Dashboard

In admin dashboard, the admin can manage all the items and discounts.

https://haku-coffeeshop.herokuapp.com/admin

Login: admin@coffeeshop.com / password

# Items
The admin can manage all items here. Each item has the name and price (unit: cents)

# Discounts
The admin can create a new discount with different 2 items. You can't create new discount with the same items or existing discount's items.
The validation is working correctly.
Each discount has 2 items, discount amount(unit: %)

## Home page

In the home page, users can order the items. When users change the quantity on an item, the prices are changed real time in the footer.

https://haku-coffeeshop.herokuapp.com/
