class Todo
  attr_reader :desc, :status

  def initialize(desc, status)
    @desc = desc
    @status = status
  end

  def toggle
    self.class.new(@desc, !@status)
  end
end
