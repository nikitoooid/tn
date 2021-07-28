class Train
  attr_reader :number, :type, :cars, :curr_station, :next_station, :prev_station
  attr_accessor :route, :speed

  #тут все методы public, ибо используются в подклассах

  def initialize(number, type)
    @number = number.to_s
    @type = type
    @speed = 0
    @cars = []
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
end



