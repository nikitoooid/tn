# frozen_string_literal: false

class CargoCar < TrainCar
  def initialize(volume)
    super(:cargo, volume)
  end

  def take_a_volume(volume)
    @occupied_space += volume if free_space >= volume
  end
end
