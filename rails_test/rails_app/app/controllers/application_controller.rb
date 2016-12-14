class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def hello
   render html: "Rails app demo with at_your_service gem"
   TestStrictService.call test: true
   TestNonStrictService.call
  end
end
