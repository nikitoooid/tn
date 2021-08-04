class TrainCar
  include Manufacturer

  attr_reader :type

  def initialize(type)
    @type = type
    validate!
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  def validate!
    errors = []

    errors <<  "Train car type unset!" if @type != "passenger" && @type != "cargo"

    raise errors.join("; ") unless errors.empty?
  end
end