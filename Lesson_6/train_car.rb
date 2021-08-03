class TrainCar
  include Manufacturer
  attr_reader :type
  def initialize(type)
    @type = type
    self.validation!
  end

  def valid?
    self.validation!
    true
  rescue RuntimeError
    false
  end

  protected
  def validation!
    raise "Train car type unset!" if @type != "passenger" && @type != "cargo"
  end
end