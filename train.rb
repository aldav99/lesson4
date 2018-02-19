require_relative 'station'
require_relative 'route'

class Train

  attr_reader :name, :type, :speed
  
  def initialize(name, type, wagons = [], route = [])
    @name = name
    @type = type
    @wagons = wagons
    @speed = 0
    @route = route
  end
  
  

  def change_speed(speed_delta)
    @speed = [@speed + speed_delta, 0].max
  end

  def wagons
    @wagons 
  end

  def stop
    @speed = 0
  end

  def attach_wagon(wagon)
    return if self.type != wagon.type
    self.speed > 0 ? "Нужно остановиться" : @wagons << wagon
  end

  def deattach_wagon
    @wagons.pop if @speed == 0 && @wagons.any?
  end

  def route=(route)
    @route = route
    @index_location = 0
    @route.start.add_train(self)
  end

  def go_forward
    return if current_station == @route.terminate
    current_station.delete_train(self)
    @index_location += 1
    current_station.add_train(self)
  end

  def go_back
    return if current_station == @route.start
    current_station.delete_train(self)
    @index_location -= 1
    current_station.add_train(self)
  end

  def current_station
    @route.stations[@index_location]
  end
  def current_station_name
    puts @route.stations[@index_location].name
  end
  def back_station
    return if current_station == @route.start
    @route.stations[@index_location - 1]
  end

  def next_station
    return if current_station == @route.terminate
    @route.stations[@index_location + 1]
  end
end  

class PassengerTrain < Train

  def initialize(name, type = "Пассажирский", wagons = [], route = [])
    @name = name
    @type = type
    @wagons = wagons
    @speed = 0
    @route = route
  end
end

class CargoTrain < Train
def initialize(name, type = "Грузовой", wagons = [], route = [])
    @name = name
    @type = type
    @wagons = wagons
    @speed = 0
    @route = route
  end
end

class PassengerWagon
  def type 
    @type = "Пассажирский"
  end
end

class CargoWagon
  def type 
    @type = "Грузовой"
  end
end