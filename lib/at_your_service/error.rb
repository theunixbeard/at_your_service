class Error
  attr_reader :errors
  # Pass 1 string or array of strings
  def initialize(errors = nil)
    errors = [] unless errors
    @errors = [errors].flatten # handle array or string
  end

  def error_message
    errors[0]
  end

  def success?
    false
  end

  def display
    {
      success: false,
      errors: @errors
    }
  end
end
