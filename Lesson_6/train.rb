class Train
  include Manufacturer
  include InstanceCounter

  attr_reader :number, :type, :cars, :curr_station, :next_station, :prev_station
  attr_accessor :route, :speed

  @@trains = []

  TRAIN_NUMBER = /^(\d|[a-z]){3}-?(\d|[a-z]){2}$/i

  def initialize(number, type)
    @number = number.to_s
    @type = type
    self.validation!

    @speed = 0
    @cars = []
    @@trains << self
  end

  def self.find(number)
    @@trains.find {|t| t.number == number }
  end

  def add_car(car)
    @cars << car if car.type == @type && @speed == 0
  end

  def remove_car(car)
    @cars.delete(car) if @speed == 0
  end

  def set_route(route)
    @route = route
    @curr_station = route.stations.first
    @curr_station.recieve(self)
  end

  def move(direction)
    current = route.stations.index(@curr_station)
    current += 1 if direction == "forward"
    current -= 1 if direction == "backward"

    @curr_station = route.stations[current]
    @next_station = route.stations[current + 1]
    @prev_station = route.stations[current - 1]

    @prev_station.send(self)
    @curr_station.recieve(self)
  end

  def valid?
    self.validation!
    true
  rescue RuntimeError
    false
  end

  protected
  def validation!
    raise "Invalid train number!" if @number !~ TRAIN_NUMBER
    raise "Train type unset!" if @type != "passenger" && @type != "cargo"
  end

end



