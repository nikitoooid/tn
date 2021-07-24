class Station
    attr_reader :name, :all_trains

    def initialize(name)
        @name = name
        @all_trains = []
    end

    def recieve(train)
        @all_trains << train
    end

    def send(train)
        @all_trains.delete(train)
    end

    def trains_by_type(type)
        result = []
        @all_trains.each { |train| result << train if train.type == type }
        result
    end
end

class Route
    attr_reader :stations

    def initialize(start_station, fin_station)
        @start_station = start_station
        @fin_station = fin_station
        @stations = [@start_station, @fin_station]
    end

    def add_station(station)
        @stations[-1] = station
        @stations << fin_station
    end

    def remove_station(station)
        @stations.delete(station)
    end

    def show
        @stations.each{ |station| puts station.name }
    end
end

class Train
    attr_reader :number, :type, :cars, :curr_station, :next_station, :prev_station
    attr_accessor :route, :speed    #позволяет набирать, сбрасывать и отображать скорость

    def initialize(number, type, cars)
        @number = number.to_s
        @type = type
        @cars = cars
        @speed = 0
    end

    def add_car
        @cars += 1 if @speed == 0
    end

    def remove_car
        @cars -= 1 if @speed == 0
    end

    def set_route(route)
        @route = route
        @curr_station = route.stations.first
    end

    def move(direction)
        current = route.stations.index(@curr_station)
        current += 1 if direction == "forward"
        current -= 1 if direction == "backward"

        @curr_station = route.stations[current]
        @next_station = route.stations[current + 1]
        @prev_station = route.stations[current - 1]
    end
end