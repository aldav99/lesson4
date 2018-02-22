class Route
  
  attr_reader :stations

  def initialize(start, terminate)
    @stations = [start, terminate]
  end
  
  def start
    @stations[0] 
  end

  def terminate
    @stations[-1]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end
  
  def delete_station(name)
    return if start.name == name || terminate.name == name
    @stations.delete_if {|station| station.name == name }
  end
end