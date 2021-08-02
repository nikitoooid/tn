class Route
  include InstanceCounter
  attr_reader :stations
  def initialize(start_station, fin_station)
    @start_station = start_station
    @fin_station = fin_station
    @stations = [@start_station, @fin_station]
  end

  def add_station(station)
    @stations[-1] = station
    @stations << @fin_station
  end

  def remove_station(station)
    @stations.delete(station)
  end

  def show
    @stations.each{ |station| puts station.name }
  end
end