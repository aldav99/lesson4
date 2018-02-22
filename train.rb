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
    return if self.speed > 0
    return if self.type != wagon.type
    @wagons << wagon
  end

  def deattach_wagon
    @wagons.pop if @speed == 0
  end

  def route=(route)
    @route = route
    @index_location = 0
    current_station.add_train(self)
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
  
  def back_station
    return if current_station == @route.start
    @route.stations[@index_location - 1]
  end

  def next_station
    return if current_station == @route.terminate
    @route.stations[@index_location + 1]
  end
end  