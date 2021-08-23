# frozen_string_literal: false

class Train
  include Manufacturer
  include InstanceCounter
  include Validation

  attr_reader :number, :type, :cars, :current_station, :next_station, :previous_station, :speed, :route

  TRAIN_NUMBER = /^(\d|[a-z]){3}-?(\d|[a-z]){2}$/i.freeze

  validate :number, :presence
  validate :number, :format, TRAIN_NUMBER

  validate :type, :presence
  validate :type, :type, Symbol

  @trains = []

  def initialize(number, type)
    @number = number.to_s
    @type = type

    validate!

    @speed = 0
    @cars = []
    self.class.add_to_train_list
  end

  def self.find(number)
    @trains.find { |t| t.number == number }
  end

  def add_car(car)
    @cars << car if car.type == type && speed.zero?
  end

  def remove_car(car)
    cars.delete(car) if speed.zero?
  end

  def route=(route)
    @route = route
    @current_station = route.stations.first
    current_station.recieve_train(self)
  end

  def move(direction)
    current = route.stations.index(current_station)
    direction == :forward ? current += 1 : current -= 1

    actualize_stations(current)

    previous_station.send_train(self)
    current_station.recieve_train(self)
  end

  def actualize_stations(current_station_index)
    @current_station = route.stations[current_station_index]
    @next_station = route.stations[current_station_index + 1]
    @previous_station = route.stations[current_station_index - 1]
  end

  def each_car_to_block(block)
    cars.each_with_index { |car, i| block.call(car, i) }
  end

  def self.add_to_train_list
    @trains << self
  end
end
