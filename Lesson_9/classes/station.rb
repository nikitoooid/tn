# frozen_string_literal: false

class Station
  include InstanceCounter
  include Validation

  attr_reader :name, :trains

  @stations = []

  validate :name, :presence

  def initialize(name)
    @name = name

    validate!

    @trains = []
    self.class.add_to_station_list
  end

  def self.all
    @stations
  end

  def recieve_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def trains_by_type(type)
    result = []
    trains.each { |train| result << train if train.type == type }
    result
  end

  def each_train_to_block(block)
    trains.each { |train| block.call(train) }
  end

  def self.add_to_station_list
    @stations << self
  end
end
