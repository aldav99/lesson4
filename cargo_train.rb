require_relative 'train'

class CargoTrain < Train

  def initialize(name, wagons = [], route = [])
    super(name, :cargo, wagons, route)
  end
end