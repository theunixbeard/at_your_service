require 'rails_helper'

RSpec.describe "TestStrictService" do

  it "return false value for error object" do
    result = TestStrictService.call test: false
    expect(result.success?).to equal false
  end

  it "return true value for success object" do
    result = TestStrictService.call test: true
    expect(result.success?).to equal true
  end

  it "included at_your_service" do
    expect(TestStrictService).to include (AtYourService)
  end
end
