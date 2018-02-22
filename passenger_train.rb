require_relative 'train'

class PassengerTrain < Train

  def initialize(name, wagons = [], route = [])
    super(name, :passenger, wagons, route)
  end
end