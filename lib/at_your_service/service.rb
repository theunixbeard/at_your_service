module AtYourService
  extend ActiveSupport::Concern

  def self.with(options = {})
   @@strict = options.fetch(:strict, false)
   return self
  end

  included do
    if @@strict
      include Virtus.model(strict: true)
    else
      include Virtus.model
    end

    def self.call(*args)
      new(*args).call
    end
  end
end
