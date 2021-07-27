class Station
    attr_reader :name, :trains

    def initialize(name)
        @name = name
        @trains = []
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
end