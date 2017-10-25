require 'spec_helper'
require 'at_your_service/success'

describe Success do

let(:success) { Success.new('Success Example') }

  it 'is successful' do
    result = success.success?
    expect(result).to eq true
  end


  it 'returns json' do
    result = success.display
    expect(result).to eq({'success': true,
    	                    'data': 'Success Example' })
  end
end
