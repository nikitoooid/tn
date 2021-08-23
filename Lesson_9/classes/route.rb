# frozen_string_literal: false

class Route
  include InstanceCounter
  include Validation
  include Accessors

  strong_attr_accessor :stations, Station

  validate :stations, :presence

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    validate!
  end

  def add_station(station)
    end_station = stations[-1]
    stations[-1] = station
    stations << end_station
  end

  def remove_station(station)
    stations.delete(station)
  end
end
