require 'spec_helper'

module AtYourService

  describe '#call' do
    let(:dummy_class) { Class.new { include AtYourService } }

    it 'is included without errors' do
      expect(dummy_class).to include (AtYourService)
    end
  end
end
