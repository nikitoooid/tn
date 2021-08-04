class Station
  include InstanceCounter

  attr_reader :name, :trains
  
  @@stations = []

  def initialize(name)
    @name = name
    validate!

    @trains = []
    @@stations << self
  end

  def self.all
    @@stations
  end

  def recieve(train)
    @trains << train
  end

  def send(train)
    @trains.delete(train)
  end

  def trains_by_type(type)
    result = []
    @trains.each { |train| result << train if train.type == type }
    result
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  def validate!
    errors = []

    errors <<  "Invalid station name!" if @name == ""

    raise errors.join("; ") unless errors.empty?
  end

end