class TestNonStrictService
  include AtYourService.with

  attribute :test, Boolean

  TEST_ERROR = "Test example error"
  TEST_SUCCESS = "Test example success"

  def call
    if test
     return Success.new(TEST_SUCCESS)
    else
     return Error.new(TEST_ERROR)
    end
  end
end
