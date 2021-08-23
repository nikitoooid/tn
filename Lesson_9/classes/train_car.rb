# frozen_string_literal: false

class TrainCar
  include Manufacturer
  include Validation

  attr_reader :type, :occupied_space

  validate :type, :presence
  validate :type, :type, Symbol

  validate :occupied_space, :presence
  validate :occupied_space, :type, Integer

  def initialize(type, volume)
    @volume = volume
    @type = type

    validate!

    @occupied_space = 0
  end

  def free_space
    @volume - occupied_space
  end
end
