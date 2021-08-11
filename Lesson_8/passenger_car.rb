# frozen_string_literal: false

class PassengerCar < TrainCar
  def initialize(seats)
    super(:passenger, seats)
  end

  def take_a_seat
    @occupied_space += 1 if free_space.positive?
  end
end
