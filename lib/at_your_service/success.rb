class Success
  attr_reader :data
  def initialize(data)
    @data = data
  end

  def success?
    true
  end

  def display
    {
      success: true,
      data: @data
    }
  end
end