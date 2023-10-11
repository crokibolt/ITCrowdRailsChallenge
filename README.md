# IT Crowd Rails Challenge

## Summary
Fullstack Rails app for the IT Crowd Rails Challenge, to visit the deployed app click [here](https://bookstore-je2f.onrender.com). <br>
All the modules are implemented, the public frontend allows to search a book as stated in the challenge, the backroom allows you to execute all of the crud operations and a simple filtering was implemented in all of the products list. The extra of modifying the books prices by publisher was also implemented. The api allows you to perform all of the crud operation on the Books and the filtering is implemented through queries in the index url.

## Run locally
To run the repo locally you need to have postgres installed and execute the following commands after cloning.

```bash
  $./bin/bundle install
  $./bin/rails talwind:install
  $./bin/rails db:prepare
  $./bin/rails server
```

The public frontend is accessed in the root path, the backroom endpoint is reached by adding the prefix /backroom to your route (i.e. localhost:300/backroom/books), and you can send requests to the api by using the prefix /api.

## Resources 

* [Devise](https://github.com/heartcombo/devise) for authentication.
* [Kaminari](https://github.com/kaminari/kaminari) for pagination.
* [Faker](https://github.com/faker-ruby/faker) for data seeding.
* [GoodJob](https://github.com/bensheldon/good_job) to handle ActiveJob queues.
* [Tailwind](https://tailwindcss.com/) for styling.
* Icon from [flaticon](https://www.flaticon.com/free-icons/book)
