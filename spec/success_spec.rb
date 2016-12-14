require "spec_helper"
require "at_your_service/success"

describe Success do

let(:success) { Success.new("Success Example") }

  it "false for success?" do
    result = success.success?
    expect(result).to eq true
  end


  it "should return json" do
    result = success.display
    expect(result).to eq({"success": true,
    	                    "data": "Success Example" })
  end
end
