# At Your Service
##### Service Objects made easy (& works great w/ Rails)

Model / View / Controller isn't enough for today's complex web applications. Encapsulate your business logic in Service objects so that when you write a piece of business logic, you only write it once.

Inspiration & How to Use Service Objects:

[Gourmet Service Objects --- by Brewhouse](http://brewhouse.io/blog/2014/04/30/gourmet-service-objects.html)

[Using Services to Keep Your Rails Controllers Clean and DRY --- by Engine Yard](https://blog.engineyard.com/2014/keeping-your-rails-controllers-dry-with-services)

[7 Patterns to Refactor Fat ActiveRecord Models --- by Code Climate (see #2)](http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/)

[Service objects in Rails will help you design clean and maintainable code. Here's how. --- via netguru](https://www.netguru.co/blog/service-objects-in-rails-will-help)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'at_your_service'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install at_your_service

## Example

Adding a user's Credit Card is a common piece of business logic. The below example uses [Stripe](https://stripe.com/) to do so. By having this logic in a Service, whether it is an admin manually adding a new Credit Card for a User OR the User adding it themselves in the checkout flow, the logic will be exactly the same. Though the Renter object is the primary Active Record model involved, having this method as part of the Renter model would lead to that class being massive and unwieldy. It is much better as a standalone service, as shown below.

```ruby
class AddCard
  include AtYourService.with(strict: true)

  attribute :renter, Renter
  attribute :token, String
  attribute :agent_name, String

  UPDATE_RENTER_CUSTOMER_ID_ERROR = 'Could not associate Stripe data with Renter'

  def call
    begin
      customer = nil
      cards = []
      if renter.stripe_customer_id
        # Add card to customer
        customer = Stripe::Customer.retrieve(renter.stripe_customer_id)
        cards << customer.sources.create(source: token)
      else
        # Create new customer w/ card
        customer = Stripe::Customer.create(
          source: token,
          email: renter.email,
          description: "#{renter.full_name} - ##{renter.id} - created by #{agent_name}"
        )
        unless customer && renter.update(stripe_customer_id: customer.id)
          Rails.logger.error "New Stripe Customer #{customer.inspect} could not be associated with Renter #{renter.inspect}"
          return Error.new(UPDATE_RENTER_CUSTOMER_ID_ERROR)
        end
      end
      cards += customer.sources.data
      return Success.new(renter: ::Web::RenterStripeDecorator.new(renter), cards: cards)
    rescue Stripe::CardError => e
      return Error.new(e.json_body[:error][:message])
    end
  end
end
```

## Setup

1. create directory app/services.
2. Add `config.autoload_paths += Dir["#{config.root}/app/services"]` to config/application.rb.
3. That's it! You are now ready to write your first Service


## How to Write a Service

1. Create a class in the `app/services` directory
2. Include AtYourService
3. Define Attributes (strict or lenient) via the [Virtus Gem](https://github.com/solnic/virtus)
4. Create the `call` method
5. Write your Business Logic (+ private helper methods)
6. Return a `Success` or `Error` object

##### Create a class in the `app/services` directory
Name your class with what the service does. If it's adding a credit card, call it `AddCard`. If it's generating a quote, call it `GenerateQuote`, etc.

##### Include AtYourService
Include the AtYourService module via `include AtYourService`

##### Define Attributes
With attributes, we clearly define the data that Service needs including the types. With [Strict Coercion mode](https://github.com/solnic/virtus#strict-coercion-mode) from Virtus, an error will be thrown if the inputted arguments cannot be coerced into the desired type (so no nils as arguments). By default, strict coercion mode is off and you can have nil attributes. To use strict coercion mode, modify your AtYourService include to be `include AtYourService.with(strict: true)`

##### Create the `call` Method
At Your Service flavored service objects always define `call`. This prevents the awkwardness of having to name both your service class and it's method (stuff like `AddCard.add_card`). Now just name your class for what the service does (AddCard, SendInvite, MarkActiveReservation, ReturnProduct etc.) and then you always know you call it with `.call`.

##### Write your Business Logic
Inside `call`, define your business logic. Reference attributes by name, so `attribute :user` would just be `user` inside `call`. Go wild here, Service objects are meant to house the complex business logic of your application. For convenience, you can define private helper methods below call like usual.

##### Return a `Success` or `Error` object
Again, with At Your Service we are all about consistency. Every Service should return either a `Success` or `Error` object and pass into it the appropriate data (for Success) or error messages (for Error). Take a look at the source of these two classes. They're very simple. For convenience, `Error.new` accepts either a string or array of string error messages. With Success you can pass in any data you want, but usually a hash `{user: user, order: order}` works best.

## Rails API Example
Services are a great way to shrink your Rails controllers. Rather than having messy business logic in your controller, just offload it to a reusable Service that can be called across your codebase. I have many 2-line controller methods like so:

```ruby
class OrderWizardController < ApplicationController
  def generate_quote
    result = GenerateQuote.call(params)
    render json: result.display
  end

  def accept_quote
    result = AcceptQuote.call(params)
    render json: result.display
  end

  def remove_line_item
    result = RemoveLineItem.call(params)
    render json: result.display
  end
  # ... etc ...
end
```

## Questions?
At Your Service is a new gem. If any of the above documentation is confusing, unclear or insufficient please let me know! I am always available via email at ben@bengelsey.com to help you out :)

## Contributing to At Your Service

#### Running the Tests
   $ rspec
#### Running the Rails Tests
   $ cd rails_test/rails_app/

   $ rspec

PRs and Issues are always welcome!

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

