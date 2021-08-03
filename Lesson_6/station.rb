class Station
  include InstanceCounter
  attr_reader :name, :trains
  @@stations = []

  def initialize(name)
    @name = name
    self.validation!
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
    self.validation!
    true
  rescue RuntimeError
    false
  end

  protected
  def validation!
    raise "Invalid station name!" if @name == ""
  end

end