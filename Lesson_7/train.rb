class Train
  include Manufacturer
  include InstanceCounter

  attr_reader :number, :type, :cars, :current_station, :next_station, :previous_station, :route, :speed
  
  @@trains = []

  TRAIN_NUMBER = /^(\d|[a-z]){3}-?(\d|[a-z]){2}$/i

  def initialize(number, type)
    @number = number.to_s
    @type = type
    validate!

    @speed = 0
    @cars = []
    @@trains << self
  end

  def self.find(number)
    @@trains.find {|t| t.number == number }
  end

  def add_car(car)
    @cars << car if car.type == self.type && self.speed == 0
  end

  def remove_car(car)
    self.cars.delete(car) if self.speed == 0
  end

  def set_route(route)
    @route = route
    @current_station = route.stations.first
    self.current_station.recieve(self)
  end

  def move(direction)
    current = self.route.stations.index(self.current_station)
    current += 1 if direction == "forward"
    current -= 1 if direction == "backward"

    @current_station = self.route.stations[current]
    @next_station = self.route.stations[current + 1]
    @previous_station = self.route.stations[current - 1]

    self.previous_station.send(self)
    self.current_station.recieve(self)
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  def validate!
    errors = []

    errors << "Invalid train number!" if self.number !~ TRAIN_NUMBER
    errors << "Train type unset!" if self.type != "passenger" && self.type != "cargo"

    raise errors.join("; ") unless errors.empty?
  end

  def each_car_to_block(block)
    self.cars.each_with_index { |car, i| block.call(car, i) }
  end

end



