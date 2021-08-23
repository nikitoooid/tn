# frozen_string_literal: false

class PassengerTrain < Train
  @trains = []

  def initialize(number)
    super(number, :passenger)
  end
end
