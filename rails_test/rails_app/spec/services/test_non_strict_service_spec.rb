require 'rails_helper'

RSpec.describe "TestNonStrictService" do

  it "return error object" do
    result = TestNonStrictService.call
    expect(result.success?).to equal false
  end

  it "return success object " do
    result = TestNonStrictService.call test: true
    expect(result.success?).to equal true
  end

  it "included at_your_service" do
    expect(TestNonStrictService).to include (AtYourService)
  end
end