class Todo
  attr_reader :desc, :status

  def initialize(desc, status = false)
    @desc = desc
    @status = status
  end

  def toggle
    self.class.new(@desc, !@status)
  end
end
