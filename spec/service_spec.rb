require "spec_helper"

module AtYourService

describe "#call" do

 let(:dummy_class) { Class.new { include AtYourService } }
  it "included in dummy_class" do
    expect(dummy_class).to include (AtYourService)
  end
 end
end