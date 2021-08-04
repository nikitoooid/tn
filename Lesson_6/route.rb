class Route
  include InstanceCounter
  
  attr_accessor :stations
  
  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    validate!
  end

  def add_station(station)
    end_station = self.stations[-1]
    self.stations[-1] = station
    self.stations << end_station
  end

  def remove_station(station)
    self.stations.delete(station)
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  def validate!
    errors = []

    errors << "Not enough stations on the route!" if self.stations.length < 2
    errors << "Error! Route is clear!" if self.stations.empty?

    raise errors.join("; ") unless errors.empty?
  end
end