# frozen_string_literal: false

class CargoTrain < Train
  @trains = []

  def initialize(number)
    super(number, :cargo)
  end
end
