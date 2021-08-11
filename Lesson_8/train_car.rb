# frozen_string_literal: false

class TrainCar
  include Manufacturer

  attr_reader :type, :occupied_space

  def initialize(type, volume)
    @volume = volume
    @type = type
    validate!

    @occupied_space = 0
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  def validate!
    errors = []

    errors <<  'Train car type unset!' if @type != :passenger && @type != :cargo
    errors <<  'Car volume incorrect!' if @volume <= 0

    raise errors.join('; ') unless errors.empty?
  end

  def free_space
    @volume - occupied_space
  end
end
