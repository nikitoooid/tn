class PassengerCar < TrainCar

  def initialize(seats)
    super("passenger", seats)
  end

  def take_a_seat
    @occupied_space += 1 if free_space > 0
  end

end