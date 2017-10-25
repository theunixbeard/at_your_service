require 'spec_helper'
require 'at_your_service/error'

describe Error do

  let(:error) { Error.new('Error Example') }

  it 'is not successful' do
    result = error.success?
    expect(result).to eq false
  end


  it 'returns an error_message' do
    result = error.error_message
    expect(result).to eq('Error Example')
  end

  it 'returns json' do
    result = error.display
    expect(result).to eq({'success': false,
    	                    'errors': ['Error Example'] })
  end
end
